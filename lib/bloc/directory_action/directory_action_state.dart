part of 'directory_action_bloc.dart';

@immutable
abstract class DirectoryActionState {}

class InitialState extends DirectoryActionState {}

class LoadingState extends DirectoryActionState {}

class FinishState extends DirectoryActionState {}

class RefreshBrowsePage extends DirectoryActionState {}

class OnActionProgress extends DirectoryActionState {}

class FormatError extends DirectoryActionState {
  final String message;
  FormatError(this.message);
}

class SuccessOnCreate extends DirectoryActionState {
  final String message;
  SuccessOnCreate(this.message);
}

class ErrorOnCreate extends DirectoryActionState {
  final String message;
  ErrorOnCreate(this.message);
}

class SuccessOnDelete extends DirectoryActionState {
  final String message;
  SuccessOnDelete(this.message);
}

class ErrorOnDelete extends DirectoryActionState {
  final String message;
  ErrorOnDelete(this.message);
}

class SuccessOnCopy extends DirectoryActionState {
  final String message;
  SuccessOnCopy(this.message);
}

class ErrorOnCopy extends DirectoryActionState {
  final String message;
  ErrorOnCopy(this.message);
}

class SuccessOnMove extends DirectoryActionState {
  final String message;
  SuccessOnMove(this.message);
}

class ErrorOnMove extends DirectoryActionState {
  final String message;
  ErrorOnMove(this.message);
}
