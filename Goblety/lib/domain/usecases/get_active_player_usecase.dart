import '../../presentation/player_turn_enum.dart';
import '../repositories/goblet_repository.dart';

class GetActivePlayerUsecase {
  GetActivePlayerUsecase({required this.repository});
  final GobletRepository repository;

  PlayerEnum call() {
    return repository.getActivePlayer();
  }
}