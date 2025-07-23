import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/views/browse_page/browse_page.dart';
import 'package:meta/meta.dart';
import 'package:page_transition/page_transition.dart';

part 'navigationbloc_event.dart';
part 'navigationbloc_state.dart';

class NavigationBloc extends Bloc<NavigationblocEvent, NavigationblocState> {
  NavigationBloc() : super(InitialNavigationState());

  Stream<NavigationblocState> mapEventToState(
    NavigationblocEvent event,
  ) async* {
    if (event is ToHomePage) {
      Navigator.of(event.context)
          .pushReplacementNamed(Navigation.homePageRoute);
    } else if (event is ToAboutPage) {
      Navigator.of(event.context)
          .pushReplacementNamed(Navigation.aboutPageRoute);
    } else if (event is ToBrowsePage) {
      Navigator.of(event.context).push(PageTransition(
        child: BrowsePage(),
        duration: Duration(milliseconds: 100),
        reverseDuration: Duration(milliseconds: 100),
        type: PageTransitionType.fade,
        ctx: event.context,
      ));
    } else if (event is ToLogPage) {
      Navigator.of(event.context).pushReplacementNamed(Navigation.logPageRoute);
    } else if (event is ToDevPage) {
      Navigator.of(event.context).pushReplacementNamed(Navigation.devPageRoute);
    }

    yield InitialNavigationState();
  }
}
