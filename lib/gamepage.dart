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
        backgroundColor: Colors.white,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
        Container(
        width: MediaQuery.of(context).size.width * .95,
        height: MediaQuery.of(context).size.height * .60,
        child: Align(
            alignment: Alignment.center,
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xffff00cc), Color(0xff333399)]
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: [
                    BoxShadow(
                    color: Colors.black54,
                    blurRadius: 10.0,
                    offset: Offset(10.0, 20.0))
                    ]),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (var i = 0; i < 10; i++)
                      Row(
                        children: [
                          for (var j = 0; j < 10; j++)
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.095,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.095,
                              padding:
                              EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 2.0),
                              child: RaisedButton(
                                splashColor: Colors.white10,
                                elevation: 15,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.0)),
                              ),
                            )
                        ],
                      )
                  ],
                )
            )
        )
    )]),
    );
  }
}
