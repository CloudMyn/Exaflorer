import 'package:filemanager/bootstrap.dart';

class InfoStateWidget extends StatelessWidget {
  final String message;

  InfoStateWidget(this.message);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      message,
      style: TextStyle(
        color: Colors.blueGrey.shade400,
        fontSize: 16,
      ),
    ));
  }
}
