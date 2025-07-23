import 'dart:async';

import 'package:filemanager/exceptions/_exceptions.dart';
import 'package:filemanager/models/_models.dart';
import 'package:filemanager/utils/log_handler.dart';
import 'package:flutter/material.dart';

class LogFacade {
  /// delete facade and show snackbar
  /// if success or faild
  static Future<bool> delete(ctx) async {
    var scfld = ScaffoldMessenger.of(ctx);
    scfld.clearSnackBars();

    try {
      bool res = await LogHandler.delete();

      scfld.showSnackBar(SnackBar(
        content: Text('Berhasil menghapus file.'),
      ));
      return res;
    } on FileNotFound {
      scfld.showSnackBar(SnackBar(
        content: Text('File tidak ditemukan!'),
      ));
      return false;
      // ...
    } catch (e) {
      scfld.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      return false;
    }
  }

  // ...
  static Future<List<LogModel>> getAppLog() async {
    List<dynamic> logs = await LogHandler.getAppLog();
    List<LogModel> logmodels = [];

    try {
      for (Map<String, dynamic> log in logs) {
        logmodels.add(LogModel.fromMap(log));
      }
    } catch (e, s) {
      throw FileCorrupted(
        'Log file corrupted.',
        stackTrace: s,
        logException: false,
      );
    }

    // sort by date
    logmodels.sort((l1, l2) {
      return l2.createdAt.compareTo(l1.createdAt);
    });

    return logmodels;
  }

  // ...
}
