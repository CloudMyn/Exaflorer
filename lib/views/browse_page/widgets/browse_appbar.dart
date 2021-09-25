import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/bloc/_bloc.dart';
import 'package:filemanager/views/browse_page/widgets/widgets.dart';
import 'package:filemanager/views/widgets/_widgets.dart';
import 'package:flutter/cupertino.dart';

class BrowseAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DirectorySelectBloc, DirectorySelectState>(
      builder: (context, DirectorySelectState state) {
        if (state is SelectedDirectory) {
          return _AppBarSelect(state);
        } else {
          return _AppBarDef(state);
        }
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);

  // ...
}

class _AppBarDef extends StatelessWidget {
  final DirectorySelectState selectState;

  const _AppBarDef(this.selectState);

  // Default appbar
  @override
  Widget build(BuildContext context) {
    return BlocListener<DirectoryActionBloc, DirectoryActionState>(
      listener: (context, actionState) {
        // ScaffoldMessenger.of(context).removeCurrentSnackBar();

        if (actionState is SuccessOnCopy) {
          this.showSnackBar(context, actionState.message,
              backgroundColor: Colors.lightGreen.shade500);
        } else if (actionState is SuccessOnCreate) {
          this.showSnackBar(context, actionState.message,
              backgroundColor: Colors.lightGreen.shade500);
        } else if (actionState is ErrorOnCreate) {
          this.showSnackBar(context, actionState.message,
              backgroundColor: Colors.red.shade500);
        } else if (actionState is FormatError) {
          this.showSnackBar(context, actionState.message,
              backgroundColor: Colors.yellow.shade800);
        } else if (actionState is SuccessOnDelete) {
          this.showSnackBar(context, actionState.message,
              backgroundColor: Colors.lightGreen.shade500);
        } else if (actionState is ErrorOnDelete) {
          this.showSnackBar(context, actionState.message,
              backgroundColor: Colors.red.shade500);
        }
      },
      child: BlocBuilder<DirectoryPathBloc, DirectoryPathState>(
        builder: (context, pathState) {
          return AppBar(
            actions: _appBarDefAction(context, pathState),
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                "Jelajah Direktori",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            bottom: RouteBarNavigation(),
          );
        },
      ),
    );
  }

  // Action for defaut appbar
  List<Widget> _appBarDefAction(
    BuildContext context,
    DirectoryPathState pathState,
  ) {
    List<Map<String, dynamic>> _actions = [
      {
        'tooltip': 'Cari file atau folder',
        'icon': Icons.search_outlined,
        'onTap': () {},
      },
      {
        'tooltip': 'Urutkan direktori',
        'icon': Icons.sort,
        'onTap': () {},
      },
    ];

    List<Widget> widgets = [];

    for (var action in _actions) {
      widgets.add(Tooltip(
        message: action['tooltip'],
        child: IconButton(
          icon: Icon(action['icon'] as IconData),
          onPressed: () {},
        ),
      ));
    }

    widgets.add(
      PopupMenuButton<int>(
        elevation: 2,
        tooltip: "Tampilkan menu",
        onSelected: (int i) {
          if (i == 0) {
            pText('Buat Folder Baru : ');
            _showCreateFolderDialog(context, pathState);
          } else if (i == 1) {
            pText('Buat File Baru : ');
            _showCreateFileDialog(context, pathState);
            // ...
          }
        },
        itemBuilder: (ctx) => [
          _buildMenuItem(
            value: 0,
            icon: Icons.create_new_folder_outlined,
            name: "folder baru",
          ),
          _buildMenuItem(
            value: 1,
            icon: Icons.file_present,
            name: "file baru",
          ),
        ],
      ),
    );

    return widgets;
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon),
          Text(name, style: style),
        ],
      ),
    );
  }

  /// method for show dialog to create new folder
  void _showCreateFolderDialog(ctx, DirectoryPathState pathState) {
    var dirAction = BlocProvider.of<DirectoryActionBloc>(ctx);
    var dirPath = BlocProvider.of<DirectoryPathBloc>(ctx);
    var txtInput = TextEditingController();

    _popupDialog(
      ctx,
      input: txtInput,
      title: "Buat Folder!",
      desc: "Masukkan nama folder",
      onSubmit: () {
        // ...

        dirAction.add(CreateFolder(
          foldername: txtInput.text,
          path: pathState.lastPath,
        ));

        dirPath.add(RefreshPath(pathState.paths));

        Navigator.pop(ctx);

        // ...
      },
    );
  }

  void _showCreateFileDialog(BuildContext ctx, DirectoryPathState pathState) {
    var dirAction = BlocProvider.of<DirectoryActionBloc>(ctx);
    var dirPath = BlocProvider.of<DirectoryPathBloc>(ctx);
    var txtInput = TextEditingController();

    _popupDialog(
      ctx,
      input: txtInput,
      title: "Buat File!",
      desc: "Masukkan nama file",
      onSubmit: () {
        // ...

        dirAction.add(CreateFile(
          filename: txtInput.text,
          path: pathState.lastPath,
        ));

        dirPath.add(RefreshPath(pathState.paths));

        Navigator.pop(ctx);

        // ...
      },
    );
  }

  void showSnackBar(
    BuildContext ctx,
    String message, {
    Color? backgroundColor,
    int duratinInSecond = 4,
  }) {
    var snackbar = ScaffoldMessenger.of(ctx);
    snackbar.showSnackBar(SnackBar(
      backgroundColor: backgroundColor,
      duration: Duration(seconds: duratinInSecond),
      behavior: SnackBarBehavior.floating,
      content: Text(message),
    ));
  }

  /// Method for showing popup dialog
  void _popupDialog(
    BuildContext context, {
    required TextEditingController input,
    required String title,
    String? desc,
    required void Function() onSubmit,
  }) {
    AlertsDialog.formDialog(
      context,
      title: title,
      desc: desc,
      children: [
        textField(input),
      ],
      textSubmit: "Simpan",
      onSubmit: onSubmit,
    ).show();
  }

  // Text field for popup dialog
  Widget textField(
    TextEditingController controller,
  ) {
    return BlocBuilder<DirectoryActionBloc, DirectoryActionState>(
      builder: (context, actionState) {
        return TextFormField(
          controller: controller,
          decoration: InputDecoration(
            errorText:
                (actionState is FormatError) ? actionState.message : null,
            errorBorder: OutlineInputBorder(
              gapPadding: 1,
              borderSide: BorderSide(color: Colors.red.shade400),
            ),
            border: OutlineInputBorder(gapPadding: 1),
            contentPadding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 10,
            ),
          ),
        );
      },
    );
  }
}

class _AppBarSelect extends StatelessWidget {
  final SelectedDirectory state;

  const _AppBarSelect(this.state);

  // Appbar for selection state
  @override
  Widget build(BuildContext context) {
    DirectorySelectBloc selectBloc =
        BlocProvider.of<DirectorySelectBloc>(context);
    return BlocBuilder<DirectoryPathBloc, DirectoryPathState>(
      builder: (context, stateDir) {
        return AppBar(
          backgroundColor: AppColors.appBarColor2,
          leading: InkWell(
            onTap: () {
              selectBloc.add(CancelSelection());
            },
            child: Icon(Icons.close, color: AppColors.iconColor),
          ),
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: CommonWidgets.text(
              'Terpilih ${state.selectedPaths.length}',
              fontSize: 18,
            ),
          ),
          actions: [
            checkBoxBuilder(selectBloc, stateDir),
          ],
          bottom: RouteBarNavigation(),
        );
      },
    );
  }

  Container checkBoxBuilder(
    DirectorySelectBloc selectBloc,
    DirectoryPathState stateDir,
  ) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      child: Checkbox(
        value: state.isSelectedAll,
        side: BorderSide(color: AppColors.primary.shade600, width: 2),
        onChanged: (bool? _) {
          if (!state.isSelectedAll)
            selectBloc.add(SelectAllItem(
              stateDir.lastPath,
              state.selectedPaths,
            ));
          else
            selectBloc.add(ClearSelectionItem(stateDir.lastPath));
        },
      ),
    );
  }
}
