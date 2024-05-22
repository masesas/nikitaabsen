import 'dart:developer' as dev;

abstract class LoggerUtils {
  static void printFullLog({
    String tag = 'debug_log',
    required dynamic message,
    bool isError = false,
  }) {
    dev.log('\n');
    dev.log('=====================================================');
    dev.log(
      '$message',
      name: tag,
      error: isError ? message : null,
    );
    dev.log('=====================================================');
    dev.log('\n');
  }
}
