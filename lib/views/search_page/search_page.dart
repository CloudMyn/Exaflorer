import 'package:filemanager/bootstrap.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temukan file/folder'),
      ),
      bottomSheet: BottomSheet(
        builder: (ctx) {
          return Column(
            children: [
              Text("Hallo wolrd"),
            ],
          );
        },
        onClosing: () {},
      ),
    );
  }
}
