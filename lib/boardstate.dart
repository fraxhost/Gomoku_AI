class BoardState {
  static var board = new List.generate(10, (_) => new List(10));
  static var turn = 0;

  void placeStone(int x, int y, int player){
    board[x][y] = player;
  }

  List<List<int>> getBoard(){
    return board;
  }

  void run() {
    print(board);
  }
}