import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/views/browse_page/widgets/widgets.dart';

class BrowsePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrowseAppBar(),
      body: ListDirectories(),
    );
  }

  // ...
}
