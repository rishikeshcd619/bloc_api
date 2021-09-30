import 'package:flutter/material.dart';

class Graph extends StatelessWidget {
  Graph(
      {Key? key,
      required this.totalTime,
      required this.classTime,
      required this.studyTime,
      required this.freeTime})
      : super(key: key);
  final String totalTime, classTime, studyTime, freeTime;

  String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString()}h ${minutes.toString().padLeft(2, "0")}m';
  }

  @override
  Widget build(BuildContext context) {
    double classPercentage =
        ((int.parse(classTime) / int.parse(totalTime)) * 100);
    double studyPercentage =
        (int.parse(studyTime) / int.parse(totalTime)) * 100;
    double freePercentage = (int.parse(freeTime) / int.parse(totalTime)) * 100;

    return Container(
      child: Stack(
        children: [
          SizedBox(
            width: 200.0,
            height: 200.0,
            child: CircularProgressIndicator(
              value: (classPercentage + studyPercentage + freePercentage) / 100,
              valueColor: AlwaysStoppedAnimation(Colors.green[400]),
              strokeWidth: 15.0,
            ),
          ),
          SizedBox(
            width: 200.0,
            height: 200.0,
            child: CircularProgressIndicator(
              value: (classPercentage + studyPercentage) / 100,
              valueColor: AlwaysStoppedAnimation(Colors.yellow[800]),
              strokeWidth: 15.0,
            ),
          ),
          SizedBox(
            width: 200.0,
            height: 200.0,
            child: CircularProgressIndicator(
              value: classPercentage / 100,
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              strokeWidth: 15.0,
            ),
          ),
          Container(
            width: 200.0,
            height: 200.0,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    getTimeString(int.parse(totalTime)),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
