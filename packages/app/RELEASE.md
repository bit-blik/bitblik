# Release process

- increase version number in pubspec.yaml
- update changelog.md with the new version and all changes since last release

## iOS

- in macos do `flutter build ipa`

- submit to app store connect using transporter or xcode

- submit new version for review in app store connect

- `curl -X GET  https://api.altstore.io/adps/<apd-id>` (get the APD id from app store connect -> iOS History)

- fetch the package from the json field `downloadURL`

- unzip it into bitblik.app web html root / ios/<version-number>

- make sure files in /ios/<version-number>/ are readable by everyone (chmod 644)

- add version to https://bitblik.app/.well-known/sources/alt-store-source.json (not the one in git, but in the VPS /ios/...)

## Android

- push new tag to github with the version number
- wait for github action to build the apk and upload it to the releases page
- adjust github release changelog/what's new
- publish to zapstore `SIGN_WITH=<nsec> zsp publish`

## Web

todo