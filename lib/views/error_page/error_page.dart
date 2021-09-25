import 'package:filemanager/bootstrap.dart';

class ErrorPage extends StatelessWidget {
  final String exception;

  ErrorPage(this.exception);

  @override
  Widget build(BuildContext context) {
    Color errorTextColor = Colors.red.shade500;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Terdapat kesalahan!!",
          style: TextStyle(color: errorTextColor),
        ),
      ),
      body: Center(
        child: Text(exception),
      ),
    );
  }
}
