import '../repositories/goblet_repository.dart';

class ChangeActivePlayerUsecase {
  ChangeActivePlayerUsecase({required this.repository});
  final GobletRepository repository;

  void call() {
    return repository.changeActivePlayer();
  }
}