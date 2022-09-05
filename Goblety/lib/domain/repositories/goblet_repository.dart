import '../../data/models/player_pieces_model.dart';
import '../../presentation/player_turn_enum.dart';
import '../entities/game_state_enum.dart';
import '../entities/params/move_piece_params.dart';
import '../entities/params/set_piece_params.dart';

abstract class GobletRepository {
  List<List<String>> getCurrentBoard();
  PlayerPiecesModel getPlayerOnePieceNumbers();
  PlayerPiecesModel getPlayerTwoPieceNumbers();
  GameStateEnum getGameState();
  PlayerEnum getActivePlayer();
  void changeActivePlayer();
  bool setPiece({required SetPieceParams params});
  bool movePiece({required MovePieceParams params});
  void updateGameState();
}
