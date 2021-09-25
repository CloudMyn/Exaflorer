import 'package:filemanager/bloc/_bloc.dart';
import 'package:filemanager/bloc/navigation/navigation_bloc.dart';
import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/facades/_facades.dart';
import 'package:filemanager/models/_models.dart';

class DrawerWidget extends StatelessWidget {
  // List of menus
  List<Map<String, dynamic>> getMenus(BuildContext context,
      {List<StorageModel>? storages}) {
    List<Map<String, dynamic>> _storages = [];

    for (StorageModel data in storages ?? []) {
      _storages.add({
        'title': Text(data.name),
        'icon': Icon(data.icon),
        'onTap': () {
          // set state to browstorage
          BlocProvider.of<DirectoryPathBloc>(context).add(
            PushNewPath(data.fullpath, []),
          );
          // navigate to browsepage
          BlocProvider.of<NavigationBloc>(context).add(ToBrowsePage(context));
        },
      });
    }

    List<Map<String, dynamic>> menus = [
      {
        'title': Text('Beranda'),
        'icon': Icon(Icons.home_outlined),
        'onTap': () {
          BlocProvider.of<NavigationBloc>(context).add(ToHomePage(context));
        },
      },
    ];

    menus.addAll(_storages);

    menus.add({
      'title': Text('Developer'),
      'icon': Icon(Icons.developer_mode),
      'onTap': () {
        BlocProvider.of<NavigationBloc>(context).add(ToDevPage(context));
      },
    });

    menus.add({
      'title': Text('Log'),
      'icon': Icon(Icons.list_alt_rounded),
      'onTap': () {
        BlocProvider.of<NavigationBloc>(context).add(ToLogPage(context));
      },
    });

    menus.add({
      'title': Text('Tentang  Kami'),
      'icon': Icon(Icons.info_outline),
      'onTap': () {
        BlocProvider.of<NavigationBloc>(context).add(ToAboutPage(context));
      },
    });

    return menus;
  }

  Future<List<StorageModel>> _getStorages() async {
    // await Future.delayed(Duration(milliseconds: 250));
    return StorageFacade.getStorages();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: FutureBuilder<List<StorageModel>>(
          future: _getStorages(),
          builder: (context, snapshot) {
            List<StorageModel> storages = snapshot.data ?? [];

            List<Map<String, dynamic>> menus =
                this.getMenus(context, storages: storages);

            return ListView.builder(
              itemCount: menus.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> menu = menus[index];
                return InkWell(
                  onTap: menu['onTap'],
                  child: ListTile(
                    title: menu['title'] as Widget,
                    leading: menu['icon'] as Widget,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
