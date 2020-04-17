import 'package:flutter/material.dart';

enum Turn { CROSS, CIRCLE, OVER }
enum Winner { CROSS, CIRCLE, NONE }

class TicTacToe extends ChangeNotifier {
  Turn _turn = Turn.CIRCLE;
  Winner _winner = Winner.NONE;

  // ignore: unnecessary_getters_setters
  Turn get turn => _turn;

  // ignore: unnecessary_getters_setters
  set turn(Turn turn) {
    _turn = turn;
  }

  List<int> matrix = List.generate(9, (i) {
    return null;
  });

  getTurnString() {
    if (turn == Turn.CROSS) {
      return "Cross turn.";
    } else if (turn == Turn.CIRCLE) {
      return "Circle turn.";
    } else if (turn == Turn.OVER) {
      return "Game Over";
    } else {
      return "Nobody turn.";
    }
  }

  getWinnerString() {
    if (_winner == Winner.CIRCLE) {
      return "Circle won the game.";
    } else if (_winner == Winner.CROSS) {
      return "Cross won the game.";
    } else {
      return "";
    }
  }

  newGame() {
    print("new game");

    matrix = List.generate(9, (i) {
      return null;
    });
    _turn = Turn.CIRCLE;
    _winner = Winner.NONE;
    notifyListeners();
  }

  updateMatrix(int i) {
    if (matrix[i] == null) {
      matrix[i] = turn == Turn.CIRCLE ? 1 : 0;
      changeTurn();
    }
    checkWinner();
    print(matrix);
    notifyListeners();
  }

  matrixInfo(int i) {
    return matrix[i];
  }

  getTurn() => turn;
  gameFinished() {
    return allFilledUp() || _winner == Winner.CROSS || _winner == Winner.CIRCLE;
  }

  changeTurn() {
    if (allFilledUp()) {
      turn = Turn.OVER;
    } else {
      if (turn == Turn.CROSS) {
        turn = Turn.CIRCLE;
      } else if (turn == Turn.CIRCLE) {
        turn = Turn.CROSS;
      }
    }
    notifyListeners();
  }

  allFilledUp() {
    for (int x in matrix) {
      if (x == null) {
        return false;
      }
    }
    return true;
  }

  checkWinner() {
    crossWins();
    circleWins();
    notifyListeners();
  }

  crossWins() {
    if (horizontalCheck(0) || verticalCheck(0) || diagonalCheck(0)) {
      _winner = Winner.CROSS;
      _turn = Turn.OVER;
    }
  }

  circleWins() {
    if (horizontalCheck(1) || verticalCheck(1) || diagonalCheck(1)) {
      _winner = Winner.CIRCLE;
      _turn = Turn.OVER;
    }
  }

  horizontalCheck(int i) {
    if (matrix[0] == i && matrix[1] == i && matrix[2] == i) {
      return true;
    }
    if (matrix[3] == i && matrix[4] == i && matrix[5] == i) {
      return true;
    }
    if (matrix[6] == i && matrix[7] == i && matrix[8] == i) {
      return true;
    }
    return false;
  }

  verticalCheck(int i) {
    if (matrix[0] == i && matrix[3] == i && matrix[6] == i) {
      return true;
    }
    if (matrix[1] == i && matrix[4] == i && matrix[7] == i) {
      return true;
    }
    if (matrix[2] == i && matrix[5] == i && matrix[8] == i) {
      return true;
    }
    return false;
  }

  diagonalCheck(int i) {
    if (matrix[0] == i && matrix[4] == i && matrix[8] == i) {
      return true;
    }
    if (matrix[2] == i && matrix[4] == i && matrix[6] == i) {
      return true;
    }
    return false;
  }
}
