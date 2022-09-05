import '../../domain/entities/game_state_enum.dart';
import '../../domain/entities/params/move_piece_params.dart';
import '../../domain/entities/params/set_piece_params.dart';
import '../../domain/repositories/goblet_repository.dart';
import '../../presentation/player_turn_enum.dart';
import '../datasources/goblets_datasource.dart';
import '../models/player_pieces_model.dart';

class GobletRepositoryImpl extends GobletRepository {
  GobletRepositoryImpl({required this.datasource});

  GobletsDatasource datasource;

  @override
  List<List<String>> getCurrentBoard() {
    return datasource.getCurrentBoard();
  }

  @override
  GameStateEnum getGameState() {
    return datasource.getGameState();
  }

  @override
  PlayerPiecesModel getPlayerOnePieceNumbers() {
    return datasource.getPlayerOnePieceNumbers();
  }

  @override
  PlayerPiecesModel getPlayerTwoPieceNumbers() {
    return datasource.getPlayerTwoPieceNumbers();
  }

  @override
  PlayerEnum getActivePlayer(){
    return datasource.getActivePlayer();
  }

  @override
  void changeActivePlayer() {
    return datasource.changeActivePlayer();
  }

  @override
  bool movePiece({required MovePieceParams params}) {
    return datasource.movePiece(params: params);
  }

  @override
  bool setPiece({required SetPieceParams params}) {
    return datasource.setPiece(params: params);
  }

  @override
  void updateGameState() {
    return datasource.updateGameState();
  }
}
