import '../../../presentation/player_turn_enum.dart';
import 'piece.dart';

class SmallPiece extends Piece {
  SmallPiece({
    required this.owningPlayer,
  });

  @override
  final PlayerEnum owningPlayer;

  @override
  String stringRepresentation() {
    return owningPlayer == PlayerEnum.blue ? "_b_" : "_o_";
  }

  @override
  bool setOn(Piece? piece) {
    if(piece == null) {
      return true;
    }
    return false;
  }

  @override
  Piece? pieceBeneath() {
    return null;
  }

  @override
  Piece copy() {
    return SmallPiece(owningPlayer: owningPlayer);
  }
}
