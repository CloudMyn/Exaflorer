import 'dart:io';

import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/exceptions/_exceptions.dart';
import 'package:filemanager/providers/isolate_provider.dart';
import 'package:filemanager/extentions/_extentions.dart';

/// [DE] is a shorthand of Directory entity
/// [DEs] is a plural of [DE]
class DirectoryEntityFacade {
  // ...

  /// Method for searching a file/folder in
  /// in directory or sub-directories
  static Stream<String> searchDE(String path, String query) async* {
    Directory dir = Directory(path);
    Stream<FileSystemEntity> fs = dir.list(recursive: true);

    await for (var _fs in fs) {
      if (_fs.basename().contains(query)) yield _fs.absolute.path;
    }
  }

  /// Method for `rename` [DE]
  /// arguments:
  /// - `FileSystemEntity` dir entity
  /// suchas folder,file,symlink
  /// - `String` new name/path given
  static Future<bool> renameDE(
    String path,
    String newName,
  ) async {
    try {
      String pattern = '[/|:|?|\"|*|<|>|\|]+';
      var regxp = RegExp(pattern);

      // cek jika format tdk valid
      if (regxp.hasMatch(newName))
        throw FormatException(
            'format-error: terdapat karakter yg tidak valid!');

      // hilankan karakter '\' dari nama entitas
      newName = newName.split('\\').join("");

      List<String> lpath = path.split('/');

      lpath.removeLast();

      String xpath = lpath.join('/');

      String fpath = "$xpath/$newName";

      // cek jika path sudah ada
      if (newName.isEmpty) throw FormatException('Nama tidak boleh kosong');

      // cek jika path sudah ada
      if (pathExists(fpath))
        throw FileAlreadyExist('Direktori path $path sudah ada');

      // rename berdasarkan tipe
      // thrown exception kitka entitas tdk diketahui
      if (FileSystemEntity.isFileSync(path)) {
        await File(path).rename(fpath);
      } else if (FileSystemEntity.isDirectorySync(path)) {
        Directory dir = Directory(path);
        await dir.rename(fpath);
      } else if (FileSystemEntity.isLinkSync(path)) {
        await Link(path).rename(fpath);
      } else {
        throw FileSystemException('Unknown file entity in $path');
      }

      return true;

      // ...
    } on FileAlreadyExist {
      rethrow;
    } on FormatException {
      rethrow;
    } on FileSystemException catch (e, s) {
      throw StorageError(e.toString(), s: s);
    } catch (e, s) {
      throw CoreException(e.toString(), stackTrace: s);
    }
  }

  /// Method for create [DE] return true if succes
  /// otherwise exception will thrown;
  /// list of exception:
  ///   - `FormatException` wll trown whenever name containes
  ///   any invalid characters
  ///   - `StorageError`  wll thrown whenever `FileSystemException`
  ///   have thrown , this may caused by permission in related storage
  ///   - `CoreException` wll thrown whenever unexpected errors have caught
  static Future<bool> createDE(
    String path,
    String name,
    FileSystemEntityType entity,
  ) async {
    try {
      // ...
      String pattern = '[/|:|?|\"|*|<|>|\|]+';
      var regxp = RegExp(pattern);

      // hilankan karakter '\' dari nama entitas
      name = name.split('\\').join("");

      bool match = regxp.hasMatch(name);

      if (match) throw FormatException('nama tidak valid!');

      if (name.length >= 50)
        throw FormatException('nama tidak boleh melebihi 50 karakter');

      var fpath = "$path/$name";

      if (name.isEmpty) throw FormatException('nama tidak boleh kosong');

      // cek jika path sudah ada
      if (pathExists(fpath))
        throw FileAlreadyExist(
            'error: terdapat folder/file dngan nama yang sama');

      var enty;

      // sesuaikan entitas dengan tipe file
      if (entity == FileSystemEntityType.file) {
        enty = File(fpath);
      } else if (entity == FileSystemEntityType.link) {
        enty = Link(fpath);
      } else {
        enty = Directory(fpath);
      }

      FileSystemEntity fs = await enty!.create(recursive: true);

      return await fs.exists();

      // ...
    } on FileAlreadyExist {
      rethrow;
    } on FormatException {
      rethrow;
    } on FileSystemException catch (e, s) {
      throw StorageError(e.toString(), s: s);
    } catch (e, s) {
      throw CoreException(e.toString(), stackTrace: s);
    }
  }

  /// Method for copy [DE] return true if succes
  /// otherwise exception thrown
  static Future<bool> copyDE(
    String path,
    String destPath,
    FileSystemEntityType entity,
  ) async {
    try {
      var isp = IsolateProvider();
      var iso = await isp.createIsolate();

      await iso.run(_copyDE, [path, destPath]);

      iso.terminateIsolate();

      return true;
    } on FileNotFound {
      rethrow;
    } on FileAlreadyExist {
      rethrow;
    } on IsolateException {
      rethrow;
    } catch (e, s) {
      throw CoreException(e.toString(), stackTrace: s);
    }

    // ...
  }

  /// Method for copy [DEs]
  static Stream<String> copyDEs(
    List<String> paths,
    String destPath,
    FileSystemEntityType entity,
  ) async* {
    for (var path in paths) {
      await copyDE(path, destPath, entity);
      yield path;
    }

    // ...
  }

  // an isolate method
  static Future<void> _copyDE(List<dynamic> data,
      [bool isReplace = false]) async {
    String path = data[0];
    String destPath = data[1];

    if (FileSystemEntity.isFileSync(path)) {
      _copyFile(path, destPath, isReplace);

      // ...
    } else if (FileSystemEntity.isDirectorySync(path)) {
      Directory folder = Directory(path);

      List<FileSystemEntity> _fss = folder.listSync(recursive: true);

      for (FileSystemEntity fs in _fss) {
        if (fs is File) {
          _copyFile(fs.path, "$destPath/${fs.path}", isReplace);

          // ...
        } else if (fs is Directory) {
          Directory dir = new Directory("$destPath/${fs.path}");
          dir.create(recursive: true);
        }
      }

      // ...
    }

    // ...
  }

  // private method for copying a given file path
  static Future<void> _copyFile(
    String path,
    String destPath,
    bool isReplace,
  ) async {
    File file = File(path);

    if (file.existsSync())
      throw FileNotFound(
        'file-error: file yangg akan di copy tidak ditemukan [$path]',
        logException: false,
      );

    bool exists = await File(destPath).exists();

    if (exists && !isReplace)
      throw FileAlreadyExist(
        'file-error: file dengan nama yang sama ditemukan, harap hapus file tsb',
        logException: false,
      );
    else if (exists && isReplace) await File(destPath).delete();

    await file.copy(destPath);
  }

  /// Method for `delete` directories given
  ///
  /// whenever the method failed there are two exception wll thrown:
  /// - `[DirectoryException]` this wll thrown if there's an error while
  ///   deleting directory, this may caused by file/directory mode
  /// - `[IsolateException]` this wll thrown if there's an error
  ///   inside created isolate
  static Future<void> deleteDEs(List<String> directories) async {}

  /// Method for delete `directory` entity
  static Future<void> deleteDE(String path) async {
    try {
      if (FileSystemEntity.isDirectorySync(path)) {
        Directory dir = Directory(path);
        await dir.delete(recursive: true);
      } else if (FileSystemEntity.isLinkSync(path)) {
        await Link(path).delete();
      } else if (FileSystemEntity.isFileSync(path)) {
        await File(path).delete();
      }

      // ...
    } on FileSystemException catch (e, s) {
      throw StorageError(e.toString(), s: s);
    } catch (e, s) {
      throw CoreException(e.toString(), stackTrace: s);
    }
  }

  static bool pathExists(String path) {
    if (File(path).existsSync())
      return true;
    else if (Directory(path).existsSync())
      return true;
    else if (Link(path).existsSync())
      return true;
    else
      return false;
  }

  // ...
}
