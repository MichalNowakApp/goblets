import '../pieces/piece.dart';
import '../coords.dart';

abstract class SetPieceParams {
  Piece get piece;
  Coords get coords;
}