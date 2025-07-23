import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/models/_models.dart';
import 'package:filemanager/utils/log_handler.dart';
import 'package:filemanager/views/error_page/error_page.dart';

abstract class AppException implements Exception {
  final String message;
  final StackTrace? stacktrace;

  AppException(this.message, [this.stacktrace, bool logException = true]) {
    if (logException) this.logException();
  }

  void logException() {
    LogModel log = LogModel(
      message: this.message,
      stackTrace: (this.stacktrace ?? StackTrace.current).toString(),
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    LogHandler logger = new LogHandler();
    logger.log(log);
  }

  void toErrorPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) {
        return ErrorPage(message);
      }),
      ModalRoute.withName('/'),
    );
  }

  String toString() {
    return this.message;
  }
}
