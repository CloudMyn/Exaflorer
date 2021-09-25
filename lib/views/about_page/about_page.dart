import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/views/widgets/drawer_widget.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('About Us'),
      ),
    );
  }
}
