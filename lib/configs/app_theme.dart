import 'package:filemanager/bootstrap.dart';

ThemeData appTheme() {
  // ---

  // - Text theme -
  // note: headline(1-6) sama dengan h1-h6 di web
  TextTheme textTheme = TextTheme(
    titleLarge: TextStyle(
      color: AppColors.titleColor1,
      fontSize: 19,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(color: AppColors.titleColor2, fontSize: 17),
    titleSmall: TextStyle(color: AppColors.titleColor3, fontSize: 15),
    bodyLarge: TextStyle(color: AppColors.titleColor3, fontSize: 14),
    bodyMedium: TextStyle(color: AppColors.titleColor4, fontSize: 13),
    bodySmall: TextStyle(color: AppColors.titleColor3, fontSize: 11),
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
    titleLarge: TextStyle(
      color: AppColors.titleColor1,
      fontSize: 19,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(color: AppColors.titleColor2),
    titleSmall: TextStyle(color: AppColors.titleColor3),
    bodyLarge: TextStyle(color: AppColors.titleColor3),
    bodyMedium: TextStyle(color: AppColors.titleColor4),
  );

  return ThemeData(
    primarySwatch: AppColors.primary,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      elevation: 1,
      backgroundColor: AppColors.appBarColor1,
      titleTextStyle: TextStyle(color: AppColors.titleColor1),
      iconTheme: IconThemeData(color: AppColors.iconColor),
    ),
  );

  // ...
}
