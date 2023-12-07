import 'package:random/commons/num_extension.dart';
import 'package:random/models/db/match_db.dart';
import 'package:random/models/db/player_db.dart';
import 'package:random/models/ui/player.dart';
import 'package:realm/realm.dart';

class MatchDBLocal {
  late Realm realm;
  // late Realm realmPlayer;
  static MatchDBLocal shared = MatchDBLocal._init();

  static MatchDBLocal _init() {
    final config = Configuration.local([MatchDB.schema, MatchDetailDB.schema, PlayerDB.schema]);
    return MatchDBLocal()..realm = Realm(config);
  }

  test() {
    // // deleteAll();
    // add(MatchDB(0, 'H2',
    //     t1: [MatchDetailDB(0, 2, 'date')], t2: [MatchDetailDB(0, 2, 'date')]));
    // final a = alls;
    // final b = jsonEncode(a.first);
    // final c = b;
  }
  MatchDB createMatch({List<PlayerDB>? players}) {
    final m = MatchDB(id, DateTime.now().toIso8601String(), 0, 0);
    return m;
  }

  addPlayer(MatchDB match, PlayerDB p) async {
    match.t1.add(await match.getDetail(p));
  }

  addPlayers(MatchDB match, List<PlayerDB> players) {
    for (var p in players) {
      addPlayer(match, p);
    }
  }

  int get id => DateTime.now().microsecondsSinceEpoch;

  addAll(List<MatchDB> list) {
    for (var l in list) {
      add(l);
    }
  }

  deleteAll() {
    realm.write(() {
      realm.deleteAll<MatchDB>();
    });
  }

  add(MatchDB m) {
    realm.write(() {
      final t1 = m.details.where((e) => e.team == 1);
      final t2 = m.details.where((e) => e.team == 2);
      m.goal1 = t1.fold<int>(0, (previousValue, element) => previousValue + element.goal) + t2.fold<int>(0, (previousValue, element) => previousValue + element.ogoal);
      m.goal2 = t2.fold<int>(0, (previousValue, element) => previousValue + element.goal) + t1.fold<int>(0, (previousValue, element) => previousValue + element.ogoal);
      realm.add(m);
    });
    realm.write(() {
      for (var d in m.details) {
        final p = realm.find<PlayerDB>(d.pid);
        d.win = getWin(m, d);
        d.elo = getElo(m, d);
        p?.goal = (p.goal ?? 0) + d.goal;
        p?.ogoal = (p.ogoal ?? 0) + d.ogoal;
        p?.assit = (p.assit ?? 0) + d.assit.value;
        p?.win = (p.win ?? 0) + (d.win == 1 ? 1 : 0);
        p?.lost = (p.lost ?? 0) + (d.win == -1 ? 1 : 0);
        p?.elo = (p.elo ?? 0) + d.elo;
        p?.match = p.match.value + 1;
      }
    });
  }

//Update MatchDB, Player khi thay doi MatchDetailDB
  update(MatchDB m) {
    realm.write(() {
      final t1 = m.details.where((e) => e.team == 1);
      final t2 = m.details.where((e) => e.team == 2);
      m.goal1 = t1.fold<int>(0, (previousValue, element) => previousValue + element.goal) + t2.fold<int>(0, (previousValue, element) => previousValue + element.ogoal);
      m.goal2 = t2.fold<int>(0, (previousValue, element) => previousValue + element.goal) + t1.fold<int>(0, (previousValue, element) => previousValue + element.ogoal);

      for (var d in m.details) {
        final win = d.win.value;
        final elo = d.elo;
        final goal = d.goal;
        final ogoal = d.ogoal;
        final assit = d.assit.value;

        d.win = getWin(m, d);
        d.elo = getElo(m, d);
        final p = realm.find<PlayerDB>(d.pid);
        p?.goal = (p.goal ?? 0) - goal + d.goal;
        p?.ogoal = (p.ogoal ?? 0) - ogoal + d.ogoal;
        p?.assit = (p.assit ?? 0) - assit + d.assit.value;
        p?.win = (p.win ?? 0) - (win == 1 ? 1 : 0) + (d.win == 1 ? 1 : 0);
        p?.lost = (p.lost ?? 0) - (win == -1 ? 1 : 0) + (d.win == -1 ? 1 : 0);
        p?.elo = (p.elo ?? 0) - elo + d.elo;
      }
    });
  }

  delete(MatchDB m) {
    final d = realm.all<MatchDetailDB>();
    final details = realm.query<MatchDetailDB>(r'mid == $0', [m.id]).toList();
    realm.write(() {
      for (var d in details) {
        final p = realm.find<PlayerDB>(d.pid);
        p?.goal = (p.goal ?? 0) - d.goal;
        p?.ogoal = (p.ogoal ?? 0) - d.ogoal;
        p?.assit = (p.assit ?? 0) - d.assit.value;
        p?.win = (p.win ?? 0) - (getWin(m, d) == 1 ? 1 : 0);
        p?.lost = (p.lost ?? 0) - (getWin(m, d) == -1 ? 1 : 0);
        p?.elo = (p.elo ?? 0) - getElo(m, d);
        p?.match = p.match.value - 1;
      }
    });
    realm.write(() {
      realm.deleteMany(details);
      realm.delete(m);
    });
  }

  int getElo(MatchDB m, MatchDetailDB d) {
    return getWin(m, d) * 20 + d.goal ~/ 2;
  }

  int getWin(MatchDB m, MatchDetailDB d) {
    if (m.goal1 == m.goal2) {
      return 0;
    } else if (m.goal1 > m.goal2) {
      return d.team == 1 ? 1 : -1;
    } else {
      return d.team == 2 ? 1 : -1;
    }
  }

  List<MatchDB> get alls => realm.all<MatchDB>().toList();

  void deleteDetail(MatchDetailDB d, MatchDB m) {
    MatchDBLocal.shared.realm.write(() {
      final p = realm.find<PlayerDB>(d.pid);
      p?.goal = (p.goal ?? 0) - d.goal;
      p?.ogoal = (p.ogoal ?? 0) - d.ogoal;
      p?.assit = (p.assit ?? 0) - d.assit.value;
      p?.win = (p.win ?? 0) - (getWin(m, d) == 1 ? 1 : 0);
      p?.lost = (p.lost ?? 0) - (getWin(m, d) == -1 ? 1 : 0);
      p?.elo = (p.elo ?? 0) - getElo(m, d);
      p?.match = p.match.value - 1;
      MatchDBLocal.shared.realm.delete(d);
    });
  }

  void addDetail(MatchDetailDB d, MatchDB m) {
    MatchDBLocal.shared.realm.write(() {
      d.win = getWin(m, d);
      d.elo = getElo(m, d);
      final p = realm.find<PlayerDB>(d.pid);
      p?.goal = (p.goal ?? 0) + d.goal;
      p?.ogoal = (p.ogoal ?? 0) + d.ogoal;
      p?.assit = (p.assit ?? 0) + d.assit.value;
      p?.win = (p.win ?? 0) + (getWin(m, d) == 1 ? 1 : 0);
      p?.lost = (p.lost ?? 0) + (getWin(m, d) == -1 ? 1 : 0);
      p?.elo = (p.elo ?? 0) + getElo(m, d);
      p?.match = p.match.value + 1;
      m.details.add(d);
    });
  }

  void addDetails(List<MatchDetailDB> details, MatchDB m) {
    MatchDBLocal.shared.realm.write(() {
      for (var d in details) {
        d.win = getWin(m, d);
        d.elo = getElo(m, d);
        final p = realm.find<PlayerDB>(d.pid);
        p?.goal = (p.goal ?? 0) + d.goal;
        p?.ogoal = (p.ogoal ?? 0) + d.ogoal;
        p?.assit = (p.assit ?? 0) + d.assit.value;
        p?.win = (p.win ?? 0) + (getWin(m, d) == 1 ? 1 : 0);
        p?.lost = (p.lost ?? 0) + (getWin(m, d) == -1 ? 1 : 0);
        p?.elo = (p.elo ?? 0) + getElo(m, d);
        p?.match = p.match.value + 1;
        m.details.add(d);
      }
    });
  }
}
