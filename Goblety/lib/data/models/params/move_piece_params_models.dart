import '../../../domain/entities/coords.dart';
import '../../../domain/entities/params/move_piece_params.dart';

class MovePieceParamsModel extends MovePieceParams {
  MovePieceParamsModel({
    required this.fromCoords,
    required this.toCoords,
  });

  @override
  Coords fromCoords;

  @override
  Coords toCoords;
}
