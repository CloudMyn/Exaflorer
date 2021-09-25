import 'dart:convert';
import 'dart:io';

import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/extentions/_extentions.dart';
import 'package:filemanager/models/_models.dart';
import 'package:filemanager/providers/isolate_provider.dart';
import 'package:path_provider/path_provider.dart';

class LogHandler {
  /// method for logging given error exception,
  /// this function return true if success
  /// otherwise exception wll thrown
  Future<bool> log(LogModel error) async {
    IsolateProvider ip = new IsolateProvider();

    IsolateService iss = await ip.createIsolate();

    dynamic result = await iss.run(_log, error);

    iss.terminateIsolate();

    return result;
  }

  static Future<bool> _log(LogModel data) async {
    String filename = App.logname;
    List<dynamic> _logs = [];
    String filePath = '';
    try {
      Directory dir = Directory(App.getAppPath());

      filePath = "${dir.path}$filename";
    } catch (e, s) {
      throw FileException('Gagal mendapatkan log file', s);
    }

    File logfile = File(filePath);

    if (logfile.existsSync()) {
      String content = await logfile.readAsString();
      content = content.trim();

      if (content.isEmpty) throw Exception('logfile is empty');

      List<dynamic> cjson = jsonDecode(content);

      _logs.addAll(cjson);
    }

    _logs.add(data.toMap());

    logfile.writeAsString(jsonEncode(_logs));

    return true;
    // ...
  }

  static Future<List<dynamic>> getAppLog() async {
    IsolateProvider ip = new IsolateProvider();

    IsolateService iss = await ip.createIsolate();

    List<dynamic> result = await iss.run(_getAppLog, []);

    iss.terminateIsolate();
    ip.terminateIsolates();

    return result;
  }

  static Future<List<dynamic>> _getAppLog(_) async {
    try {
      String filename = App.logname;
      Directory dir = Directory(App.getAppPath());

      File file = File("${dir.path}/$filename");

      if (!file.existsSync()) throw Exception();

      String content = await file.readAsString();

      return jsonDecode(content) as List<dynamic>;

      // ...
    } on NullThrownError catch (e, s) {
      throw FileException('Gagal mendapatkan log file', s);
    } catch (e, _) {
      return Future.value([]);

      // ...
    }
  }

  /// delete log file return true if success
  /// otherwise exception thrown
  static Future<bool> delete() async {
    String filename = App.logname;
    Directory dir = Directory(App.getAppPath());

    File file = File("${dir.path}/$filename");

    if (!file.existsSync())
      throw FileNotFound(
        'log file tidak ditemukan',
        stackTrace: StackTrace.current,
        logException: false,
      );

    await file.delete(recursive: true);

    return Future.value(true);
  }

  // ...
}
