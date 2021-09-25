import 'package:filemanager/models/log_model.dart';
import 'package:filemanager/utils/log_handler.dart';

extension ExceptionExtention on Exception {
  Future<bool> log() async {
    String message = this.toString();
    StackTrace s = StackTrace.current;

    LogModel log = LogModel(
      message: message,
      stackTrace: (s).toString(),
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    LogHandler logger = new LogHandler();
    return await logger.log(log);
  }
}
