import 'package:filemanager/bootstrap.dart';

class LoadingStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(),
          ),
          Container(
            child: Text('Memuat...'),
            margin: EdgeInsets.only(top: 10),
          )
        ],
      ),
    );
  }
}
