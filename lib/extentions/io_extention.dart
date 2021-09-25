import 'dart:io';

extension IoExtension on FileSystemEntity {

  String basename() {
    List<String> paths = [];
    if (this.path.contains('/')) paths = this.path.split('/');
    else if (this.path.contains('\\')) paths = this.path.split('\\');

    return paths.last;
  }

  // ...
}

extension FileExtension on File {

  String basename() {
    List<String> paths = [];
    if (this.path.contains('/')) paths = this.path.split('/');
    else if (this.path.contains('\\')) paths = this.path.split('\\');

    return paths.last;
  }

  // ...
}

extension DirectoryExtension on Directory {

  String basename() {
    List<String> paths = [];
    if (this.path.contains('/')) paths = this.path.split('/');
    else if (this.path.contains('\\')) paths = this.path.split('\\');

    return paths.last;
  }

  // ...
}
