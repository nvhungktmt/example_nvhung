import 'dart:convert';

import 'package:random/models/db/match_db.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Match {
  int id;
  String date;
  int goal1;
  int goal2;
  List<MatchDetail> details = [];
  Match({
    required this.id,
    required this.date,
    required this.goal1,
    required this.goal2,
    required this.details,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'goal1': goal1,
      'goal2': goal2,
      'details': details.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory Match.fromJson(String source) => Match.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Match.fromDb(MatchDB p) {
    return Match(id: p.id, date: p.date, goal1: p.goal1, goal2: p.goal2, details: p.details.map((e) => MatchDetail.fromDb(e)).toList());
  }
  MatchDB toDB() {
    return MatchDB(id, date, goal1, goal2, details: details.map((e) => e.toDB()));
  }

  factory Match.fromMap(Map<String, dynamic> map) {
    return Match(
      id: map['id'] as int,
      date: map['date'] as String,
      goal1: map['goal1'] as int,
      goal2: map['goal2'] as int,
      details: List<MatchDetail>.from(
        (map['details'] as List<dynamic>).map<MatchDetail>(
          (x) => MatchDetail.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class MatchDetail {
  int id;
  int mid;
  int pid;
  String pName;
  int goal;
  int ogoal;
  int? assit = 0;
  int elo;
  int team; //1,2
  int? win; //1,0,-1
  String date;
  MatchDetail({
    required this.id,
    required this.mid,
    required this.pid,
    required this.pName,
    required this.goal,
    required this.ogoal,
    this.assit,
    required this.elo,
    required this.team,
    this.win,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'mid': mid,
      'pid': pid,
      'pName': pName,
      'goal': goal,
      'ogoal': ogoal,
      'assit': assit,
      'elo': elo,
      'team': team,
      'win': win,
      'date': date,
    };
  }

  factory MatchDetail.fromMap(Map<String, dynamic> map) {
    return MatchDetail(
      id: map['id'] as int,
      mid: map['mid'] as int,
      pid: map['pid'] as int,
      pName: map['pName'] as String,
      goal: map['goal'] as int,
      ogoal: map['ogoal'] as int,
      assit: map['assit'] != null ? map['assit'] as int : null,
      elo: map['elo'] as int,
      team: map['team'] as int,
      win: map['win'] != null ? map['win'] as int : null,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MatchDetail.fromJson(String source) => MatchDetail.fromMap(json.decode(source) as Map<String, dynamic>);
  factory MatchDetail.fromDb(MatchDetailDB p) {
    return MatchDetail(id: p.id, mid: p.mid, pid: p.pid, pName: p.pName, goal: p.goal, ogoal: p.ogoal, elo: p.elo, team: p.team, date: p.date, assit: p.assit, win: p.win);
  }
  MatchDetailDB toDB() {
    return MatchDetailDB(id, mid, pid, pName, goal, ogoal, elo, team, date, assit: assit, win: win);
  }
}
