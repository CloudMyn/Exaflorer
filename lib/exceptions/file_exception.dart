import 'package:filemanager/exceptions/app_exception.dart';

class FileException extends AppException {
  FileException(
    String message, [
    StackTrace? stackTrace,
    bool logException = true,
  ]) : super(message, stackTrace, logException);
}

class FileCorrupted extends FileException {
  FileCorrupted(
    String message, {
    StackTrace? stackTrace,
    bool logException = true,
  }) : super(message, stackTrace, logException);
}

class FileNotFound extends FileException {
  FileNotFound(
    String message, {
    StackTrace? stackTrace,
    bool logException = true,
  }) : super(message, stackTrace, logException);
}

class FileAlreadyExist extends FileException {
  FileAlreadyExist(
    String message, {
    StackTrace? stackTrace,
    bool logException = true,
  }) : super(message, stackTrace, logException);
}

