import 'dart:io';

import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/models/directory_entity.dart';

class FileModel extends DirectoryEntity {
  final String name, extention, mimeType, mode;

  FileModel({
    required this.name,
    required this.extention,
    required this.mimeType,
    required this.mode,
    required int size,
    required String path,
    required String absolutePath,
    required String createdAt,
    required String modifiedAt,
    required FileSystemEntity fileSystemEntity,
  }) : super(size, path, fileSystemEntity, absolutePath, createdAt, modifiedAt);

  static Future<FileModel> fromDirectory(File file) async {
    FileStat fileStat = await file.stat();

    String filename = file.path.split('/').last;
    String extention = filename.split('.').last;

    return FileModel(
      name: filename,
      extention: extention,
      mimeType: lookupMimeType(file.path) ?? 'Unknown',
      size: fileStat.size,
      mode: fileStat.modeString(),
      path: file.path,
      fileSystemEntity: file,
      absolutePath: file.absolute.path,
      createdAt: fileStat.changed.toString(),
      modifiedAt: fileStat.modified.toString(),
    );
  }

  // ...
}
