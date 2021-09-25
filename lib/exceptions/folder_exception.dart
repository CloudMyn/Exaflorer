import 'package:filemanager/exceptions/app_exception.dart';

class FolderException extends AppException {
  FolderException(
    String message, {
    StackTrace? stackTrace,
  }) : super(message, stackTrace);
}
