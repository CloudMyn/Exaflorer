import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/exceptions/test/test_exception.dart';
import 'package:filemanager/views/widgets/drawer_widget.dart';

class DevPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(title: Text("Mode Pengembang")),
      body: _Body(),
    );
  }

  // ...
}

class _Body extends StatefulWidget {
  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  final exceptionMessageCtrl = TextEditingController(text: 'TextException');
  final logSizeController = TextEditingController(text: (1024 * 5).toString());
  bool debugMode = false;

  __BodyState() {
    this.debugMode = App.debug;
  }

  @override
  Widget build(BuildContext context) {
    List items = _listItem(context);

    return Container(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: items.length,
        itemBuilder: (_, i) {
          return items[i];
        },
      ),
    );
  }

  List _listItem(BuildContext context) {
    List<Widget> items = [
      _listTile(
        title: TextFormField(
          controller: exceptionMessageCtrl,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 15,
            ),
            border: OutlineInputBorder(
              gapPadding: 0,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        icon: Tooltip(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          margin: EdgeInsets.symmetric(horizontal: 10),
          message: 'Log Test: Lemparkan sebuah exception',
          child: Icon(Icons.insights),
        ),
        button: OutlinedButton(
          child: Text('Throw'),
          onPressed: () {
            try {
              StackTrace s = StackTrace.current;
              throw TestException(exceptionMessageCtrl.text, s);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('$e berhasil dilempar'),
              ));
            }
          },
        ),
      ),
      _listTile(
        title: TextFormField(
          controller: logSizeController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 15,
            ),
            border: OutlineInputBorder(
              gapPadding: 0,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        icon: Tooltip(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          margin: EdgeInsets.symmetric(horizontal: 10),
          message:
              'Tentukan batas maximum file log, note: inputan dalam bentuk kilobyte 1024kb = 1mb',
          child: Icon(Icons.info_outline),
        ),
        button: OutlinedButton(
          child: Text('Ubah'),
          onPressed: () {},
        ),
      ),
      _listTile(
        title: Text(
          'Mode debug',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          'Peringatan: Jika Mode debug aktif pesan error tidak akan difilter...',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        icon: Tooltip(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          margin: EdgeInsets.symmetric(horizontal: 10),
          message: 'Jika mode debug aktif pesan error tidak akan difilter',
          child: Icon(Icons.bug_report_outlined),
        ),
        button: Switch(
          value: debugMode,
          onChanged: (bool nval) {
            setState(() {
              App.setDebug = nval;
              debugMode = nval;
              showSnackbar(
                context,
                'Mode debug: ' + (nval ? 'diaktifkan' : 'dinonaktifkan'),
              );
            });
          },
        ),
      ),
    ];

    return items;
  }

  Widget _listTile({
    Widget? title,
    Widget? subtitle,
    Widget? button,
    Widget? icon,
  }) {
    return Column(
      children: [
        ListTile(
          leading: icon,
          title: title,
          subtitle: subtitle,
          trailing: button,
        ),
        Divider(height: 15, thickness: 1),
      ],
    );
  }

  void showSnackbar(BuildContext ctx, String message) {
    ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  // ...
}
