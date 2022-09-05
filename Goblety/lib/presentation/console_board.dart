import 'dart:convert';
import 'dart:io';

import '../data/models/params/move_piece_params_models.dart';
import '../data/models/params/set_piece_params_model.dart';
import '../data/models/player_pieces_model.dart';
import '../domain/entities/coords.dart';
import '../domain/entities/game_state_enum.dart';
import '../domain/entities/pieces/large_piece.dart';
import '../domain/entities/pieces/medium_piece.dart';
import '../domain/entities/pieces/piece.dart';
import '../domain/entities/pieces/small_piece.dart';
import '../domain/usecases/change_active_player_usecase.dart';
import '../domain/usecases/get_active_player_usecase.dart';
import '../domain/usecases/get_current_board_usecase.dart';
import '../domain/usecases/get_game_state_usecase.dart';
import '../domain/usecases/get_player_one_piece_numbers_usecase.dart';
import '../domain/usecases/get_player_two_piece_numbers_usecase.dart';
import '../domain/usecases/move_piece_usecase.dart';
import '../domain/usecases/set_piece_usecase.dart';
import '../domain/usecases/update_game_state_usecase.dart';
import 'board.dart';
import 'player_action_enum.dart';
import 'player_turn_enum.dart';

class ConsoleBoard extends Board {
  ConsoleBoard({
    required this.getCurrentBoardUsecase,
    required this.getGameStateUsecase,
    required this.getPlayerOnePieceNumbersUsecase,
    required this.getPlayerTwoPieceNumbersUsecase,
    required this.setPieceUsecase,
    required this.movePieceUsecase,
    required this.changeActivePlayerUsecase,
    required this.getActivePlayerUsecase,
    required this.updateGameStateUsecase,
  });

  final GetCurrentBoardUsecase getCurrentBoardUsecase;
  final GetGameStateUsecase getGameStateUsecase;
  final GetPlayerOnePieceNumbersUsecase getPlayerOnePieceNumbersUsecase;
  final GetPlayerTwoPieceNumbersUsecase getPlayerTwoPieceNumbersUsecase;
  final SetPieceUsecase setPieceUsecase;
  final MovePieceUsecase movePieceUsecase;
  final ChangeActivePlayerUsecase changeActivePlayerUsecase;
  final GetActivePlayerUsecase getActivePlayerUsecase;
  final UpdateGameStateUsecase updateGameStateUsecase;

  void updateBoard() {
    List<List<String>> board = getCurrentBoardUsecase();
    print("    0     1    2");
    for (int row = 0; row < 3; ++row) {
      print(row.toString() + "  " + board[row][0] + " | " + board[row][1] + " | " + board[row][2]);
    }
    print("");
  }

  @override
  PlayerActionEnum askUserAboutWhatToDo() {
    print("(S)et or (M)ove your piece?");
    var answer = stdin.readLineSync(encoding: utf8)?.toUpperCase();
    switch (answer) {
      case "S":
        {
          return PlayerActionEnum.setPiece;
        }
      case "M":
        {
          return PlayerActionEnum.movePiece;
        }
      default:
        {
          return PlayerActionEnum.typo;
        }
    }
  }

  @override
  void showPlayerPieces() {
    PlayerEnum activePlayer = getActivePlayerUsecase();
    PlayerPiecesModel pieces =
        activePlayer == PlayerEnum.blue ? getPlayerOnePieceNumbersUsecase() : getPlayerTwoPieceNumbersUsecase();
    print(
        "You have ${pieces.smallPieces} small, ${pieces.mediumPieces} medium and ${pieces.largePieces} large pieces.");
    pieces = activePlayer == PlayerEnum.orange ? getPlayerOnePieceNumbersUsecase() : getPlayerTwoPieceNumbersUsecase();
    print(
        "Opponent has ${pieces.smallPieces} small, ${pieces.mediumPieces} medium and ${pieces.largePieces} large pieces.");
  }

  @override
  bool tryToMovePiece() {
    print("From");
    Coords fromCoords = _getCoords();
    print("To");
    Coords toCoords = _getCoords();
    bool success = movePieceUsecase(params: MovePieceParamsModel(fromCoords: fromCoords, toCoords: toCoords));
    if (success) {
      updateGameStateUsecase();
    }
    return success;
  }

  @override
  bool tryToSetPiece() {
    Coords coords = _getCoords();
    Piece piece = _getPiece();
    bool success = setPieceUsecase(params: SetPieceParamsModel(piece: piece, coords: coords));
    if (success) {
      updateGameStateUsecase();
    }
    return success;
  }

  @override
  void showGameState() {
    final String playerName = getActivePlayerUsecase() == PlayerEnum.blue ? "Blue" : "Orange";
    switch (getGameStateUsecase()) {
      case GameStateEnum.gameOngoing:
        {
          print("${playerName} turn");
        }
        break;
      case GameStateEnum.playerOneVictory:
        {
          print("Blue wins!");
        }
        break;
      case GameStateEnum.playerTwoVictory:
        {
          print("Orange wins!");
        }
        break;
      case GameStateEnum.tie:
        {
          print("That's a tie... Sort it with fists.");
        }
        break;
    }
  }

  Coords _getCoords() {
    bool obtainedCoords = false;
    late int x, y;
    while (!obtainedCoords) {
      try {
        print("Enter x coordinate:");
        x = int.parse(stdin.readLineSync(encoding: utf8)!);
        print("Enter y coordinate:");
        y = int.parse(stdin.readLineSync(encoding: utf8)!);
        obtainedCoords = x >= 0 && x <= 2 && y >= 0 && y <= 2;
        if (!obtainedCoords) {
          print("Coordinates should be a numbers from 0 to 2.");
        }
      } catch (err) {
        print("Coordinates should be a numbers from 0 to 2.");
      }
    }
    return Coords(x: x, y: y);
  }

  Piece _getPiece() {
    bool obtainedPiece = false;
    print("(L)arge, (M)edium or (S)mall? Size matter!");
    late String piece;
    while (!obtainedPiece) {
      try {
        piece = stdin.readLineSync(encoding: utf8)!.toUpperCase();
        obtainedPiece = piece == "L" || piece == "M" || piece == "S";
        if (!obtainedPiece) {
          print("(L)arge, (M)edium or (S)mall...");
        }
      } catch (err) {
        print("(L)arge, (M)edium or (S)mall...");
      }
    }
    switch (piece) {
      case "L":
        {
          return LargePiece(owningPlayer: getActivePlayerUsecase());
        }
      case "M":
        {
          return MediumPiece(owningPlayer: getActivePlayerUsecase());
        }
      default:
        {
          return SmallPiece(owningPlayer: getActivePlayerUsecase());
        }
    }
  }

  @override
  void changeActivePlayer() {
    changeActivePlayerUsecase();
  }

  @override
  GameStateEnum getGameState() {
    return getGameStateUsecase();
  }
}
