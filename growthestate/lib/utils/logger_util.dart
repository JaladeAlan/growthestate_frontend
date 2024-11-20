import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Number of stack trace levels to print
      errorMethodCount: 5, // Number of stack trace levels for errors
      lineLength: 80, // Width of output lines
      colors: true, // Colorful log messages
      printEmojis: true, // Emojis for log levels
    ),
  );

  static void d(String message) => _logger.d(message); // Debug
  static void i(String message) => _logger.i(message); // Info
  static void w(String message) => _logger.w(message); // Warning
  static void e(String message, [dynamic error, StackTrace? stackTrace]) =>
        _logger.e(message, error: error, stackTrace: stackTrace);
}
