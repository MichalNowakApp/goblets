import '../../../domain/entities/coords.dart';
import '../../../domain/entities/params/set_piece_params.dart';
import '../../../domain/entities/pieces/piece.dart';

class SetPieceParamsModel extends SetPieceParams {
  SetPieceParamsModel({
    required this.piece,
    required this.coords,
  });

  Piece piece;
  Coords coords;
}
