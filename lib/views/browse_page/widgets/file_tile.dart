import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/models/_models.dart';
import 'package:filemanager/views/browse_page/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';

class FileTile extends DirectoryEntityWidget {
  final FileModel file;

  FileTile({
    required this.file,
    required bool isSelected,
    required bool disabledWidget,
    required Function() onTap,
    required Function() onLongPress,
  }) : super(file, 'file', isSelected, disabledWidget, onTap, onLongPress);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        divider(),
        InkWell(
          onTap: this.onTap,
          onLongPress: onLongPress,
          child: ListTile(
            tileColor: tileColor(),
            leading: Container(
              height: 50,
              child: leading(CupertinoIcons.doc),
            ),
            title: title(file.name),
            subtitle: subTitle(file.upConvert() + " : ${file.mode}"),
            trailing: trailing(context),
          ),
        ),
        divider(),
      ],
    );
  }

  // ...
}
