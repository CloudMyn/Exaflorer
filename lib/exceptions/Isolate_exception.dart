import 'package:filemanager/exceptions/app_exception.dart';

class IsolateException extends AppException {
  IsolateException(
    String message, {
    StackTrace? stackTrace,
  }) : super(message, stackTrace);
}
