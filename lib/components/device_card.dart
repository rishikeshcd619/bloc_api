import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  DeviceCard(
      {Key? key, required this.title, required this.time, required this.image})
      : super(key: key);
  final String title, time;
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image(
                image: image,
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
