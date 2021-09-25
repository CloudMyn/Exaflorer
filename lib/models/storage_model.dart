import 'dart:io';

import 'package:filemanager/bootstrap.dart';

class StorageModel {
  IconData icon;
  String name, fullpath;
  // All size presentate as byte
  int totalSpace, freeSpace, usedSpace;
  FileSystemEntity storageInfo;

  StorageModel({
    required this.name,
    required this.icon,
    this.totalSpace = 0,
    this.freeSpace = 0,
    this.usedSpace = 0,
    required this.fullpath,
    required this.storageInfo,
  });
}
