import 'package:filemanager/configs/app.dart';
import 'package:filemanager/extentions/exception_extention.dart';

extension ObjectExtention on Object {
  /// method for changing error message
  /// depend on app status
  String normalize(String str) {
    if (App.debug) return this.toString();
    return str;
  }
}
