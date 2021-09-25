import 'package:filemanager/bloc/_bloc.dart';
import 'package:filemanager/bloc/directory_select/directory_select_bloc.dart';
import 'package:filemanager/bootstrap.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: blocs(),
      child: MyApp(),
    ),
  );
}

List<BlocProvider> blocs() {
  return [
    BlocProvider<NavigationBloc>(
      create: (BuildContext context) => NavigationBloc(),
    ),
    BlocProvider<DirectoryPathBloc>(
      create: (BuildContext context) => DirectoryPathBloc(),
    ),
    BlocProvider<DirectorySelectBloc>(
      create: (BuildContext context) => DirectorySelectBloc(),
    ),
    BlocProvider<DirectoryActionBloc>(
      create: (BuildContext context) => DirectoryActionBloc(),
    ),
  ];
}

class MyApp extends StatelessWidget {
  final List<Locale> locales = [
    Locale('id', 'ID'),
    Locale('en', 'US'),
    Locale('en', 'UK'),
  ];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: App.name,
      routes: Navigation.routes(),
      initialRoute: Navigation.initialRoute,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      locale: locales.first,
      theme: appTheme(),
    );
  }
}
