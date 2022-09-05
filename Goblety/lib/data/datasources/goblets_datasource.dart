import '../../domain/entities/game_state_enum.dart';
import '../../domain/entities/params/move_piece_params.dart';
import '../../domain/entities/params/set_piece_params.dart';
import '../../domain/entities/pieces/medium_piece.dart';
import '../../domain/entities/pieces/piece.dart';
import '../../domain/entities/pieces/small_piece.dart';
import '../../presentation/player_turn_enum.dart';
import '../models/board_model.dart';
import '../models/params/set_piece_params_model.dart';
import '../models/player_pieces_model.dart';

abstract class GobletsDatasource {
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

class GobletsDatasourceImpl extends GobletsDatasource {
  GobletsDatasourceImpl()
      : _bluePieces = PlayerPiecesModel(smallPieces: 2, mediumPieces: 2, largePieces: 2),
        _orangePieces = PlayerPiecesModel(smallPieces: 2, mediumPieces: 2, largePieces: 2),
        gameState = GameStateEnum.gameOngoing,
        activePlayer = PlayerEnum.blue {
    boardModel = BoardModel();
  }

  final PlayerPiecesModel _bluePieces;
  final PlayerPiecesModel _orangePieces;
  late final BoardModel boardModel;
  GameStateEnum gameState;
  PlayerEnum activePlayer;

  @override
  List<List<String>> getCurrentBoard() {
    List<List<String>> board = List.generate(3, (i) => List.filled(3, "   ", growable: false), growable: false);
    for (int row = 0; row < 3; ++row) {
      for (int column = 0; column < 3; ++column) {
        Piece? piece = boardModel.pieces[row][column];
        if (piece != null) {
          board[row][column] = piece.stringRepresentation();
        }
      }
    }
    return board;
  }

  @override
  GameStateEnum getGameState() {
    return gameState;
  }

  @override
  PlayerEnum getActivePlayer() {
    return activePlayer;
  }

  @override
  PlayerPiecesModel getPlayerOnePieceNumbers() {
    return _bluePieces;
  }

  @override
  PlayerPiecesModel getPlayerTwoPieceNumbers() {
    return _orangePieces;
  }

  @override
  void changeActivePlayer() {
    activePlayer = activePlayer == PlayerEnum.orange ? PlayerEnum.blue : PlayerEnum.orange;
  }

  @override
  bool movePiece({required MovePieceParams params}) {
    Piece? movedPiece = boardModel.pieces[params.fromCoords.x][params.fromCoords.y];
    if (movedPiece == null) {
      return false;
    }
    if (movedPiece.owningPlayer != activePlayer) {
      return false;
    }
    bool success = _placePiece(params: SetPieceParamsModel(piece: movedPiece, coords: params.toCoords));
    if (!success) {
      return false;
    }
    boardModel.pieces[params.fromCoords.x][params.fromCoords.y] = movedPiece.pieceBeneath();
    return true;
  }

  @override
  bool setPiece({required SetPieceParams params}) {
    Piece piece = params.piece;
    bool pieceAvailable = _checkIfPieceAvailable(piece);
    if (!pieceAvailable) {
      return false;
    }
    bool piecePlaced = _placePiece(params: params);
    if (!piecePlaced) {
      return false;
    }
    _takePiece(piece);
    return true;
  }

  bool _checkIfPieceAvailable(Piece piece) {
    PlayerPiecesModel playerPieces = activePlayer == PlayerEnum.blue ? _bluePieces : _orangePieces;
    if (piece is SmallPiece) {
      if (playerPieces.smallPieces == 0) {
        return false;
      }
    } else if (piece is MediumPiece) {
      if (playerPieces.mediumPieces == 0) {
        return false;
      }
    } else {
      if (playerPieces.largePieces == 0) {
        return false;
      }
    }
    return true;
  }

  void _takePiece(Piece piece) {
    if (piece is SmallPiece) {
      activePlayer == PlayerEnum.blue ? _bluePieces.smallPieces-- : _orangePieces.smallPieces--;
    } else if (piece is MediumPiece) {
      activePlayer == PlayerEnum.blue ? _bluePieces.mediumPieces-- : _orangePieces.mediumPieces--;
    } else {
      activePlayer == PlayerEnum.blue ? _bluePieces.largePieces-- : _orangePieces.largePieces--;
    }
  }

  bool _placePiece({required SetPieceParams params}) {
    Piece newPiece = params.piece;
    Piece? currentPiece = boardModel.pieces[params.coords.x][params.coords.y];
    bool success = newPiece.setOn(currentPiece);
    if (success) {
      boardModel.pieces[params.coords.x][params.coords.y] = newPiece;
    }
    return success;
  }

  @override
  void updateGameState() {
    for (int iterator = 0; iterator < 3; ++iterator) {
      if (boardModel.pieces[iterator][0] != null &&
          boardModel.pieces[iterator][1] != null &&
          boardModel.pieces[iterator][2] != null) {
        if (boardModel.pieces[iterator][0]!.owningPlayer == boardModel.pieces[iterator][1]!.owningPlayer &&
            boardModel.pieces[iterator][1]!.owningPlayer == boardModel.pieces[iterator][2]!.owningPlayer) {
          _updateGameState(boardModel.pieces[iterator][0]!.owningPlayer == PlayerEnum.blue
              ? GameStateEnum.playerOneVictory
              : GameStateEnum.playerTwoVictory);
        }
      }
      if (boardModel.pieces[0][iterator] != null &&
          boardModel.pieces[1][iterator] != null &&
          boardModel.pieces[2][iterator] != null) {
        if (boardModel.pieces[0][iterator]!.owningPlayer == boardModel.pieces[1][iterator]!.owningPlayer &&
            boardModel.pieces[1][iterator]!.owningPlayer == boardModel.pieces[2][iterator]!.owningPlayer) {
          _updateGameState(boardModel.pieces[0][iterator]!.owningPlayer == PlayerEnum.blue
              ? GameStateEnum.playerOneVictory
              : GameStateEnum.playerTwoVictory);
        }
      }
    }
    for (int iterator = 0; iterator < 2; ++iterator) {
      if (boardModel.pieces[2 - iterator * 2][2 - iterator * 2] != null &&
          boardModel.pieces[1][1] != null &&
          boardModel.pieces[iterator * 2][iterator * 2] != null) {
        if (boardModel.pieces[2 - iterator * 2][2 - iterator * 2]!.owningPlayer ==
                boardModel.pieces[1][1]!.owningPlayer &&
            boardModel.pieces[1][1]!.owningPlayer ==
                boardModel.pieces[iterator * 2][iterator * 2]!.owningPlayer) {
          _updateGameState(boardModel.pieces[2 - iterator * 2][2 - iterator * 2]!.owningPlayer == PlayerEnum.blue
              ? GameStateEnum.playerOneVictory
              : GameStateEnum.playerTwoVictory);
        }
      }
    }
  }

  void _updateGameState(GameStateEnum newGameState) {
    if (newGameState == GameStateEnum.playerOneVictory && gameState == GameStateEnum.playerTwoVictory ||
        newGameState == GameStateEnum.playerTwoVictory && gameState == GameStateEnum.playerOneVictory) {
      gameState = GameStateEnum.tie;
    } else {
      gameState = newGameState;
    }
  }
}
