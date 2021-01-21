import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'boardstate.dart';

class Gamepage extends StatefulWidget {
  @override
  _GamepageState createState() => _GamepageState();
}

class _GamepageState extends State<Gamepage> {
  List<Color> _colors = <Color>[Colors.white, Colors.black];

  Color chooseColor(int i) {
    if (i == null)
      return Colors.redAccent;
    else if (i == 0)
      return Colors.white;
    else if (i == 1) return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    new BoardState().run();

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
                      color: chooseColor(BoardState.board[i][j]),
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      onPressed: () {
                        setState(() {
                          if (BoardState.board[i][j] == null &&
                              BoardState.turn % 2 == 0) {
                            BoardState.board[i][j] = 0;

                            BoardState.turn++;
                          } else if (BoardState.board[i][j] == null &&
                              BoardState.turn % 2 == 1) {
                            BoardState.board[i][j] = 1;
                            BoardState.turn++;
                          }
                          //print(BoardState.board);
                        });
                      },
                    ),
                  )
              ],
            )
        ],
      ),
    );
  }
}
