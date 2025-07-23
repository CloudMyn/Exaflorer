import 'dart:io';

import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/facades/_facades.dart';

part 'directory_action_event.dart';
part 'directory_action_state.dart';

class DirectoryActionBloc
    extends Bloc<DirectoryActionEvent, DirectoryActionState> {
  DirectoryActionBloc() : super(InitialState());

  Stream<DirectoryActionState> mapEventToState(
      DirectoryActionEvent event) async* {
    yield LoadingState();

    if (event is CreateFolder) {
      yield* _createItem(event);
      // ...
    } else if (event is CreateFile) {
      yield* _createItem(event);
      // ...
    } else if (event is RenameFolder) {
      yield* _renameItem(event);
      // ...
    } else if (event is RenameFile) {
      yield* _renameItem(event);
      // ...
    } else if (event is DeleteFolder) {
      yield* _deleteItem(event.path, 'folder');
      // ...
    } else if (event is DeleteFile) {
      yield* _deleteItem(event.path, 'file');
      // ...
    } else if (event is CopyFolder) {
      // ...
    } else if (event is CopyFile) {
      // ...
    } else if (event is MoveFolder) {
      // ...
    } else if (event is MoveFile) {
      // ...
    }

    yield FinishState();

    // ...
  }

  ///create new dir entity such as file, folder or link
  Stream<DirectoryActionState> _createItem(DirectoryActionEvent event) async* {
    String name = "Unknows";

    try {
      if (event is CreateFolder) {
        name = 'folder';
        await DirectoryEntityFacade.createDE(
          event.path,
          event.foldername,
          FileSystemEntityType.directory,
        );
      } else if (event is CreateFile) {
        name = 'file';
        await DirectoryEntityFacade.createDE(
          event.path,
          event.filename,
          FileSystemEntityType.file,
        );
      }

      yield RefreshBrowsePage();

      yield SuccessOnCreate('success: $name berhasil dibuat');

      // ...
    } on FileAlreadyExist catch (e) {
      yield ErrorOnCreate(e.toString());
    } on FormatException catch (e) {
      yield FormatError(e.toString());
    } on StorageError catch (e) {
      String msg = "storage-error: gagal membuat $name";

      yield ErrorOnCreate(e.normalize(msg));
    } catch (e) {
      String msg = "unexpected-error: gagal membuat $name";

      yield ErrorOnCreate(e.normalize(msg));
    }
  }

  ///method for rename dir entity such as file, folder or link
  Stream<DirectoryActionState> _renameItem(DirectoryActionEvent event) async* {
    String name = "Unknows";

    try {
      if (event is RenameFolder) {
        name = 'folder';
        await DirectoryEntityFacade.renameDE(event.path, event.foldername);
      } else if (event is RenameFile) {
        name = 'file';
        await DirectoryEntityFacade.renameDE(event.path, event.filename);
      }

      // refresh browse page
      yield RefreshBrowsePage();

      yield SuccessOnCreate('success: $name berhasil dibuat');

      // ...
    } on FormatException catch (e) {
      yield FormatError(e.toString());
    } on StorageError catch (e) {
      String msg = "storage-error: gagal membuat $name";

      yield ErrorOnCreate(e.normalize(msg));
    } catch (e) {
      String msg = "unexpected-error: gagal membuat $name";

      yield ErrorOnCreate(e.normalize(msg));
    }
  }

  /// delete directory enity such as file, folder or link
  Stream<DirectoryActionState> _deleteItem(
    String path,
    String name,
  ) async* {
    try {
      await DirectoryEntityFacade.deleteDE(path);

      // refresh browse page
      yield RefreshBrowsePage();

      yield SuccessOnDelete('success: $name berhasil dihapus');

      // ...
    } on Exception {
      yield ErrorOnDelete("isolate-error: terdapat kesalahan dalam eksekusi isolate");
    } catch (e) {
      String msg = "unexpected-error: gagal menghapus $name";

      yield ErrorOnDelete(e.normalize(msg));
    }
  }

  // ...
}
