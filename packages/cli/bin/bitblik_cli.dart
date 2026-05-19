void main(List<String> args) {
  if (args.contains('--help') || args.contains('-h')) {
    print('BitBlik CLI');
    print('');
    print('Usage: bitblik [options]');
    print('');
    print('Options:');
    print('  -h, --help    Show this help message');
    return;
  }

  print('BitBlik CLI is ready.');
}
