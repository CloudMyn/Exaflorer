part of 'navigation_bloc.dart';

@immutable
abstract class NavigationblocEvent {
  final BuildContext context;
  NavigationblocEvent(this.context);
}

class ToHomePage extends NavigationblocEvent {
  ToHomePage(BuildContext context) : super(context);
}

class ToAboutPage extends NavigationblocEvent {
  ToAboutPage(BuildContext context) : super(context);
}

class ToBrowsePage extends NavigationblocEvent {
  ToBrowsePage(BuildContext context) : super(context);
}

class ToLogPage extends NavigationblocEvent {
  ToLogPage(BuildContext context) : super(context);
}

class ToDevPage extends NavigationblocEvent {
  ToDevPage(BuildContext context) : super(context);
}
