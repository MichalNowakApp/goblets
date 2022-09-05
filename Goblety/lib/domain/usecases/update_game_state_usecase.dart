import '../repositories/goblet_repository.dart';

class UpdateGameStateUsecase {
  UpdateGameStateUsecase({required this.repository});
  final GobletRepository repository;

  void call() {
    return repository.updateGameState();
  }
}