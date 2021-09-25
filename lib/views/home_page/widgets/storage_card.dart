import 'package:filemanager/bloc/_bloc.dart';
import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/utils/_utils.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class StorageCard extends StatelessWidget {
  final IconData icon;
  final String name, path;
  final int usedSpace, freeSpace, totalSpace;

  StorageCard({
    required this.icon,
    required this.name,
    required this.path,
    this.totalSpace = 0,
    this.usedSpace = 0,
    this.freeSpace = 0,
  });

  @override
  Widget build(BuildContext context) {
    MaterialColor mainColor = Colors.grey;
    // Color randColor =
    //     Colors.primaries[Random().nextInt(Colors.primaries.length)];

    var _usedSpace = ByteConvertion.upConvert(usedSpace.toDouble());
    var _totalSpace = ByteConvertion.upConvert(totalSpace.toDouble());

    // Percentage
    double percentage = calculatePercent();

    // Color
    Color progressColor = Colors.orange.shade400;

    if (percentage >= 0.15 && percentage < 0.85){
      progressColor = Colors.blue.shade400;
    } else if (percentage >= 0.85) {
      progressColor = Colors.red.shade400;
    }

    return InkWell(
      onTap: () {
        // Start browsing
        BlocProvider.of<DirectoryPathBloc>(context)
            .add(PushNewPath(this.path, []));

        // navigate to browsepage
        BlocProvider.of<NavigationBloc>(context).add(ToBrowsePage(context));
      },
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
            border: Border.all(color: mainColor.shade300, width: 2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(this.icon, color: progressColor),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonWidgets.text(
              this.name,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            CommonWidgets.text(
              "${_usedSpace.symbValue} - ${_totalSpace.symbValue}",
              fontSize: 12,
            ),
          ],
        ),
        subtitle: SizedBox(
          width: double.infinity,
          child: new LinearPercentIndicator(
            lineHeight: 6.0,
            percent: percentage,
            progressColor: progressColor,
          ),
        ),
      ),
    );
  }

  double calculatePercent() {
    return double.parse((usedSpace / totalSpace * 100).toStringAsFixed(0)) /
        100;
  }

  // ...
}
