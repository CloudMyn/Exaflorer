import 'dart:io';

import 'package:filemanager/bootstrap.dart';

class DirectorySelectBloc
    extends Bloc<DirectorySelectEvent, DirectorySelectState> {
  DirectorySelectBloc() : super(DirectorySelectInitial());

  Stream<DirectorySelectState> mapEventToState(
      DirectorySelectEvent event) async* {
    if (event is SelectDirectoryItem) {
      List<String> selectedPaths = event.selectedPaths;
      selectedPaths.add(event.path);

      Directory _parentDir = Directory(event.parentPath);

      List<FileSystemEntity> fs = await _parentDir.list().toList();

      bool isSelectedAll = false;

      if (fs.length == selectedPaths.length) isSelectedAll = true;

      yield SelectedDirectory(
        event.parentPath,
        selectedPaths,
        isSelectedAll: isSelectedAll,
      );
    } else if (event is UnselectDirectoryItem) {
      List<String> selectedPaths = event.selectedPaths;
      selectedPaths.removeAt(event.index);
      yield SelectedDirectory(event.parentPath, selectedPaths);
    } else if (event is SelectAllItem) {
      Directory _parentDir = Directory(event.parentPath);

      List<FileSystemEntity> fs = await _parentDir.list().toList();

      List<String> selectedPaths = [];

      for (var data in fs) {
        selectedPaths.add(data.path);
      }

      yield SelectedDirectory(
        event.parentPath,
        selectedPaths,
        isSelectedAll: true,
      );
    } else if (event is ClearSelectionItem) {
      yield SelectedDirectory(event.parentPath, []);
    } else {
      yield DirectorySelectInitial();
    }
  }
}

// --- Event

@immutable
abstract class DirectorySelectEvent {
  final String parentPath;
  final List<String> selectedPaths;

  const DirectorySelectEvent(this.parentPath, this.selectedPaths);
}

class CancelSelection extends DirectorySelectEvent {
  CancelSelection() : super('', []);
}

class SelectAllItem extends DirectorySelectEvent {
  SelectAllItem(String parentPath, List<String> selectedPaths)
      : super(parentPath, selectedPaths);
}

class ClearSelectionItem extends DirectorySelectEvent {
  ClearSelectionItem(String parentPath) : super(parentPath, []);
}

class SelectDirectoryItem extends DirectorySelectEvent {
  final String path;
  SelectDirectoryItem(this.path, String parentPath, List<String> selectedPaths)
      : super(parentPath, selectedPaths);
}

class UnselectDirectoryItem extends DirectorySelectEvent {
  final int index;
  UnselectDirectoryItem(
      this.index, String parentPath, List<String> selectedPaths)
      : super(parentPath, selectedPaths);
}

// --- State

@immutable
abstract class DirectorySelectState {}

class DirectorySelectInitial extends DirectorySelectState {}

class SelectedDirectory extends DirectorySelectState {
  final String parentPath;
  final List<String> selectedPaths;
  final bool isSelectedAll;

  SelectedDirectory(this.parentPath, this.selectedPaths,
      {this.isSelectedAll = false});
}
