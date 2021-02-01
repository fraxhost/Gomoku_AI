import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_game/gameCore/goLogic.dart';
import 'package:go_game/gameCore/minimax.dart';
import 'package:audioplayers/audio_cache.dart';

import 'boardstate.dart';

class Gamepage extends StatefulWidget {
  @override
  _GamepageState createState() => _GamepageState();
}

class _GamepageState extends State<Gamepage> {

  static AudioCache player = new AudioCache();

  GoLogic _goLogic = new GoLogic();
  BoardState _boardState = new BoardState();
  bool gameOver = false;

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

  void dialogueGameOver(int player){
    if(_goLogic.highFiveAfter(player)>-1)
      definitiveDialogue(player);
    if(_boardState.isDraw())
      drawDialogue();
  }

  Object drawDialogue(){
    gameOver = true;
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Game over'),
          content: Text('Game Drawn!'),
        )
    );
  }

  Object definitiveDialogue(int playerMark){
    String result = (playerMark == 0)? 'Lossed..' : 'Win!';
    gameOver = true;
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Game Over'),
          content: Text('You '+ result),
        )
    );
  }
  bool first_move = false;
  Random random = new Random();

  Future AI_makeYourMove() async{

    if(!first_move){
      int i = random.nextInt(10);
      int j = random.nextInt(10);
      if(BoardState.board[i][j]== null)
      _boardState.placeStone(i, j, 0);
      else
        _boardState.placeStone(i-1, j+1, 0);
      
      first_move = true;
    }
    else {
      MiniMax mnx = new MiniMax();
      mnx.getOptimalMove_AI();
    }
  }

  void handleGameLoop(int i, int j) async{

    if(!gameOver){

      if(BoardState.board[i][j] == null) {
        _boardState.placeStone(i, j, BoardState.turn % 2);
        dialogueGameOver(_boardState.tileState(i, j));
      }
      else
        return;

        if(!gameOver) {
          await AI_makeYourMove();
          dialogueGameOver(0);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    new BoardState().run();
    return Scaffold(
      appBar: AppBar(
        title: Text('Gomoku Redux 2021'),
      ),

      body: Container(
        width:MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.bottomCenter,
            radius: 2.5,
            colors: [Color(0xff8f94fb),Color(0xff000428)]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 60),
            Container(
              width: MediaQuery.of(context).size.width * .97,
              height: MediaQuery.of(context).size.height * .60,
              child: Padding(
                padding: EdgeInsets.only(left: 5,right: 5),
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
                                         player.play('audio/tile.wav');
                                          setState(() {
                                            handleGameLoop(i, j);
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
            SizedBox(height: 50,),
            Container(
              width: 75,
              height: 35,
              decoration: BoxDecoration(),
              child: RaisedButton(
                child: Text('Replay'),
                color: Colors.lightBlueAccent,
                onPressed: () {
                  _boardState.clearBoard();
                  setState(() {
                    gameOver = false;
                  });
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}
