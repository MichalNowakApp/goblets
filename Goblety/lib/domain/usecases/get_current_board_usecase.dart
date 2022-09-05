import '../repositories/goblet_repository.dart';

class GetCurrentBoardUsecase {
  GetCurrentBoardUsecase({required this.repository});
  final GobletRepository repository;

  List<List<String>> call() {
    return repository.getCurrentBoard();
  }
}