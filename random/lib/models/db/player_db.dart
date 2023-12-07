import 'package:realm/realm.dart';

part 'player_db.g.dart';

@RealmModel()
class _PlayerDB {
  @PrimaryKey()
  late int id;
  late String name;
  int? goal = 0;
  int? ogoal = 0;
  int? match = 0;
  int? win = 0;
  int? lost = 0;
  int? assit = 0;
  int? elo = 0;
  bool? isFavourite;
}

extension PlayerExt on PlayerDB {
  String getRank() {
    return 'Rank ${(elo ?? 0) ~/ 100}';
  }
}
