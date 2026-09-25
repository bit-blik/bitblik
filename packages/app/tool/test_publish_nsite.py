"""Offline regression checks for publish_nsite.sh's signing identity guard.

Run with: python3 -m unittest discover -s packages/app/tool -p 'test_*.py'
"""

import json
import os
from pathlib import Path
import socket
import subprocess
import tempfile
import time
import unittest


SCRIPT = Path(__file__).with_name("publish_nsite.sh").resolve()
BITWAY = "3be722c78093192b4064e9ba23a6c5419ce5a1fa41bf66d3101cb43025110def"
BITBLIK = "b450f2a87f1327e9a5628c979286c6d4441f3e93bf8e3d5e4196e944c91e1ab0"

STUB = r'''#!/usr/bin/env python3
import hashlib, json, os, pathlib, sys
name = pathlib.Path(sys.argv[0]).name
args = sys.argv[1:]
def value(flag):
    return args[args.index(flag) + 1]
with open(os.environ['TEST_CALLS'], 'a') as log:
    # Tests use only a dummy credential. Never log real credentials.
    log.write(json.dumps([name, args]) + '\n')
if name == 'nak':
    if 'decode' in args:
        print(os.environ['TEST_EXPECTED'])
    elif 'req' in args:
        print(json.dumps({'tags': [['path', '/app/index.html',
            hashlib.sha256(b'app').hexdigest() if os.environ.get('TEST_UNCHANGED') else '0'*64]]}))
elif name == 'nsyte':
    if '--dry-run-output' in args:
        if os.environ.get('TEST_AUTH_FAIL'):
            sys.exit(1)
        target = pathlib.Path(value('--dry-run-output'))
        target.mkdir()
        event = {'kind': 15128, 'pubkey': os.environ['TEST_SIGNER'], 'tags': []}
        if os.environ.get('TEST_BAD_PREVIEW'):
            event.pop('pubkey')
        (target / 'put-manifest-15128.json').write_text(json.dumps(event))
elif name == 'docker':
    if args[0] == 'create':
        print('test-container')
    elif args[0] == 'cp':
        (pathlib.Path(args[-1]) / 'index.html').write_text('app')
'''


class PublishIdentityTest(unittest.TestCase):
    def run_script(self, signer=BITWAY, extra=(), **settings):
        with tempfile.TemporaryDirectory(prefix="nsite-test-") as directory:
            work = Path(directory)
            binaries = work / "bin"
            binaries.mkdir()
            for name in ("nak", "nsyte", "docker"):
                binary = binaries / name
                binary.write_text(STUB)
                binary.chmod(0o755)
            env = {
                key: value for key, value in os.environ.items()
                if not key.startswith(("NSITE_", "TEST_"))
            }
            env.update(
                PATH=f"{binaries}:{env['PATH']}",
                TMPDIR=directory,
                NSITE_SECRET="dummy-test-credential",
                TEST_CALLS=str(work / "calls.jsonl"),
                TEST_EXPECTED=BITWAY,
                TEST_SIGNER=signer,
            )
            env.update(settings)
            result = subprocess.run(
                ["bash", str(SCRIPT), "--flavor", "bitway", *extra],
                # Reproduce user's packages/app working directory.
                cwd=SCRIPT.parent.parent,
                env=env, text=True, capture_output=True, timeout=10,
            )
            calls_file = work / "calls.jsonl"
            calls = [json.loads(line) for line in calls_file.read_text().splitlines()] \
                if calls_file.exists() else []
            return result, calls

    def assert_no_writes(self, calls):
        self.assertFalse(any(name == "docker" for name, _ in calls))
        for name, args in calls:
            if name == "nsyte":
                self.assertIn("--dry-run", args)

    def test_wrong_key_stops_before_build_or_upload(self):
        result, calls = self.run_script(signer=BITBLIK)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Signing key mismatch for bitway", result.stderr)
        self.assertIn(BITWAY, result.stderr)
        self.assertIn(BITBLIK, result.stderr)
        self.assert_no_writes(calls)

    def test_dry_run_also_rejects_wrong_key(self):
        result, calls = self.run_script(signer=BITBLIK, extra=("--dry-run",))
        self.assertNotEqual(result.returncode, 0)
        self.assert_no_writes(calls)

    def test_unresolved_signer_fails_closed(self):
        result, calls = self.run_script(TEST_AUTH_FAIL="1")
        self.assertNotEqual(result.returncode, 0)
        self.assert_no_writes(calls)

    def test_unknown_preview_format_fails_closed(self):
        result, calls = self.run_script(TEST_BAD_PREVIEW="1")
        self.assertNotEqual(result.returncode, 0)
        self.assert_no_writes(calls)

    def test_correct_key_is_reused_and_only_app_path_updated(self):
        result, calls = self.run_script()
        self.assertEqual(result.returncode, 0, result.stderr)
        put_calls = [args for name, args in calls if name == "nsyte"]
        self.assertEqual(len(put_calls), 2)
        self.assertIn("--dry-run", put_calls[0])
        self.assertNotIn("--dry-run", put_calls[1])
        for args in put_calls:
            self.assertIn("/app/index.html", args)
            self.assertEqual(args[args.index("--sec") + 1], "dummy-test-credential")

    def test_unchanged_release_still_checks_identity(self):
        result, calls = self.run_script(TEST_UNCHANGED="1")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("Updated 0 changed", result.stdout)
        self.assertEqual(sum(name == "nsyte" for name, _ in calls), 1)

    def test_no_secret_dry_run_fails_before_build(self):
        result, calls = self.run_script(extra=("--dry-run",), NSITE_SECRET="")
        self.assertNotEqual(result.returncode, 0)
        self.assert_no_writes(calls)


@unittest.skipUnless(os.environ.get("NSITE_INTEGRATION") == "1", "optional local CLI check")
class NsytePreviewTest(unittest.TestCase):
    def test_real_cli_preview_reports_signer_pubkey(self):
        # Publicly known throwaway key, only an in-memory loopback relay.
        key = "0" * 63 + "1"
        expected = "79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798"
        with tempfile.TemporaryDirectory(prefix="nsite-cli-test-") as directory:
            work = Path(directory)
            with socket.socket() as sock:
                sock.bind(("127.0.0.1", 0))
                port = sock.getsockname()[1]
            event = subprocess.run(
                ["nak", "event", "--sec", key, "-k", "15128", "-c", "",
                 "-t", "path=/index.html;" + "0" * 64],
                check=True, capture_output=True, text=True, timeout=10,
            ).stdout
            seed = work / "events.jsonl"
            seed.write_text(event)
            config = work / "config.json"
            config.write_text(json.dumps({"relays": [f"ws://127.0.0.1:{port}"], "servers": []}))
            local_file = work / "index.html"
            local_file.write_text("test")
            relay = subprocess.Popen(
                ["nak", "serve", "--hostname", "127.0.0.1", "--port", str(port),
                 "--events", str(seed)], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
            )
            try:
                for _ in range(100):
                    try:
                        with socket.create_connection(("127.0.0.1", port), timeout=0.1):
                            break
                    except OSError:
                        time.sleep(0.05)
                preview = work / "preview"
                result = subprocess.run(
                    ["nsyte", "put", "--config", str(config), str(local_file),
                     "/app/index.html", "--sec", key, "--dry-run", "--dry-run-output", str(preview)],
                    capture_output=True, text=True, timeout=55,
                )
                self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
                parsed = json.loads((preview / "put-manifest-15128.json").read_text())
                self.assertEqual(parsed["kind"], 15128)
                self.assertEqual(parsed["pubkey"], expected)
                self.assertIsInstance(parsed["tags"], list)
            finally:
                relay.terminate()
                relay.wait(timeout=5)


if __name__ == "__main__":
    unittest.main()
