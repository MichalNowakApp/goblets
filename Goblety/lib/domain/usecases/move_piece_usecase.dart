import '../entities/params/move_piece_params.dart';
import '../repositories/goblet_repository.dart';

class MovePieceUsecase {
  MovePieceUsecase({required this.repository});
  final GobletRepository repository;

  bool call({required MovePieceParams params}) {
    return repository.movePiece(params: params);
  }
}