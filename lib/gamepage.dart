import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'boardstate.dart';

class Gamepage extends StatefulWidget {
  @override
  _GamepageState createState() => _GamepageState();
}

class _GamepageState extends State<Gamepage> {

  Ink chooseColor(int i) {
    if (i == 0) {
      return Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white,Colors.grey],
                stops: [.4,.85]
              )
          )
      );
    }
    else if (i == 1){
      return Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.black38,Colors.black],
                  stops: [.15,.5]
              )
          )
      );
    }

    else
      return Ink(
        //color: Color(0xffC33764).withOpacity(.2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffff00cc).withOpacity(.3), Color(0xff333399).withOpacity(.6)]),
        ),
    );

  }

  @override
  Widget build(BuildContext context) {
    new BoardState().run();

    return Scaffold(
      appBar: AppBar(
        title: Text('GOMOKU'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * .97,
            height: MediaQuery.of(context).size.height * .60,
            child: Padding(
              padding: EdgeInsets.only(left: 12),
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xffff00cc), Color(0xff333399)]),
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 20.0,
                            spreadRadius: 5.0,
                          )
                          //offset: Offset(10.0, 20.0))
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (var i = 0; i < 10; i++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for (var j = 0; j < 10; j++)
                                Container(
                                  child: Container(
                                    width:
                                    MediaQuery.of(context).size.width * .09,
                                    height:
                                    MediaQuery.of(context).size.width * .09,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.0, horizontal: 2.0),
                                    child: RaisedButton(
                                      elevation: 10.0,
                                      splashColor: Colors.white10,
                                      child: chooseColor(BoardState.board[i][j]),
                                      //color: Colors.red[200].withOpacity(.3),
                                     // chooseColor(BoardState.board[i][j]),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 2.0, horizontal: 2.0),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.circular(3.0),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (BoardState.board[i][j] == null &&
                                              BoardState.turn % 2 == 0) {
                                            BoardState.board[i][j] = 0;

                                            BoardState.turn++;
                                          } else if (BoardState.board[i][j] ==
                                              null &&
                                              BoardState.turn % 2 == 1) {
                                            BoardState.board[i][j] = 1;
                                            BoardState.turn++;
                                          }
                                          //print(BoardState.board);
                                        });
                                      },
                                    ),
                                  ),
                                )
                            ],
                          )
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}