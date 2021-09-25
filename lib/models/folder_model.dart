import 'dart:io';
import 'package:filemanager/models/directory_entity.dart';

class FolderModel extends DirectoryEntity {
  final String name, previousPath, mode;

  FolderModel({
    required this.name,
    required this.mode,
    required this.previousPath,
    required int size,
    required String path,
    required String absolutePath,
    required String createdAt,
    required String modifiedAt,
    required FileSystemEntity fileSystemEntity,
  }) : super(size, path, fileSystemEntity, absolutePath, createdAt, modifiedAt);

  static Future<FolderModel> fromDirectory(Directory directory) async {
    FileStat dirStat = await directory.stat();

    String foldername = directory.path.split('/').last;

    return FolderModel(
      name: foldername,
      size: dirStat.size,
      path: directory.path,
      previousPath: directory.parent.path,
      absolutePath: directory.absolute.path,
      fileSystemEntity: directory,
      mode: dirStat.modeString(),
      createdAt: dirStat.changed.toString(),
      modifiedAt: dirStat.modified.toString(),
    );
  }

  // ...
}
