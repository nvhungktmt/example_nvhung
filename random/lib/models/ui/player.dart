import 'dart:convert';

import 'package:random/models/db/player_db.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Player {
  int id;
  String name;
  int? goal = 0;
  int? ogoal = 0;
  int? match = 0;
  int? win = 0;
  int? lost = 0;
  int? elo = 0;
  bool? isFavourite;
  Player({
    required this.id,
    required this.name,
    this.goal,
    this.ogoal,
    this.match,
    this.win,
    this.lost,
    this.elo,
    this.isFavourite,
  });

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) => Player.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Player.fromDb(PlayerDB p) {
    return Player(id: p.id, name: p.name, goal: p.goal, ogoal: p.ogoal, match: p.match, win: p.win, lost: p.lost, elo: p.elo, isFavourite: p.isFavourite);
  }
  PlayerDB toDB() {
    return PlayerDB(id, name, goal: goal, ogoal: ogoal, match: match, win: win, lost: lost, elo: elo, isFavourite: isFavourite);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'goal': goal,
      'ogoal': ogoal,
      'match': match,
      'win': win,
      'lost': lost,
      'elo': elo,
      'isFavourite': isFavourite,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      id: map['id'] as int,
      name: map['name'] as String,
      goal: map['goal'] != null ? map['goal'] as int : null,
      ogoal: map['ogoal'] != null ? map['ogoal'] as int : null,
      match: map['match'] != null ? map['match'] as int : null,
      win: map['win'] != null ? map['win'] as int : null,
      lost: map['lost'] != null ? map['lost'] as int : null,
      elo: map['elo'] != null ? map['elo'] as int : null,
      isFavourite: map['isFavourite'] != null ? map['isFavourite'] as bool : null,
    );
  }
}
