class AppLogger {
  AppLogger.black(String text) {
    print('\x1B[30m$text\x1B[0m');
  }
  AppLogger.red(String text) {
    print('\x1B[31m$text\x1B[0m');
  }
  AppLogger.green(String text) {
    print('\x1B[32m$text\x1B[0m');
  }
  AppLogger.yellow(String text) {
    print('\x1B[33m$text\x1B[0m');
  }
  AppLogger.blue(String text) {
    print('\x1B[34m$text\x1B[0m');
  }
  AppLogger.magenta(String text) {
    print('\x1B[35m$text\x1B[0m');
  }
  AppLogger.cyan(String text) {
    print('\x1B[36m$text\x1B[0m');
  }
  AppLogger.white(String text) {
    print('\x1B[37m$text\x1B[0m');
  }

  static String blackText(String text) => '\x1B[30m$text\x1B[0m';
  static String redText (String text) => '\x1B[31m$text\x1B[0m';
  static String greenText (String text) => '\x1B[32m$text\x1B[0m';
  static String yellowText (String text) => '\x1B[33m$text\x1B[0m';
  static String blueText (String text) => '\x1B[34m$text\x1B[0m';
  static String magentaText (String text) => '\x1B[35m$text\x1B[0m';
  static String cyanText (String text) => '\x1B[36m$text\x1B[0m';
}