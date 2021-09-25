import 'package:filemanager/bloc/_bloc.dart';
import 'package:filemanager/bootstrap.dart';
import 'package:flutter/cupertino.dart';

class RouteBarNavigation extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    ScrollController controller = new ScrollController();
    return BlocBuilder<DirectoryPathBloc, DirectoryPathState>(
      builder: (context, buildState) {
        List<String> paths = buildState.paths;
        String currentPath = buildState.lastPath;

        return BlocListener<DirectoryPathBloc, DirectoryPathState>(
          listener: (context, updateState) {
            // Update scroll view to last item
            controller.jumpTo(controller.position.maxScrollExtent);
          },
          child: _widgetBuilder(
            context,
            controller,
            paths,
            currentPath,
          ),
        );
      },
    );
  }

  SizedBox _widgetBuilder(
    BuildContext context,
    ScrollController controller,
    List<String> paths,
    String currentPath,
  ) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        controller: controller,
        padding: EdgeInsets.symmetric(horizontal: 15),
        scrollDirection: Axis.horizontal,
        itemCount: paths.length,
        itemBuilder: (_, int index) {
          String name = paths[index].split('/').last;

          Icon? icon;

          if (index == 0) {
            if (name == '0') {
              icon = Icon(Icons.phone_iphone_outlined);
            } else {
              icon = Icon(Icons.sd_card_outlined);
            }
          }

          return Padding(
            padding: EdgeInsetsDirectional.only(end: 5),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    // Cancel selection directory
                    BlocProvider.of<DirectorySelectBloc>(context)
                        .add(CancelSelection());

                    // Remove path from index to latest path in list
                    BlocProvider.of<DirectoryPathBloc>(context)
                        .add(RemovePathAfterIndex(index, paths));

                    // ...
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: icon ??
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueGrey.shade700,
                          ),
                        ),
                  ),
                ),
                _divider(paths.length, index + 1),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _divider(int i1, int i2) {
    Icon icon = Icon(
      CupertinoIcons.right_chevron,
      size: 20,
      color: Colors.grey.shade600,
    );
    return i1 == i2 ? Container() : icon;
  }

  @override
  Size get preferredSize => Size.fromHeight(45);
}
