import '../lib/data/datasources/goblets_datasource.dart';
import '../lib/data/repositories/goblet_repository_impl.dart';
import '../lib/domain/usecases/change_active_player_usecase.dart';
import '../lib/domain/usecases/get_active_player_usecase.dart';
import '../lib/domain/usecases/get_current_board_usecase.dart';
import '../lib/domain/usecases/get_game_state_usecase.dart';
import '../lib/domain/usecases/get_player_one_piece_numbers_usecase.dart';
import '../lib/domain/usecases/get_player_two_piece_numbers_usecase.dart';
import '../lib/domain/usecases/move_piece_usecase.dart';
import '../lib/domain/usecases/set_piece_usecase.dart';
import '../lib/domain/usecases/update_game_state_usecase.dart';
import '../lib/presentation/console_board.dart';
import '../lib/presentation/user_interface.dart';

void main() {
  final datasource = GobletsDatasourceImpl();
  final repository = GobletRepositoryImpl(datasource: datasource);
  UserInterface userInterface = UserInterface(
    board: ConsoleBoard(
        getCurrentBoardUsecase: GetCurrentBoardUsecase(
          repository: repository,
        ),
        getGameStateUsecase: GetGameStateUsecase(repository: repository),
        getPlayerOnePieceNumbersUsecase: GetPlayerOnePieceNumbersUsecase(repository: repository),
        getPlayerTwoPieceNumbersUsecase: GetPlayerTwoPieceNumbersUsecase(repository: repository),
        setPieceUsecase: SetPieceUsecase(repository: repository),
        movePieceUsecase: MovePieceUsecase(repository: repository),
        changeActivePlayerUsecase: ChangeActivePlayerUsecase(repository: repository),
        getActivePlayerUsecase: GetActivePlayerUsecase(repository: repository),
        updateGameStateUsecase: UpdateGameStateUsecase(repository: repository)),
  );

  userInterface.startGame();
}
