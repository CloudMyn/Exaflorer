import 'package:filemanager/bootstrap.dart';

class TestException extends AppException {
  TestException(String message, [StackTrace? s]) : super(message, s);
}
