import '../entities/params/set_piece_params.dart';
import '../repositories/goblet_repository.dart';

class SetPieceUsecase {
  SetPieceUsecase({required this.repository});
  final GobletRepository repository;

  bool call({required SetPieceParams params}) {
    return repository.setPiece(params: params);
  }
}