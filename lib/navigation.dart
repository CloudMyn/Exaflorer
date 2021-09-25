import 'package:filemanager/views/dev_page/dev_page.dart';
import 'package:flutter/material.dart';
import 'package:filemanager/views/_views.dart';

class Navigation {
  static final String initialRoute = '/';

  static final String homePageRoute = '/';
  static final String browsePageRoute = '/BrowsePage';
  static final String logPageRoute = '/LogPage';
  static final String aboutPageRoute = '/AboutPage';
  static final String devPageRoute = '/DevPage';

  // List of app routes
  static Map<String, Widget Function(BuildContext)> routes() {
    return {
      homePageRoute: (context) => new HomePage(),
      browsePageRoute: (context) => new BrowsePage(),
      logPageRoute: (context) => new LogPage(),
      aboutPageRoute: (context) => new AboutPage(),
      devPageRoute: (context) => new DevPage(),
    };

    // ...
  }

  // ...
}
