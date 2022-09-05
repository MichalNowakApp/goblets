import '../../../presentation/player_turn_enum.dart';
import 'piece.dart';
import 'small_piece.dart';

class MediumPiece extends Piece {
  MediumPiece({
    required this.owningPlayer,
    pieceBeneath
  }): _pieceBeneath = pieceBeneath;

  @override
  final PlayerEnum owningPlayer;
  Piece? _pieceBeneath;

  @override
  String stringRepresentation() {
    return owningPlayer == PlayerEnum.blue ? "_bb" : "_oo";
  }

  @override
  bool setOn(Piece? piece) {
    if(piece == null) {
      return true;
    }
    else if(piece is SmallPiece) {
      _pieceBeneath = piece.copy();
      return true;
    }
    return false;
  }

  @override
  Piece? pieceBeneath() {
    return _pieceBeneath;
  }

  @override
  Piece copy() {
    return MediumPiece(owningPlayer: owningPlayer, pieceBeneath: pieceBeneath());
  }
}
