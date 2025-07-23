import 'dart:io';

import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/utils/byte_convertion.dart';

@immutable
abstract class DirectoryEntity {
  final int size; // in bytes
  final String path, absolutePath, createdAt, modifiedAt;
  final FileSystemEntity fileSystemEntity;

  DirectoryEntity(
    this.size,
    this.path,
    this.fileSystemEntity,
    this.absolutePath,
    this.createdAt,
    this.modifiedAt,
  );

  String upConvert() {
    return ByteConvertion.upConvert(this.size.toDouble()).symbValue;
  }

  // ...
}
