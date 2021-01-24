import 'package:go_game/boardstate.dart';

class GoLogic{

  int rows = 10, coloumns = 10;

  bool fiveInA_row(int player){

    BoardState board = new BoardState();
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

    BoardState board = new BoardState();

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

    BoardState board = new BoardState();

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

    BoardState board = new BoardState();

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

  bool findTwoOpenEndInRow(int stones, int playerStone){

    for(int r=0;r<rows;r++){
      for(int col = 0; col < coloumns-stones-1; col++){

        if(BoardState.board[r][col]==null && BoardState.board[r][col+stones+1]==null){
          bool pattern = true;
          for(int k= col+1; k <= col+stones; k++){
            if(BoardState.board[r][k] != playerStone){
              pattern = false;
              break;
            }
          }
          if(pattern)
            return true;
        }
      }
    }
   return false;
  }

  bool findTwoOpenEndInColumn(int stones, int playerStone){

    for(int col=0;col<coloumns;col++){
      for(int r = 0; r < rows-stones-1; r++){
        if(BoardState.board[col][r] == null && BoardState.board[col][r+stones+1] == null){
          bool pattern = true;
          for(int k= r+1; k <= r+stones; k++ ){
            if(BoardState.board[k][col] != playerStone){
              pattern = false;
              break;
            }
          }
          if(pattern)
            return true;
        }
      }
    }
    return false;
  }
  bool findTwoOpenEndInRightDiagonal(int stones, int playerStone){

    for(int r = 0; r < rows-stones-1; r++){
      for(int col = 0; col < coloumns-stones-1; col++){
        if(BoardState.board[r][col] == null && BoardState.board[r][col]== BoardState.board[r+stones+1][col+stones+1]){
          bool pattern = true;
          for(int k = 1; k <= stones;k++) {
            if(BoardState.board[r+k][col+k] != playerStone){
              pattern = false;
              break;
            }
          }
          if(pattern)
            return true;
        }
      }
    }
    return false;
  }

  bool findTwoOpenEndInlLeftDiagonal(int stones, int playerStone){

    for(int r = 0; r < rows-stones-1; r++){
      for(int col = stones+1; col < coloumns; col++){
        if(BoardState.board[r][col] == null && BoardState.board[r+stones+1][col-stones-1] == null){
          bool pattern = true;
          for(int k = 1; k <= stones;k++) {
            if(BoardState.board[r+k][col-k] != playerStone){
              pattern = false;
              break;
            }
          }
          if(pattern)
            return true;
        }
      }
    }
    return false;
  }
  bool findOneOpenEndInRow(int stones, int playerStone){

    for(int r=0; r < rows; r++){
      for(int col =0; col < rows-stones; col++){

        if(BoardState.board[r][col] == null){
          bool pattern = true;
            for(int k= col + 1; k <= col + stones; col++){
                if(BoardState.board[r][col] != playerStone){
                  pattern = false;
                  break;
                }
            }
            if(pattern)
              return true;
        }
      }
      for(int colRev = rows-1; colRev >= rows-stones; colRev--){
        if(BoardState.board[r][colRev]==null){
          bool pattern = true;
          for(int k = colRev-stones; k < colRev; k++){
            if(BoardState.board[r][colRev] != playerStone){
              pattern = false;
              break;
            }
          }
          if(pattern)
            return true;
        }
      }
    }
    return false;
  }
}