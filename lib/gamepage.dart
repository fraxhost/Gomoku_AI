import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Gamepage extends StatefulWidget {
  @override
  _GamepageState createState() => _GamepageState();
}

class _GamepageState extends State<Gamepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < 10; i++)
            Row(
              children: [
                for (var j = 0; j < 10; j++)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.095,
                    height: MediaQuery.of(context).size.width * 0.095,
                    padding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                    child: RaisedButton(
                      splashColor: Colors.white10,
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                  )
              ],
            )
        ],
      ),
    );
  }
}
