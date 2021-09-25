// a class that contain configuration of the application
class App {
  // Application key
  static final String key = 'Hx01oAzk108mkaLo1QezMnz12JAokl';

  // Application status debug
  static bool _debug = true;

  // getter for debug
  static get debug => _debug;

  // setter for debug
  static set setDebug(bool val) => _debug = val;

  // Application env
  static final String env = 'local';

  // The name of application
  static final String name = 'Exaflorer';

  // The package name of application
  static final String package = 'com.example.filemanager';

  // Localization
  static final String locale = 'id';

  // targets platform
  static final List<String> targets = ['android'];

  // error logging
  static final String logname = 'app_log.json';

  // max size of log file in megabyte
  static final int logendcode = 3;

  // application path in internal storage
  static String getAppPath() => '/storage/emulated/0/android/data/$package/';

  // ...
}
