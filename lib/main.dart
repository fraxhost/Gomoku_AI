import 'package:flutter/material.dart';

import 'gamepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Dashboard(),
      routes: <String, WidgetBuilder>{
        //'/dashboard': (BuildContext context) => ;
        '/gamepage': (BuildContext context) => Gamepage(),
      },
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: FlatButton(
          color: Colors.blue,
          child: Text("Start Game"),
          onPressed: () {
            Navigator.of(context).pushNamed('/gamepage');
          },
        ),
      ),
    );
  }
}
