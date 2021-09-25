import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/models/log_model.dart';

class LogDetail extends StatefulWidget {
  final LogModel log;
  const LogDetail(this.log);

  @override
  _LogPageDetailState createState() => _LogPageDetailState();
}

class _LogPageDetailState extends State<LogDetail> {
  @override
  Widget build(BuildContext context) {
    widget.log.stackTraceList().printItems();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.log.message),
      ),
      body: SingleChildScrollView(
        child: _buildStacktrace(),
      ),
    );
  }

  Column _buildStacktrace() {
    List<String> s = widget.log.stackTraceList();
    List<Widget> _sx = [];
    int i = 0;
    for (var _s in s) {
      i++;
      _sx.add(ListTile(
        leading: Container(child: Text(i.toString())),
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(_s),
        ),
      ));
    }
    return Column(children: _sx);
  }

  // ...
}
