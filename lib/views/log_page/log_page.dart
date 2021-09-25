import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/facades/log_facade.dart';
import 'package:filemanager/models/log_model.dart';
import 'package:filemanager/views/widgets/_widgets.dart';
import 'package:filemanager/views/widgets/drawer_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import './widgets/_widgets.dart';

class LogPage extends StatefulWidget {
  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('Log file'),
        actions: [
          Tooltip(
            message: 'Hapus log file',
            child: IconButton(
              onPressed: () async {
                Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "Hapus file log",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Batal",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: Color.fromRGBO(0, 179, 134, 1.0),
                    ),
                    DialogButton(
                      child: Text(
                        "Hapus",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () async {
                        bool result = await LogFacade.delete(context);
                        if (result) setState(() {});
                        Navigator.pop(context);
                      },
                      color: Colors.red.shade400,
                    )
                  ],
                ).show();
              },
              icon: Icon(Icons.delete_sweep_outlined),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<LogModel>>(
        future: LogFacade.getAppLog(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.length == 0) {
              return InfoStateWidget('Tidak ada log yang didapatkan!');
            }
            return _listBuilder(context, snapshot.data ?? []);
          } else if (snapshot.hasError) {
            return ErrorStateWidget(snapshot.error.toString());
          } else {
            return LoadingStateWidget();
          }
        },
      ),
    );
  }

  Widget _listBuilder(BuildContext context, List<LogModel> logs) {
    return ListView.builder(
      itemCount: logs.length,
      itemBuilder: (ctx, index) {
        LogModel log = logs[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                child: LogDetail(logs[index]),
                duration: Duration(milliseconds: 100),
                reverseDuration: Duration(milliseconds: 100),
                type: PageTransitionType.fade,
              ),
            );
          },
          child: Column(
            children: [
              ListTile(
                title: Text(
                  log.message,
                  style: TextStyle(
                    color: Colors.red.shade400,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "${log.formatDate()}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Divider(height: 0, thickness: 2),
            ],
          ),
        );
      },
    );
  }
}
