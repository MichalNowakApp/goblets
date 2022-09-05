import '../entities/game_state_enum.dart';
import '../repositories/goblet_repository.dart';

class GetGameStateUsecase {
  GetGameStateUsecase({required this.repository});
  final GobletRepository repository;

  GameStateEnum call() {
    return repository.getGameState();
  }
}