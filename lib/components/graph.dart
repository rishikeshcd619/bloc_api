import 'package:flutter/material.dart';

class Graph extends StatelessWidget {
  Graph(
      {Key? key,
      required this.classPercentage,
      required this.studyPercentage,
      required this.freePercentage})
      : super(key: key);
  final double classPercentage, studyPercentage, freePercentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          SizedBox(
            width: 200.0,
            height: 200.0,
            child: CircularProgressIndicator(
              value: (classPercentage + studyPercentage + freePercentage) / 100,
              valueColor: AlwaysStoppedAnimation(Colors.yellow[800]),
              strokeWidth: 15.0,
            ),
          ),
          SizedBox(
            width: 200.0,
            height: 200.0,
            child: CircularProgressIndicator(
              value: (classPercentage + studyPercentage) / 100,
              valueColor: AlwaysStoppedAnimation(Colors.green[400]),
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
                    '2h 40m',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 30.0,
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
