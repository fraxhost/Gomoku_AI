
import 'package:go_game/gameCore/goBoard.dart';

class GoLogic{

  int rows = 10, coloumns = 10;

  bool fiveInA_row(int player){

    GoBoard board = new GoBoard();
    List<List<int>> currentBoard = board.getBoard();
    int stones=0;

    for(int i = 0; i < rows; i++)
      for(int j=0; j <= coloumns-5; j++){

        if(currentBoard[i][j] == player){
          stones+= 1;
          for(int k =1; k<5; k++){
            if(currentBoard[i][++j] == player) {
              stones += 1;
            }
            else
              break;
          }
          if(stones == 5)
            return true;
          else
            continue;
          stones = 0;
        }
      }

    return false;
  }

  bool fiveInA_column(int player){

    GoBoard board = new GoBoard();

    List<List<int>> currentBoard = board.getBoard();
    int stones=0;

    for(int i = 0; i < coloumns; i++)
      for(int j=0; j <= rows-5; j++){

        if(currentBoard[i][j] == player){
          stones+= 1;
          for(int k =1; k<5; k++){
            if(currentBoard[i][++j] == player) {
              stones += 1;
            }
            else
              break;
          }
          if(stones == 5)
            return true;
          else
            continue;
          stones = 0;
        }
      }
    return false;
  }

  bool fiveInA_leftDiagonal(int player){

    GoBoard board = new GoBoard();

    List<List<int>> currentBoard = board.getBoard();
    int stones=0;

    for(int i = 0; i <= rows-5; i++)
      for(int j=0; j <= coloumns-5; j++){

        if(currentBoard[i][j+4] == player){
          stones+= 1;
          for(int k =1; k<5; k++){
            if(currentBoard[i+1][j-k+4] == player) {
              stones += 1;
            }
            else
              break;
          }
          if(stones == 5)
            return true;
          else
            continue;
          stones = 0;
        }
      }
    return false;
  }
  bool fiveInA_RightDiagonal(int player){

    GoBoard board = new GoBoard();

    List<List<int>> currentBoard = board.getBoard();
    int stones=0;

    for(int i = 0; i <= rows-5; i++)
      for(int j=0; j <= coloumns-5; j++){

        if(currentBoard[i][j] == player){
          stones+= 1;
          for(int k =1; k<5; k++){
            if(currentBoard[i+1][j+1] == player) {
              stones += 1;
            }
            else
              break;
          }
          if(stones == 5)
            return true;
          else
            continue;
          stones = 0;
        }
      }
    return false;
  }

}
