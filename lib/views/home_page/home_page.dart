import 'dart:async';
import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/facades/_facades.dart';
import 'package:filemanager/views/widgets/_widgets.dart';
import 'package:filemanager/models/_models.dart';
import 'package:filemanager/views/home_page/widgets/widgets.dart';
import 'package:storage_mount_listener/storage_mount_listener.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: CommonWidgets.text('Beranda'),
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  StreamSubscription? storageSubscription;

  @override
  void initState() {
    super.initState();

    var strm = StorageMountListener.channel.receiveBroadcastStream();
    storageSubscription = strm.listen((event) => setState(() {}));

    // ...
  }

  @override
  void dispose() {
    super.dispose();
    storageSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StorageModel>>(
      future: StorageFacade.getStorages(),
      builder: (context, data) {
        // cek jika data sudah ada
        if (data.hasData == true) {
          List<StorageModel> storages = data.data ?? [];

          return ListView.builder(
            itemCount: storages.length,
            itemBuilder: (BuildContext ctx, int index) {
              StorageModel storage = storages[index];
              return Column(
                children: [
                  StorageCard(
                    name: storage.name,
                    icon: storage.icon,
                    path: storage.fullpath,
                    usedSpace: storage.usedSpace,
                    freeSpace: storage.freeSpace,
                    totalSpace: storage.totalSpace,
                  ),
                  Divider(
                    height: 0,
                    thickness: 1,
                  ),
                ],
              );
            },
          );
        } else {
          return SizedBox.expand(
            child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          );
        }

        // ...
      },
    );
  }

  // ...
}
