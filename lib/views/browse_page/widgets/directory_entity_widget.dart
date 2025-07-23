import 'dart:io';

import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/configs/_configs.dart';
import 'package:filemanager/models/_models.dart';
import 'package:filemanager/views/widgets/alerts_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class DirectoryEntityWidget extends StatelessWidget {
  final String type;
  final bool isSelected, disabledWidget;
  final DirectoryEntity model;
  final Function() onTap, onLongPress;

  const DirectoryEntityWidget(
    this.model,
    this.type,
    this.isSelected,
    this.disabledWidget,
    this.onTap,
    this.onLongPress,
  );

  // Build popup menu item
  Widget buildPopupMenu(BuildContext ctx) {
    var actionBloc = BlocProvider.of<DirectoryActionBloc>(ctx);
    String name = this.model.path.split('/').last;
    var textCtrl = TextEditingController(text: name);
    return PopupMenuButton<int>(
      onSelected: (i) {
        if (i == 0) {
          AlertsDialog.formDialog(
            ctx,
            title: "Ubah nama",
            textSubmit: 'Simpan',
            children: [
              TextField(
                controller: textCtrl,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
            onSubmit: () {
              if (model is FileModel) {
                actionBloc.add(RenameFile(
                  path: model.path,
                  filename: textCtrl.text,
                ));
              } else if (model is FolderModel) {
                actionBloc.add(RenameFolder(
                  path: model.path,
                  foldername: textCtrl.text,
                ));
              }
              Navigator.pop(ctx);
            },
          ).show();
        } else if (i == 1) {
          // ...

          if (model is FolderModel) {
            Directory folder = Directory(model.path);
            if (folder.listSync().length == 0) {
              actionBloc.add(DeleteFolder(path: model.path));
              return;
            }
          }

          AlertsDialog.confirm(
            ctx,
            title: "Konfirmasi penghapusan!",
            desc: "Tekan 'Hapus' untuk melanjutkan",
            confirmText: 'Hapus',
            onConfirm: () {
              if (model is FileModel) {
                actionBloc.add(DeleteFile(path: model.path));
              } else if (model is FolderModel) {
                actionBloc.add(DeleteFolder(path: model.path));
              }
              Navigator.pop(ctx);
            },
          ).show();

          // ...
        }
      },
      itemBuilder: (context) => [
        _buildMenuItem(
          value: 0,
          icon: Icons.mode_edit_outline,
          name: 'Ubah nama',
        ),
        _buildMenuItem(
          value: 1,
          icon: Icons.delete_forever_outlined,
          name: 'Hapus $type',
        ),
        _buildMenuItem(
          value: 2,
          icon: Icons.star_border_outlined,
          name: 'Tambahkan vaforite',
        ),
        _buildMenuItem(
          value: 2,
          icon: Icons.info_outline,
          name: '$type info',
        ),
      ],
      icon: Icon(
        CupertinoIcons.ellipsis_vertical,
        color: Colors.blueGrey.shade400,
      ),
      offset: Offset(0, 30),
    );
  }

  @override
  Widget build(BuildContext context);

  Divider divider() {
    return Divider(
      height: 0,
      thickness: 1,
      color: AppColors.primary.shade100,
    );
  }

  Color tileColor() {
    return isSelected ? Colors.grey.shade200.withAlpha(153) : Colors.white;
  }

  // Tile leading
  Widget leading(IconData icon) {
    return Icon(
      icon,
      color: Colors.blueGrey.shade600,
      size: 28,
    );
  }

  Widget title(String title) {
    return CommonWidgets.text(
      title,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
  }

  Widget subTitle(String subTitle) {
    return CommonWidgets.text(
      subTitle,
      fontSize: 13,
      fontWeight: FontWeight.w500,
    );
  }

  // Tile trailing
  Widget trailing(BuildContext ctx) {
    Color iconColor = Colors.blueGrey.shade600;
    return !disabledWidget
        ? this.buildPopupMenu(ctx)
        : isSelected
            ? Icon(
                Icons.check_box_outlined,
                color: iconColor,
              )
            : Icon(
                Icons.check_box_outline_blank_outlined,
                color: iconColor,
              );
  }

  PopupMenuItem<int> _buildMenuItem({
    required int value,
    required IconData icon,
    required String name,
  }) {
    TextStyle style = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 15,
    );
    return PopupMenuItem(
      value: value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Text(name, style: style),
          ),
        ],
      ),
    );
  }

  // ...
}
