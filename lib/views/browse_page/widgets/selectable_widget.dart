import 'package:filemanager/bloc/_bloc.dart';
import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/models/_models.dart';
import 'package:filemanager/views/browse_page/widgets/file_tile.dart';
import 'package:filemanager/views/browse_page/widgets/folder_tile.dart';
import 'package:open_file/open_file.dart';

enum SelectableWidgets { folder, file }

class SelectableWidget extends StatelessWidget {
  final SelectableWidgets selectabelWidgets;
  final List<String> paths;
  final DirectoryEntity model;

  const SelectableWidget({
    required this.model,
    required this.paths,
    required this.selectabelWidgets,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DirectoryPathBloc, DirectoryPathState>(
      builder: (context, stateDir) {
        return BlocBuilder<DirectorySelectBloc, DirectorySelectState>(
          builder: (ctx, state) {
            if (state is SelectedDirectory) {
              bool isDirectorySelected =
                  this.isDirectorySelected(model.path, state);
              return getWidget(
                context,
                state: state,
                stateDir: stateDir,
                isSelected: isDirectorySelected,
              );
            } else {
              return getWidget(
                context,
                state: state,
                stateDir: stateDir,
                isSelected: false,
              );
            }
          },
        );
      },
    );
  }

  bool isDirectorySelected(String path, SelectedDirectory state) {
    return state.selectedPaths.haveValue(path);
  }

  Widget getWidget(
    BuildContext context, {
    required DirectorySelectState state,
    required DirectoryPathState stateDir,
    isSelected = false,
  }) {
    DirectorySelectBloc selectBloc =
        BlocProvider.of<DirectorySelectBloc>(context);
    DirectoryPathBloc directoryPathBloc =
        BlocProvider.of<DirectoryPathBloc>(context);

    bool disabledWidget = false;

    if (state is SelectedDirectory) {
      disabledWidget = true;
    }

    if (this.selectabelWidgets == SelectableWidgets.file) {
      FileModel file = model as FileModel;
      return FileTile(
        file: file,
        isSelected: isSelected,
        disabledWidget: disabledWidget,
        onTap: () async {
          // Select item jika event select terjadi
          // else buka directory folder
          if (state is SelectedDirectory) {
            // Jika item telah di select maka unselect
            // dan sebaliknya.
            if (isSelected) {
              int? index = state.selectedPaths.getIndexOfValue(file.path);

              if (index == null) return;

              selectBloc.add(UnselectDirectoryItem(
                index,
                stateDir.lastPath,
                state.selectedPaths,
              ));

              // ...
            } else {
              selectBloc.add(SelectDirectoryItem(
                file.path,
                stateDir.lastPath,
                state.selectedPaths,
              ));

              // ...
            }

            // ...
          } else {
            OpenResult openFile = await OpenFile.open(file.path);
            print(openFile.message);
          }

          // ...
        },
        // event ketika folder di tap sambil ditahan
        onLongPress: () {
          // jika belum ada item yg ter-select ketika 'onLongPrss'
          // maka aktifkan bloc select
          if (state is DirectorySelectInitial) {
            selectBloc.add(SelectDirectoryItem(
              model.path,
              stateDir.lastPath,
              [],
            ));
          }

          // ...
        },
      );
    } else {
      FolderModel folder = model as FolderModel;
      return FolderTile(
        folder: folder,
        isSelected: isSelected,
        disabledWidget: disabledWidget,
        // event ketika folder di tap
        onTap: () {
          // Select item jika event select terjadi
          // else buka directory folder
          if (state is SelectedDirectory) {
            // Jika item telah di select maka unselect
            // dan sebaliknya.
            if (isSelected) {
              int? index = state.selectedPaths.getIndexOfValue(folder.path);

              if (index == null) return;

              selectBloc.add(UnselectDirectoryItem(
                index,
                stateDir.lastPath,
                state.selectedPaths,
              ));

              // ...
            } else {
              selectBloc.add(SelectDirectoryItem(
                folder.path,
                stateDir.lastPath,
                state.selectedPaths,
              ));

              // ...
            }

            // ...
          } else {
            directoryPathBloc.add(PushNewPath(folder.path, paths));
          }

          // ...
        },
        // event ketika folder di tap sambil ditahan
        onLongPress: () {
          // jika belum ada item yg ter-select ketika 'onLongPrss'
          // maka aktifkan bloc select
          if (state is DirectorySelectInitial) {
            selectBloc.add(SelectDirectoryItem(
              folder.path,
              stateDir.lastPath,
              [],
            ));
          }

          // ...
        },
      );
    }
  }

  // ...
}
