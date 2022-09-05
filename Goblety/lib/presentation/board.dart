import '../domain/entities/game_state_enum.dart';
import 'player_action_enum.dart';

abstract class Board {
  void updateBoard();
  void showPlayerPieces();
  void showGameState();
  PlayerActionEnum askUserAboutWhatToDo();
  bool tryToSetPiece();
  bool tryToMovePiece();
  void changeActivePlayer();
  GameStateEnum getGameState();
}