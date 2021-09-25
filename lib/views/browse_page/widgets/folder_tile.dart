import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/models/_models.dart';
import 'package:filemanager/views/browse_page/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';

class FolderTile extends DirectoryEntityWidget {
  final FolderModel folder;

  FolderTile({
    required this.folder,
    required bool isSelected,
    required bool disabledWidget,
    required Function() onTap,
    required Function() onLongPress,
  }) : super(folder, 'folder', isSelected, disabledWidget, onTap, onLongPress);

  @override
  Widget build(BuildContext context) {
    DateTime dt = DateTime.parse(folder.modifiedAt);
    return Column(
      children: [
        divider(),
        InkWell(
          onLongPress: onLongPress,
          onTap: onTap,
          child: ListTile(
            tileColor: tileColor(),
            leading: Container(
              height: 50,
              child: leading(CupertinoIcons.folder_open),
            ),
            title: title(folder.name),
            subtitle: subTitle(
                "${dt.day} ${dt.month}, ${dt.year} - ${dt.hour}:${dt.minute}"),
            trailing: trailing(context),
          ),
        ),
        divider(),
      ],
    );
  }

  // ..
}
