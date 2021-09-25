import 'package:filemanager/facades/directory_entity_facade.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DirectorySearchBloc
    extends Bloc<DirectorySearchEvent, DirectorySearchState> {
  DirectorySearchBloc() : super(DSinitialState());

  Stream<DirectorySearchState> mapEventToState(
      DirectorySearchEvent event) async* {
    yield DSinitialState();

    if( event is OnTyping) {
      yield DSloading();

      Stream<String> dirPaths = DirectoryEntityFacade.searchDE(event.path, event.keyword);

      await for(String path in dirPaths) {
        yield DSFounded(path);
      }

    }

    yield DSDone();
  }
}

@immutable
abstract class DirectorySearchState {}

class DSinitialState extends DirectorySearchState {}

class DSloading extends DirectorySearchState {}

class DSError extends DirectorySearchState {}

class DSNotfound extends DirectorySearchState {}

class DSDone extends DirectorySearchState {}

class DSFounded extends DirectorySearchState {
  final String path;
  DSFounded(this.path);
}

@immutable
abstract class DirectorySearchEvent {}

class OnTyping extends DirectorySearchEvent {
  final String keyword, path;
  OnTyping(this.keyword, this.path);
}

class OnSearch extends DirectorySearchEvent {
  final String keyword, path;
  OnSearch(this.keyword, this.path);
}
