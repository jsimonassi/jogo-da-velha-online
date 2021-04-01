import 'User.dart';
import 'Match.dart';

class RecentMatches {
  Match _match;
  User _player1;
  User _player2;

  RecentMatches(this._match, this._player1, this._player2);

  User get player2 => _player2;

  set player2(User value) {
    _player2 = value;
  }

  User get player1 => _player1;

  set player1(User value) {
    _player1 = value;
  }

  Match get match => _match;

  set match(Match value) {
    _match = value;
  }
}

