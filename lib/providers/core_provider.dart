import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class CoreProvider extends ChangeNotifier {
  List<FileSystemEntity> availableStorage = <FileSystemEntity>[];
  int totalSpace = 0;
  int freeSpace = 0;
  int totalSDSpace = 0;
  int freeSDSpace = 0;
  int usedSpace = 0;
  int usedSDSpace = 0;
  bool storageLoading = true;
  bool recentLoading = true;

  checkSpace() async {
    setStorageLoading(true);
    availableStorage.clear();
    List<FileSystemEntity> l = await getExternalStorageDirectories() ?? [];
    availableStorage.addAll(l);
    notifyListeners();
    MethodChannel platform = MethodChannel('com.example.filemanager/storage');
    var free = await platform.invokeMethod("getStorageFreeSpace");
    var total = await platform.invokeMethod("getStorageTotalSpace");
    setFreeSpace(free);
    setTotalSpace(total);
    setUsedSpace(total - free);
    if (l.length > 1) {
      var freeSD = await platform.invokeMethod("getExternalStorageFreeSpace");
      var totalSD = await platform.invokeMethod("getExternalStorageTotalSpace");
      setFreeSDSpace(freeSD);
      setTotalSDSpace(totalSD);
      setUsedSDSpace(totalSD - freeSD);
    }
    setStorageLoading(false);
  }

  void setFreeSpace(value) {
    freeSpace = value;
    notifyListeners();
  }

  void setTotalSpace(value) {
    totalSpace = value;
    notifyListeners();
  }

  void setUsedSpace(value) {
    usedSpace = value;
    notifyListeners();
  }

  void setFreeSDSpace(value) {
    freeSDSpace = value;
    notifyListeners();
  }

  void setTotalSDSpace(value) {
    totalSDSpace = value;
    notifyListeners();
  }

  void setUsedSDSpace(value) {
    usedSDSpace = value;
    notifyListeners();
  }

  void setStorageLoading(value) {
    storageLoading = value;
    notifyListeners();
  }

}
