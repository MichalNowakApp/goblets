import '../../../presentation/player_turn_enum.dart';
import 'piece.dart';

class LargePiece extends Piece {
  LargePiece({
    required this.owningPlayer,
    pieceBeneath
  }): _pieceBeneath = pieceBeneath;

  @override
  final PlayerEnum owningPlayer;
  Piece? _pieceBeneath;

  @override
  String stringRepresentation() {
    return owningPlayer == PlayerEnum.blue ? "bbb" : "ooo";
  }

  @override
  bool setOn(Piece? piece) {
    if(piece is LargePiece) {
      return false;
    } else if (piece == null) {
      return true;
    }
    _pieceBeneath = piece.copy();
    return true;
  }

  @override
  Piece? pieceBeneath() {
    return _pieceBeneath;
  }

  @override
  Piece copy() {
    return LargePiece(owningPlayer: owningPlayer, pieceBeneath: pieceBeneath());
  }
}
