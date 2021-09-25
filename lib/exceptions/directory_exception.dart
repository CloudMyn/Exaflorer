import 'package:filemanager/exceptions/app_exception.dart';

class DirectoryException extends AppException {
  DirectoryException(
    String message, {
    StackTrace? stackTrace,
  }) : super(message, stackTrace);
}

class StorageError extends DirectoryException {
  StorageError(String message, {StackTrace? s})
      : super(message, stackTrace: s);
}
