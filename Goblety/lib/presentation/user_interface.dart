import '../domain/entities/game_state_enum.dart';
import 'board.dart';
import 'player_action_enum.dart';

class UserInterface {
  UserInterface({
    required this.board,
  });

  Board board;

  void startGame() {
    while (_gameOngoing()) {
      bool actionSuccess = false;
      while (!actionSuccess) {
        board.updateBoard();
        board.showGameState();
        PlayerActionEnum action = _getAction();
        actionSuccess = tryToExecuteAction(action);
        if (!actionSuccess) {
          print("Can't touch this :/ Try again. Focus!");
        } else {
          board.changeActivePlayer();
        }
      }
    }
    board.updateBoard();
    board.showGameState();
  }

  bool _gameOngoing() {
    return board.getGameState() == GameStateEnum.gameOngoing;
  }

  PlayerActionEnum _getAction() {
    PlayerActionEnum action = PlayerActionEnum.typo;
    do {
      board.showPlayerPieces();
      action = board.askUserAboutWhatToDo();
      if (action == PlayerActionEnum.typo) {
        print("Come on dude, 'S' or 'M'... You can do it!");
      }
    } while (action == PlayerActionEnum.typo);
    return action;
  }

  bool tryToExecuteAction(PlayerActionEnum action) {
    if (action == PlayerActionEnum.setPiece) {
      return board.tryToSetPiece();
    } else {
      return board.tryToMovePiece();
    }
  }
}
