import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'library.dart';

void main() {
  debugPaintSizeEnabled = false;

  runApp(
    MaterialApp(
      title: 'hello',
      initialRoute: '/',
      routes: {
        // When we navigate to the "/" route, build the FirstScreen Widget
        '/': (context) => MyApp(),
        '/home': (context) => Tabs(),
        '/second': (context) => ScorePage(),
        '/player': (context) => GameDetailScreen(awayLogo: '', awayNickname: '', homeShort: '', awayFullName: '', awayId: '', playerDetailsList: [], homeNickname: '', homeFullName: '', homeLogo: '', homeId: '', gameId: '', awayShort: '',),
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ScorePage();
  }
}
