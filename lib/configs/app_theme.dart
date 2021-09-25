import 'package:filemanager/bootstrap.dart';

ThemeData appTheme() {
  // ---

  // - Text theme -
  // note: headline(1-6) sama dengan h1-h6 di web
  TextTheme textTheme = TextTheme(
    headline6: TextStyle(
      color: AppColors.titleColor1,
      fontSize: 19,
      fontWeight: FontWeight.w600,
    ),
    headline5: TextStyle(color: AppColors.titleColor2, fontSize: 17),
    headline4: TextStyle(color: AppColors.titleColor3, fontSize: 15),
    headline3: TextStyle(color: AppColors.titleColor3, fontSize: 13),
    headline2: TextStyle(color: AppColors.titleColor3, fontSize: 12),
    headline1: TextStyle(color: AppColors.titleColor3, fontSize: 11),
    subtitle1: TextStyle(color: AppColors.titleColor3, fontSize: 14),
    subtitle2: TextStyle(color: AppColors.titleColor4, fontSize: 13),
  );

  // -- Icon theme --
  IconThemeData iconTheme = IconThemeData(color: AppColors.iconColor);

  return ThemeData(
    primarySwatch: AppColors.primary,
    textTheme: textTheme,
    iconTheme: iconTheme,
    appBarTheme: AppBarTheme(
      elevation: 1,
      backgroundColor: AppColors.appBarColor1,
      textTheme: textTheme,
      iconTheme: iconTheme,
      actionsIconTheme: iconTheme,
    ),
    primaryIconTheme: iconTheme,
  );

  // ...
}

ThemeData appThemeDark() {
  // ---

  // Text theme
  TextTheme textTheme = TextTheme(
    headline6: TextStyle(
      color: AppColors.titleColor1,
      fontSize: 19,
      fontWeight: FontWeight.w600,
    ),
    headline5: TextStyle(color: AppColors.titleColor2),
    headline4: TextStyle(color: AppColors.titleColor3),
    subtitle1: TextStyle(color: AppColors.titleColor3),
    subtitle2: TextStyle(color: AppColors.titleColor4),
  );

  return ThemeData(
    primarySwatch: AppColors.primary,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      elevation: 1,
      backgroundColor: AppColors.appBarColor1,
      textTheme: textTheme,
      titleTextStyle: TextStyle(color: AppColors.titleColor1),
      iconTheme: IconThemeData(color: AppColors.iconColor),
    ),
  );

  // ...
}
