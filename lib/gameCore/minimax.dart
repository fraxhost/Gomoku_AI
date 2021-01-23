import 'dart:math';

import 'package:go_game/boardstate.dart';
import 'package:go_game/gameCore/stoneMove.dart';

class MiniMax{

  int humanPlayer = 1, go_AI = 0, maxDepth = 3, boardSize = 10;
  StoneMove optimalMove;
  List<int> adjacentCellsX = [ 0, 0, 1, -1, -1, 1, -1, 1];
  List<int> adjacentCellsY = [1, -1, 0, 0, 1, -1, -1, 1];

  bool isMoveValid(int x, int y){

    if((x < 0 || x >= boardSize) && (y < 0 || y >= boardSize))
      return false;
    else
      return true;
  }

  bool findAdjacentStone(int x, int y){

    for(int i=0; i< adjacentCellsX.length; i++){
        x+= adjacentCellsX[i];
        y+= adjacentCellsY[i];

        if(!isMoveValid(x, y))
          continue;
        else if(BoardState.board[x][y] != null)
          return true;
    }
    return false;
  }

  int evaluateGameTree(bool AI_turn){

    int profit = 0;
    int myStone = (AI_turn == true)? 0 : 1;

    if()
  }
  int doMiniMax(int depth, bool AI_turn, int alpha, int beta){

    if(depth == maxDepth){
      return evaluateGameTree(!AI_turn);
    }
      if(AI_turn){

        int maxProfit = -100000000000;

        for(int i=0;i<boardSize;i++){

          if(alpha >= beta)
            return maxProfit;

          for(int j=0;j<boardSize;j++){

            if(!findAdjacentStone(i, j))
              continue;

            else if(BoardState.board[i][j]==null){
              BoardState.board[i][j] = 0;
              maxProfit = max(maxProfit, doMiniMax(depth+1, !AI_turn, alpha, beta));
              if(maxProfit > alpha){
                alpha = maxProfit;
                optimalMove = new StoneMove(i, j);
              }
              if(alpha >= beta)
                return maxProfit;
            }

          }
        }
      }

      if(!AI_turn){

        int maxProfit = 100000000000;

        for(int i=0;i<boardSize;i++){

          if(beta <= alpha)
            return maxProfit;

          for(int j=0;j<boardSize;j++){

            if(!findAdjacentStone(i, j))
              continue;

            else if(BoardState.board[i][j]==null){
              BoardState.board[i][j] = 0;
              maxProfit = max(maxProfit, doMiniMax(depth+1, !AI_turn, alpha, beta));
              if(maxProfit  < beta){
                beta = maxProfit;
                optimalMove = new StoneMove(i, j);
              }
              if(beta <= alpha)
                return maxProfit;
            }

          }
        }
      }
  }
  StoneMove getOptimalMove_AI(BoardState board){

    int maxProfit, alpha = -1000000000000, beta = 1000000000000, moveProfit;
    bool AI_turn= true;

    maxProfit = doMiniMax(0, AI_turn, alpha, beta);
  }

}