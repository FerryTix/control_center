import 'dart:ui';

import 'package:control_center/control_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ControlCenterApp());
}

const String ACCESS_CODE_KEY = "FTCC_ACCESS_CODE";

class ControlCenterApp extends StatelessWidget {
  Color secCol = Color.fromARGB(255, 0x00, 0x76, 0x33);
  Color primCol = Color.fromARGB(255, 0x00, 0xB6, 0x4F);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: primCol,
        secondaryHeaderColor: secCol,
        accentColor: Color.fromARGB(255, 0x37, 0xDA, 0x7E),
        disabledColor: Color.fromARGB(255, 0xB8, 0xDC, 0xC6),
        buttonColor: Color.fromARGB(255, 0x00, 0x76, 0x33),
        appBarTheme: AppBarTheme(
          color: primCol,
          brightness: Brightness.dark,
        ),
        // Define the default font family.
        fontFamily: 'Oxygen',
        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          headline4: TextStyle(
            fontSize: 20,
            fontFamily: "Oxygen",
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          headline6: TextStyle(
              fontSize: 18,
            fontFamily: "Oxygen",
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String accessCode = "";
  String loggedInName = "";

  String counterText = "0/6 Zeichen";
  bool buttonActive = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(
            "Fähr Trade Control Center",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: [
            Spacer(
              flex: 1,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z0-9 -]")),
                        ],
                        //keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.characters,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 48,
                          fontFamily: "OxygenMono",
                        ),
                        decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontSize: 24,
                            ),
                            labelText: "Zugangscode",
                            hintText: "…",
                            counterText: counterText,
                            counterStyle: TextStyle(
                              color: counterText.startsWith("6/6")
                                  ? Theme.of(context).secondaryHeaderColor
                                  : Theme.of(context).errorColor,
                              fontSize: 18,
                            )),
                        onChanged: (String newText) {
                          setState(() {
                            accessCode = newText
                                .toUpperCase()
                                .replaceAll(" ", "")
                                .replaceAll("-", "");
                            counterText =
                                accessCode.length.toString() + "/6 Zeichen";
                            buttonActive = accessCode.length == 6;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        color: buttonActive
                            ? Theme.of(context).accentColor
                            : Theme.of(context).disabledColor,
                        onPressed: buttonActive
                            ? () async {
                                SystemChrome.setPreferredOrientations([]);
                                await saveCode(accessCode);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ControlPanel(),
                                  ),
                                );
                              }
                            : null,
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward_outlined,
                            size: 36,
                            color: Colors.white,
                            // color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(
              flex: orientation == Orientation.portrait ? 4 : 10,
            ),
          ],
        ),
      );
    });
  }

  Future<void> saveCode(final String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //todo code aufbereiten
    return prefs.setString(ACCESS_CODE_KEY, code);
  }
}
