class BoardState {
  static List<List<int>> board = new List.generate(10, (_) => new List(10));
  List<List<int>> tmpBoard;
  static var turn = 1;
  static int currentPlayer=1;

  void placeStone(int x, int y, int player){
    board[x][y] = player;
    turn++;
  }
  /*List<List<int>> copyBoard(){
    var cpb = new List.generate(10, (_) => new List(10));
    for (int i = 0; i < 10; i++)
      for (int j = 0; j < 10; j++)
        cpb[i][j]=board[i][j];
    return cpb;
  }*/
  void clearBoard(){
    for (int i = 0; i < 10; i++)
      for (int j = 0; j < 10; j++)
        board[i][j]=null;
      turn = 1;
  }
  int tileState(int i, int j){
    return board[i][j];
  }

  bool isDraw() {
    for (int i = 0; i < 10; i++)
      for (int j = 0; j < 10; j++)
        if (board[i][j] == null)
          return false;

    return true;
  }
  int getPlayer(){
    return (turn % 2 == 1)? 1 : 0;
  }
  void changePlayer(){
    turn = (turn % 2 == 1)? 0 : 1;
  }
  void run() {
   // print(board);
  }
}