import '../../../presentation/player_turn_enum.dart';

abstract class Piece {
  PlayerEnum get owningPlayer;

  String stringRepresentation();
  Piece? pieceBeneath();
  bool setOn(Piece? piece);
  Piece copy();
}