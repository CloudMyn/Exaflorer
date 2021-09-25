import 'package:filemanager/exceptions/app_exception.dart';

class CoreException extends AppException {
  CoreException(
    String message, {
    StackTrace? stackTrace,
  }) : super(message, stackTrace);
}
