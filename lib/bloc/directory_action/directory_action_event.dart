part of 'directory_action_bloc.dart';

@immutable
abstract class DirectoryActionEvent {}

class CreateFile extends DirectoryActionEvent {
  final String path, filename;
  CreateFile({required this.path, required this.filename});
}

class CreateFolder extends DirectoryActionEvent {
  final String path, foldername;
  CreateFolder({required this.path, required this.foldername});
}

class RenameFile extends DirectoryActionEvent {
  final String path, filename;
  RenameFile({required this.path, required this.filename});
}

class RenameFolder extends DirectoryActionEvent {
  final String path, foldername;
  RenameFolder({required this.path, required this.foldername});
}

class DeleteFolder extends DirectoryActionEvent {
  final String path;
  DeleteFolder({required this.path});
}

class DeleteFile extends DirectoryActionEvent {
  final String path;
  DeleteFile({required this.path});
}

class CopyFolder extends DirectoryActionEvent {
  final String path, dest;
  CopyFolder({required this.path, required this.dest});
}

class CopyFile extends DirectoryActionEvent {
  final String path, dest;
  CopyFile({required this.path, required this.dest});
}

class MoveFolder extends DirectoryActionEvent {
  final String path, dest;
  MoveFolder({required this.path, required this.dest});
}

class MoveFile extends DirectoryActionEvent {
  final String path, dest;
  MoveFile({required this.path, required this.dest});
}
