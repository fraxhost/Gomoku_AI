class BoardState {
  static var board = new List.generate(10, (_) => new List(10));
  static var turn = 0;

  void run() {
    print(board);
  }
}
