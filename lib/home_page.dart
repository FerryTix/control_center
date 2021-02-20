import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return Column(
              children: buttons(context),
            );
          } else {
            return Row(
              children: buttons(context),
            );
          }
        },
      ),
    );
  }

  List<Widget> buttons(context) => [
        Expanded(
          child: RawMaterialButton(
            onPressed: () {},
            child: Container(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.green,
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.red,
          ),
        ),
      ];
}
