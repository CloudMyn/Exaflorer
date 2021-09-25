import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/facades/_facades.dart';
import 'package:filemanager/models/_models.dart';
import 'package:filemanager/views/widgets/_widgets.dart';
import 'package:filemanager/views/browse_page/widgets/widgets.dart';

class ListDirectories extends StatelessWidget {
  Future<List<DirectoryEntity>> _getDirectoryEntities(String path) async {
    await Future.delayed(Duration(milliseconds: 0));
    return StorageFacade.geDirectoryEntities(path);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DirectoryPathBloc, DirectoryPathState>(
      builder: (context, state) {
        // --
        return FutureBuilder<List<DirectoryEntity>>(
          future: this._getDirectoryEntities(state.lastPath),
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return BlocBuilder<DirectorySelectBloc, DirectorySelectState>(
                  builder: (context, stateSelect) {
                return _listBuilder(
                    context, snapshot.data ?? [], state, stateSelect);
              });
            else if (snapshot.hasError)
              return ErrorStateWidget("Terjadi kesalahan!!");
            else
              return LoadingStateWidget();
          },
        );
      },
    );
  }

  Widget _listBuilder(
    BuildContext context,
    List<DirectoryEntity> dirs,
    DirectoryPathState pathState,
    DirectorySelectState selectPath,
  ) {
    var selectBloc = BlocProvider.of<DirectorySelectBloc>(context);
    var pathBloc = BlocProvider.of<DirectoryPathBloc>(context);

    return BlocListener<DirectoryActionBloc, DirectoryActionState>(
      listener: (context, actionState) {
        if (actionState is RefreshBrowsePage) {
          pathBloc.add(RefreshPath(pathState.paths));
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          if (selectPath is SelectedDirectory) {
            // Cancel selection directory
            selectBloc.add(CancelSelection());

            return await Future.value(false);
          }

          // jika masih di dlm root storage langsung popup saja
          if (pathState.paths.length == 1) return await Future.value(true);

          // Remove last path from paths
          pathBloc.add(PopLastPath(pathState.paths));

          return await Future.value(false);
        },
        child: ListView.builder(
          itemCount: dirs.length,
          itemBuilder: (ctx, int index) {
            DirectoryEntity directoryEntity = dirs[index];

            if (directoryEntity is FolderModel) {
              return SelectableWidget(
                paths: pathState.paths,
                model: directoryEntity,
                selectabelWidgets: SelectableWidgets.folder,
              );
            } else if (directoryEntity is FileModel) {
              return SelectableWidget(
                paths: pathState.paths,
                model: directoryEntity,
                selectabelWidgets: SelectableWidgets.file,
              );
            }

            // unknown entity
            return ListTile(
              leading: Icon(Icons.error_outline),
              title: Text("Unknown entity?"),
            );

            // ...
          },
        ),
      ),
    );
  }

  //....
}
