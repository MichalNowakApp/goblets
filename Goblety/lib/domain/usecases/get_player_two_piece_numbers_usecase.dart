import '../../data/models/player_pieces_model.dart';
import '../repositories/goblet_repository.dart';

class GetPlayerTwoPieceNumbersUsecase {
  GetPlayerTwoPieceNumbersUsecase({required this.repository});
  final GobletRepository repository;

  PlayerPiecesModel call() {
    return repository.getPlayerTwoPieceNumbers();
  }
}