import 'package:control_center/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

const String ACCESS_CODE_KEY = "FTCC_ACCESS_CODE";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String code = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fähr Trade Control Center"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: "Bitte Text eingeben"),
                  onChanged: (String newText) {
                    setState(() {
                      code = newText;
                    });
                  },
                ),
              ),
              TextButton(
                onPressed: () async {
                  await saveCode(code);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomePage(),
                    ),
                  );
                },
                child: Icon(Icons.check),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveCode(final String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //todo code aufbereiten
    return prefs.setString(ACCESS_CODE_KEY, code);
  }
}
