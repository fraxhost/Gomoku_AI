import 'package:go_game/boardstate.dart';

class GoLogic{

  int rows = 10, coloumns = 10;
  List<List<int>> board;

  int fiveInA_row(int player){

    int stones=0;

    for(int i = 0; i < rows; i++)
      for(int j=0; j <= coloumns-5; j++){
        stones = 0;
        if(board[i][j] == player){
          stones+= 1;
          for(int k =1; k<5; k++){
            if(board[i][j+k] == player) {
              stones += 1;
            }
            else
              break;
          }
          if(stones == 5){
            return i*10+j;
          }
          else
            continue;

        }
      }
    return -1;
  }

  int fiveInA_column(int player){

    int stones=0;
    int k;
    for(int i = 0; i < coloumns; i++)
      for(int j=0; j <= rows-5; j++){
        stones = 0;
        if(board[j][i] == player){
          stones+= 1;
          for(k =1; k<5; k++){
            if(board[j+k][i] == player) {
              stones += 1;
            }
            else
              break;
          }
          if(stones == 5){
            print('col win');
            if(BoardState.board[j][i] == null)
            return j*10+i;
            else
              return j*10+i+40;
          }
          else
            continue;
        }
      }
    return -1;
  }

  int fiveInA_leftDiagonal(int player){

    int stones=0;
    int critcalMove = -1;

    for(int i = 0; i <= rows-5; i++)
      for(int j=4; j < coloumns; j++){
        stones = 0;
        if(board[i][j] == player){
          stones+= 1;
          for(int k =1; k<5; k++){
            if(board[i+k][j-k] == player) {
              stones += 1;
            }
            else
              break;
          }
          if(stones == 5){
            //print('leftwin');
            return i*10+j;
          }
          else
            continue;

        }
      }
    return -1;
  }
  int fiveInA_RightDiagonal(int player){

    int stones=0;

    for(int i = 0; i <= rows-5; i++)
      for(int j=0; j <= coloumns-5; j++){
        stones = 0;
        if(board[i][j] == player){
          stones+= 1;
          for(int k =1; k<5; k++){
            if(board[i+k][j+k] == player) {
              //print('${j} ${i}');
              stones+=1;
            }
            else
              break;
          }
          if(stones == 5) {
            //print('rightwin');
            return i*10+j;
          }
          else
            continue;
        }
      }
    return -1;
  }

  int findTwoOpenEndInRow(int stones, int playerStone){

    for(int r=0;r<rows;r++){
      for(int col = 0; col < coloumns-stones-1; col++){
        //print('TwoInRow ${r} ${col}');
        if(board[r][col]==null && board[r][col+stones+1]==null){
          bool pattern = true;
          for(int k= col+1; k <= col+stones; k++){
            if(board[r][k] != playerStone){
              pattern = false;
              break;
            }
          }
          if(pattern){
            //print('two in row');
            return r*10+col;
          }
        }
      }
    }
   return -1;
  }

  int findTwoOpenEndInColumn(int stones, int playerStone){

    for(int col=0;col<coloumns;col++){
      for(int r = 0; r < rows-stones-1; r++){
      //  print('TwoInColumn ${r} ${col}');
        if(board[r][col] == null && board[r+stones+1][col] == null){
          bool pattern = true;
          for(int k= r+1; k <= r+stones; k++ ){
            if(board[k][col] != playerStone){
              pattern = false;
              break;
            }
          }
          if(pattern) {
            //print('two in col');
            return r*10+col;
          }
        }
      }
    }
    return -1;
  }
  int findTwoOpenEndInRightDiagonal(int stones, int playerStone){

    for(int r = 0; r < rows-stones-1; r++){
      for(int col = 0; col < coloumns-stones-1; col++){
       // print('TwoInRight ${r} ${col}');
        if(board[r][col] == null && board[r+stones+1][col+stones+1] == null){
          bool pattern = true;
          for(int k = 1; k <= stones;k++) {
            if(board[r+k][col+k] != playerStone){
              pattern = false;
              break;
            }
          }
          if(pattern) {
            //print('two in right');
            return r*10+col;
          }
        }
      }
    }
    return -1;
  }

  int findTwoOpenEndInLeftDiagonal(int stones, int playerStone){

    for(int r = 0; r < rows-stones-1; r++){
      for(int col = stones+1; col < coloumns; col++){
       // print('TwoInLeft ${r} ${col}');
        if(board[r][col] == null && board[r+stones+1][col-stones-1] == null){
          bool pattern = true;
          for(int k = 1; k <= stones;k++) {
            if(board[r+k][col-k] != playerStone){
              pattern = false;
              break;
            }
          }
          if(pattern){
            return r*10+col;
          }
        }
      }
    }
    return -1;
  }
  bool findOneOpenEndInRow(int stones, int playerStone){

    for(int r= 0; r < rows; r++){
      for(int col = 0; col < coloumns-stones; col++){
       // print('OneInRow ${r} ${col}');
        if(board[r][col] == null){
          bool pattern = true;
            for(int k= col + 1; k <= col + stones; k++){
                if(board[r][k] != playerStone){
                  pattern = false;
                  break;
                }
            }
            if(pattern)
              return true;
        }
      }
      for(int colRev = coloumns-1; colRev >= coloumns-stones; colRev--){
       // print('OneInRowRev ${r} ${colRev}');
        if(board[r][colRev]==null){
          bool pattern = true;
          for(int k = colRev-stones; k < colRev; k++){
            if(board[r][k] != playerStone){
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

  bool findOneOpenEndInColumn(int stones, int playerStone){

    for(int col=0; col < coloumns; col++){
      for(int r =0; r < rows-stones; r++){
        //print('OneInCol ${r} ${col}');
        if(board[r][col] == null){
          bool pattern = true;
          for(int k= r + 1; k <= r + stones; k++){
            if(board[k][col] != playerStone){
              pattern = false;
              break;
            }
          }
          if(pattern) {
           //print('col 4 1 found');
            return true;
          }
        }
      }
      for(int rowRev = rows-1; rowRev >= rows-stones; rowRev--){
       // print('OneInColRev ${rowRev} ${col}');
        if(board[rowRev][col]==null){
          bool pattern = true;
          for(int k = rowRev-stones; k < rowRev; k++){
            if(board[k][col] != playerStone){
              pattern = false;
              break;
            }
          }
          if(pattern) {
           print('col 4 1 found');
            return true;
          }
        }
      }
    }
    return false;
  }

  bool findOneOpenEndInLeftDiagonal(int stones, int playerStone){

    for(int r = 0; r < rows-stones; r++){
      for(int col = stones; col < coloumns; col++){
       // print('OneInLeft ${r} ${col}');
        if(board[r][col] == null){
          bool pattern = true;
          for(int k = 1; k <= stones;k++) {
            if(board[r+k][col-k] != playerStone){
              pattern = false;
              break;
            }
          }
          if(pattern)
            return true;
        }
        else if(board[r+stones][col-stones] != playerStone){
         // print('OneInLeft ${r} ${col}');
          bool pattern = true;
          for(int k= 0; k<stones; k++){
            if(board[r+k][col-k] != playerStone){
              pattern =false;
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

  bool findOneOpenEndInRightDiagonal(int stones, int playerStone){

    for(int r = 0; r < rows-stones; r++){
      for(int col = 0; col < coloumns-stones; col++){
        //print('OneInRight ${r} ${col}');
        if(board[r][col] == null){
          bool pattern = true;
          for(int k = 1; k <= stones;k++) {
            if(board[r+k][col+k] != playerStone){
              pattern = false;
              break;
            }
          }
          if(pattern){
            //print('right dia found');
            return true;
          }
        }
        else if(board[r+stones][col+stones] == null){
         // print('OneInRight ${r} ${col}');
          bool pattern = true;
          for(int k= 0; k<stones; k++){
            if(board[r+k][col+k] != playerStone){
              pattern =false;
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

  int searchForTwoOpenEnd(int stones, int playerStone, List<List<int>> cBoard){

    board = cBoard;
    //return (findTwoOpenEndInColumn(stones, playerStone) || findTwoOpenEndInRightDiagonal(stones, playerStone) ||
      //  findTwoOpenEndInLeftDiagonal(stones, playerStone));
    int critcalMove = findTwoOpenEndInRow(stones,playerStone);
    if(critcalMove>-1)
      return critcalMove;
    critcalMove = findTwoOpenEndInColumn(stones,playerStone);
    if(critcalMove>-1)
      return critcalMove;
    critcalMove = findTwoOpenEndInLeftDiagonal(stones,playerStone);
    if(critcalMove>-1)
      return critcalMove;
    critcalMove = findTwoOpenEndInRightDiagonal(stones,playerStone);
    if(critcalMove>-1)
      return critcalMove;

    return -1;
  }

  bool searchForOneOpenEnd(int stones, int playerStone, List<List<int>> cBoard){

    board = cBoard;
   // return (findOneOpenEndInColumn(stones, playerStone) || findOneOpenEndInRightDiagonal(stones, playerStone)||
   // findOneOpenEndInLeftDiagonal(stones, playerStone));
    return (findOneOpenEndInRow(stones, playerStone) || findOneOpenEndInColumn(stones, playerStone) ||
        findOneOpenEndInLeftDiagonal(stones, playerStone) || findOneOpenEndInRightDiagonal(stones, playerStone));
  }
  int highFiveAfter(int player){

    board = BoardState.board;

    int critcalMove = fiveInA_row(player);
    if(critcalMove>-1)
      return critcalMove;
    critcalMove = fiveInA_column(player);
    if(critcalMove>-1)
      return critcalMove;
    critcalMove = fiveInA_leftDiagonal(player);
    if(critcalMove>-1)
      return critcalMove;
    critcalMove = fiveInA_RightDiagonal(player);
    if(critcalMove>-1)
      return critcalMove;
    return -1;
  }

  int highFive(List<List<int>> recievedBoard, int player){

    board = recievedBoard;

    int critcalMove = fiveInA_row(player);
    if(critcalMove>-1) {
      return critcalMove;
    }
    critcalMove = fiveInA_column(player);
    if(critcalMove>-1)
      return critcalMove;
    critcalMove = fiveInA_leftDiagonal(player);
    if(critcalMove>-1)
      return critcalMove;
    critcalMove = fiveInA_RightDiagonal(player);
    if(critcalMove>-1)
      return critcalMove;

    return -1;
  }


  int evaluateGameTree(bool AI_turn, List<List<int>> cboard){

    board = cboard;
    int sign = (AI_turn)? 1 : -1;
    int myStone = (AI_turn)? 0 : 1;
    int opponentStone = (myStone == 0)? 1 : 0;

    int value =0;

    /*value += (searchForTwoOpenEnd(4, 0))?100000*1:1;
    value += (searchForOneOpenEnd(4, 0))?550000*1:1;
    value += (searchForTwoOpenEnd(3, 0))?540*1:1;
    value += (searchForOneOpenEnd(3, 0))?50*1:1;
    value += (searchForTwoOpenEnd(2, 0))?10*1:1;
    value += (searchForOneOpenEnd(2, 0))?5*1:1;

    value -= (searchForTwoOpenEnd(4, 1))?101000*1:1;
    value -= (searchForOneOpenEnd(4, 1))?510*1:1;
    value -= (searchForTwoOpenEnd(3, 1))?530*1:1;
    value -= (searchForOneOpenEnd(3, 1))?60*1:1;
    value -= (searchForTwoOpenEnd(2, 1))?15*1:1;
    value -= (searchForOneOpenEnd(2, 1))?8*1:1;

    return value;
    if(highFive(0))
      return 1000000000;
    if(highFive(1))
      return -1000000000;*/

    if(searchForTwoOpenEnd(4, myStone,board)>-1)
      return sign*100000000;
    if(searchForTwoOpenEnd(4, opponentStone,board)>-1)
     return -sign*500000;

    if(searchForOneOpenEnd(4, myStone,board))
      return sign*100000000;
    if(searchForOneOpenEnd(4, opponentStone,board))
      return -sign*50;

    if(searchForTwoOpenEnd(3, myStone, board)>-1)
      return sign*10000;

    if(searchForTwoOpenEnd(3, opponentStone,board)>-1)
      return -sign*50;

    if(searchForOneOpenEnd(3, myStone,board) )
      return sign*7;
    if(searchForOneOpenEnd(3, opponentStone,board))
      return -sign*5;

    if(searchForTwoOpenEnd(2, myStone, board)>-1 )
      return sign*5;
    if(searchForTwoOpenEnd(2, opponentStone, board)>-1 )
      return -sign*5;

    if(searchForOneOpenEnd(2, myStone,board) )
      return sign*3;
    if(searchForOneOpenEnd(2, opponentStone,board) )
      return -sign*3;

    if(searchForTwoOpenEnd(1, myStone, board)>-1 )
      return sign*2;
    if(searchForTwoOpenEnd(1, opponentStone, board)>-1)
      return -sign*2;
    if(searchForOneOpenEnd(1, myStone,board) )
      return sign*1;

    if(searchForOneOpenEnd(1, opponentStone,board) )
      return -sign*1;

    return 200000000;
  }

}
