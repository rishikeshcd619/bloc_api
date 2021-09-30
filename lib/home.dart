import 'dart:convert';

import 'package:coinone/bloc/api_bloc.dart';
import 'package:coinone/components/device_card.dart';
import 'package:coinone/components/graph.dart';
import 'package:coinone/model/device_model.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final apiBloc = ApiBloc();
  List<DeviceModel> devices = [];
  Widget freeTimeUsageIndicator(int usedTime, int maxTime) {
    return Container(
      height: 120,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        'Used',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${usedTime.toString()}m',
                        style: TextStyle(
                            color: Colors.green[400],
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Max',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700)),
                      Text(
                        '${(maxTime / 60).ceil().toString()}h',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: LinearProgressIndicator(
                value: ((usedTime / maxTime) * 100) / 100,
                valueColor: AlwaysStoppedAnimation(Colors.green[400]),
                backgroundColor: Colors.blue[100],
              ),
            ),
          )
        ],
      ),
    );
  }

  String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    if (hour == 0) {
      return '${minutes.toString().padLeft(2, "0")}m';
    } else {
      return '${hour.toString()}h ${minutes.toString().padLeft(2, "0")}m';
    }
  }

  Widget classTimeIndicator(Color color, String type, String time) {
    return Expanded(
        flex: 1,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        width: 15.0,
                        height: 15.0,
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, color: color),
                      ),
                    ),
                    TextSpan(
                        text: '  ${type}',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Text(
                time,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ));
  }

  Widget extendTimeButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(
              width: 4.0,
              color: Colors.blue,
            )),
        child: Center(
          child: Text("Extented Free-time",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }

  Widget loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.0,
          shadowColor: Colors.white,
          backgroundColor: Theme.of(context).backgroundColor,
          leading: Container(
            width: 10.0,
            height: 10.0,
            margin: EdgeInsets.all(10.0),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.red),
          ),
          title: Text(
            'Michael',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon:
                    Icon(Icons.settings, color: Colors.black.withOpacity(0.7)))
          ],
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Theme.of(context).backgroundColor,
            child: StreamBuilder(
                stream: apiBloc.apiStream,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) return loading();
                  if (snapshot.data != null) {
                    dynamic apiData = jsonDecode(snapshot.data)[0];
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              'Dashboard',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          Graph(
                              totalTime: ((apiData['chartData'])['totalTime'])[
                                  'total'],
                              classTime: ((apiData['chartData'])['classTime'])[
                                  'total'],
                              studyTime: ((apiData['chartData'])['studyTime'])[
                                  'total'],
                              freeTime: ((apiData['chartData'])['freeTime'])[
                                  'total']),
                          Container(
                            height: 100.0,
                            child: Row(
                              children: [
                                classTimeIndicator(
                                    Colors.blue,
                                    'Class',
                                    getTimeString(int.parse(((apiData[
                                        'chartData'])['classTime'])['total']))),
                                classTimeIndicator(
                                    Colors.yellow.shade800,
                                    'Study',
                                    getTimeString(int.parse(((apiData[
                                        'chartData'])['studyTime'])['total']))),
                                classTimeIndicator(
                                    Colors.green,
                                    'Free-Time',
                                    getTimeString(int.parse(((apiData[
                                        'chartData'])['freeTime'])['total']))),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Divider(
                              color: Colors.grey[300],
                              thickness: 2.0,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Free-time Usage',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          freeTimeUsageIndicator(
                              int.parse(((apiData['chartData'])['freeTime'])[
                                  'total']),
                              int.parse(apiData['freeTimeMaxUsage'])),
                          SizedBox(
                            height: 20.0,
                          ),
                          extendTimeButton(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Change Time Restrictions',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Divider(
                              color: Colors.grey[300],
                              thickness: 2.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              'By Devices',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: 2,
                              physics: ScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                devices.add(DeviceModel(
                                    "Adi's Phone",
                                    ((apiData['deviceUsage'])['totalTime'])[
                                        'mobile'],
                                    AssetImage('assets/images/phone.jpg')));
                                devices.add(DeviceModel(
                                    "Adi's Laptop",
                                    ((apiData['deviceUsage'])['totalTime'])[
                                        'mobile'],
                                    AssetImage('assets/images/computer.jpg')));
                                return DeviceCard(
                                    title: devices[index].title,
                                    time: devices[index].time,
                                    image: devices[index].image);
                              }),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              'See All Devices',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Text('No Data');
                  }
                })));
  }
}
