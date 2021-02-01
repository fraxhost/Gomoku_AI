import 'dart:math';

import 'package:go_game/boardstate.dart';
import 'package:go_game/gameCore/goLogic.dart';

class MiniMax{

  int maxDepth = 2, boardSize = 10;

  List<int> adjacentCellsX = [ 0, 0, 1, -1, -1, 1, -1, 1];
  List<int> adjacentCellsY = [1, -1, 0, 0, 1, -1, -1, 1];
  static int bestMove = 0;
  static int infinity = 99999999999999999;

  bool isMoveValid(int x, int y){

    if((x >= 0 && x < boardSize) && (y >= 0 && y < boardSize))
      return true;
    else
      return false;
  }

  bool findAdjacentStone(int x, int y, List<List<int>> board){


    for(int i=0; i< adjacentCellsX.length; i++){

          x += adjacentCellsX[i];
          y += adjacentCellsY[i];

        if(!isMoveValid(x, y)){
          continue;
        }
         // continue;
        else if(board[x][y] != null){
          //print('${x} ${y}\n');
          return true;
        }
    }
    return false;
  }

  int doMiniMax(int depth, bool AI_turn, int alpha, int beta, List<List<int>> board){

    GoLogic gl = new GoLogic();
    int maxProfit;

    List<List<int>> gBoard = new List.generate(
        10, (_) => new List(10));
    for (int i = 0; i < 10; i++)
      for (int j = 0; j < 10; j++)
        gBoard[i][j] = board[i][j];

    if(depth == 0) {
      bool winCrucial = false, counterCrucial3 = false, counterCrucial4 =false;
      for (int i = 0; i < boardSize; i++) {
        for (int j = 0; j < boardSize; j++) {
          if (!findAdjacentStone(i, j, board))
            continue;

          if (gBoard[i][j] == null) {

            gBoard[i][j] = 0;
            int winMove = gl.highFive(gBoard, 0);
            gBoard[i][j] = null;

            if(winMove>-1){
              winCrucial = true;
              bestMove = i*10+j;
              return 998978798788999;
            }

            gBoard[i][j] = 1;
            int huWin = gl.highFive(gBoard, 1);
            int criticalMove = gl.searchForTwoOpenEnd(3, 1,gBoard);
            bool criticalMove1 = gl.searchForOneOpenEnd(4, 1, gBoard);
            gBoard[i][j] = null;

            if(!winCrucial){
              if(huWin>-1 && BoardState.board[i][j] == null){
                bestMove = i*10+j;
                print('returning human best move ${bestMove}');
                return 9889898989598;
              }
              if(criticalMove>-1 && BoardState.board[i][j]==null && !counterCrucial4) {

                bestMove = i*10+j;
                print('returning human crucial 3 2 move ${bestMove}');
                counterCrucial3 = true;
              }

              if(criticalMove1) {

                bestMove = i*10+j;
                print('returning human crucial 4 1 move ${bestMove}');
                counterCrucial4 = true;
              }
            }
          }
        }
      }
      if(counterCrucial3 || counterCrucial4)
        return 989898989598989;
    }

    if((gl.highFive(board, (AI_turn)?1:0))>-1){

      if(!AI_turn)
        return infinity+(maxDepth-depth);
      else
        return -infinity-(maxDepth-depth);
    }

    if(depth == maxDepth){
      return gl.evaluateGameTree(!AI_turn, board);
    }

      if(AI_turn){

        maxProfit = -infinity;

        for(int i=0;i<boardSize;i++){

          if(alpha >= beta)
            return maxProfit;

          for(int j=0;j<boardSize;j++){

            if(!findAdjacentStone(i, j, board))
              continue;

            if(board[i][j]==null) {
              List<List<int>> newBoard = new List.generate(
                  10, (_) => new List(10));
              for (int i = 0; i < 10; i++)
                for (int j = 0; j < 10; j++)
                  newBoard[i][j] = board[i][j];

              newBoard[i][j] = 0;

                maxProfit = max(maxProfit,doMiniMax(depth + 1, !AI_turn, alpha, beta, newBoard));

                if (maxProfit > alpha) {
                  alpha = maxProfit;
                  bestMove = i * 10 + j;
                  //print('alpha ${alpha} best move ${bestMove}');
                  //print('AI alpha ${alpha} best move ${bestMove}');
                }

                if (alpha >= beta) {
                  return maxProfit;
                }
            }
          }
        }
      }

      if(!AI_turn){

        maxProfit = infinity;

        for(int i=0;i<boardSize;i++){

          if(beta <= alpha)
           return maxProfit;

          for(int j=0;j<boardSize;j++){

            if(!findAdjacentStone(i, j, board))
              continue;

            else if(board[i][j]==null){

              List<List<int>> newBoard = new List.generate(10, (_) => new List(10));

              for (int i = 0; i < 10; i++)
                for (int j = 0; j < 10; j++)
                  newBoard[i][j] = board[i][j];

              newBoard[i][j] = 1;

              maxProfit = min(maxProfit,doMiniMax(depth+1, !AI_turn, alpha, beta, newBoard));
              beta = min(maxProfit,beta);

                if (beta <= alpha) {
                  return maxProfit;
                }

            }

          }
        }
      }
      return maxProfit;
  }
  void getOptimalMove_AI(){

    bool AI_turn= true;
    BoardState boardState = new BoardState();
    bestMove=0;

    List<List<int>> cpyBoard = new List.generate(10, (_) => new List(10));
    for (int i = 0; i < 10; i++)
      for (int j = 0; j < 10; j++)
       cpyBoard[i][j] = BoardState.board[i][j];

    doMiniMax(0, AI_turn, -infinity, infinity, cpyBoard);
    if(bestMove!= -1) {
      boardState.placeStone((bestMove / 10).toInt(), bestMove % 10, 0);
    }
  }

}