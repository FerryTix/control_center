import 'dart:async';

import 'package:flutter/material.dart';

import 'package:fluttericon/font_awesome_icons.dart';

const BISLICH = "Bislich";
const XANTEN = "Xanten";
const SHORE_NAME = "shore_name";
const VENDING_STATUS = "VendingStatus";
const BICYCLES = "bicycles";
const PASSENGERS = "passengers";

class ControlPanel extends StatefulWidget {
  @override
  _ControlPanel createState() => _ControlPanel();
}

class _ControlPanel extends State<ControlPanel> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: OrientationBuilder(builder: (context, orientation) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              orientation == Orientation.portrait
                  ? "Wilkommen, " + "Hendrik" + "."
                  : "Wilkommen im Fähr Trade Control Center, " +
                      "Hendrik" +
                      ".",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          body: orientation == Orientation.portrait
              ? Column(children: buttons(context))
              : Row(children: buttons(context)),
        );
      }),
      onWillPop: () {
        return Future<bool>.value(false);
      },
    );
  }

  BoxDecoration boxDec = BoxDecoration(
    border: Border(
      bottom: BorderSide(color: Colors.grey, width: 3.0),
      left: BorderSide(color: Colors.grey, width: 3.0),
      right: BorderSide(color: Colors.grey, width: 3.0),
      top: BorderSide(color: Colors.grey, width: 3.0),
    ),
  );

  Map shores = {
    BISLICH: {
      SHORE_NAME: BISLICH,
      VENDING_STATUS: true,
      PASSENGERS: 1,
      BICYCLES: 1,
    },
    XANTEN: {
      SHORE_NAME: XANTEN,
      VENDING_STATUS: true,
      PASSENGERS: 1,
      BICYCLES: 1,
    },
  };

  Column shoreStatus(context, String shore) => Column(children: [
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.black87,
            child: Center(
              child: Text(
                shores[shore][SHORE_NAME],
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
        ),
        Spacer(),
        Text(
          "Wartebereich:",
          style: Theme.of(context).textTheme.headline6,
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: Row(
              children: [
                Spacer(flex: 2),
                Icon(
                  Icons.person,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      shores[shore][PASSENGERS].toString(),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Icon(
                  Icons.pedal_bike,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      shores[shore][BICYCLES].toString(),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
          ),
        ),
        Spacer(),
        Text(
          "Status Ticketverkauf:",
          style: Theme.of(context).textTheme.headline6,
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: Row(
              children: [
                Spacer(flex: 2),
                IconButton(
                  onPressed: () {
                    shores[shore][VENDING_STATUS] = true;
                    shores[shore][PASSENGERS] = 0;
                    shores[shore][BICYCLES] = 0;
                    setState(() {});
                  },
                  icon: Icon(
                    shores[shore][VENDING_STATUS]
                        ? FontAwesome.circle
                        : FontAwesome.circle_thin,
                    size: 48,
                    color: Colors.green,
                  ),
                ),
                /*Expanded(
                  child: Center(
                    child: Text(
                      "15",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),*/
                Spacer(
                  flex: 1,
                ),
                IconButton(
                  onPressed: () {
                    shores[shore][VENDING_STATUS] = false;
                    var otherShore = shore == BISLICH ? XANTEN : BISLICH;
                    if (shores[otherShore][VENDING_STATUS]) {
                      shores[otherShore][PASSENGERS] += 3;
                      shores[otherShore][BICYCLES] += 2;
                    }
                    shores[otherShore][VENDING_STATUS] =
                        shores[otherShore][BICYCLES] < 20;
                    shores[shore][PASSENGERS] = 0;
                    shores[shore][BICYCLES] = 0;
                    setState(() {});
                  },
                  icon: Icon(
                      !shores[shore][VENDING_STATUS]
                          ? FontAwesome.circle
                          : FontAwesome.circle_thin,
                      color: Colors.red,
                      size: 48),
                ),
                /*Expanded(
                  child: Center(
                    child: Text(
                      "10",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),*/
                Spacer(flex: 2),
              ],
            ),
          ),
        ),
        Spacer()
      ]);

  List<Widget> buttons(context) => [
        Expanded(
          flex: 5,
          child: shoreStatus(context, BISLICH),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.blue.shade100,
          ),
        ),
        Expanded(
          flex: 5,
          child: shoreStatus(context, XANTEN),
        ),
      ];

  @override
  State<StatefulWidget> createState() {}
}
