import 'package:filemanager/exceptions/app_exception.dart';

class AppBlocException extends AppException {
  AppBlocException(String message, [stackTrace]) : super(message, stackTrace);
}
