import 'package:filemanager/bootstrap.dart';

class ErrorStateWidget extends StatelessWidget {
  final String error;

  ErrorStateWidget(this.error);

  @override
  Widget build(BuildContext context) {
    String showMsg = App.debug ? error : '';
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Terjadi kesalahan',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600,
                color: Colors.red.shade400,
              ),
            ),
            Text(
              showMsg,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey.shade600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
