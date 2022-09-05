import '../coords.dart';

abstract class MovePieceParams {
  Coords get fromCoords;
  Coords get toCoords;
}