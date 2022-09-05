import '../../domain/entities/pieces/piece.dart';

class BoardModel {
  BoardModel() : pieces = List.generate(3, (i) => List.filled(3, null, growable: false), growable: false);
  List<List<Piece?>> pieces;
}
