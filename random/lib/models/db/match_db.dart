import 'package:random/local/match_local.dart';
import 'package:random/models/db/player_db.dart';
import 'package:random/models/ui/player.dart';
import 'package:realm/realm.dart';

part 'match_db.g.dart';

@RealmModel()
class _MatchDB {
  @PrimaryKey()
  late int id;
  late String date;
  late int goal1;
  late int goal2;
  List<_MatchDetailDB> details = [];
}

@RealmModel()
class _MatchDetailDB {
  @PrimaryKey()
  late int id;
  late int mid;
  late int pid;
  late String pName;
  late int goal;
  late int ogoal;
  int? assit = 0;
  late int elo;
  late int team; //1,2
  int? win; //1,0,-1
  late String date;
}

extension MatchDBExt on MatchDB {
  List<_MatchDetailDB> get t1 => details.where((element) => element.team == 1).toList();
  List<_MatchDetailDB> get t2 => details.where((element) => element.team == 2).toList();
  Future<MatchDetailDB> getDetail(PlayerDB p) async {
    await Future.delayed(const Duration(microseconds: 1));
    return MatchDetailDB(MatchDBLocal.shared.id, id, p.id, p.name, 0, 0, 0, 0, date);
  }

  String getDisplay1() {
    final goals = t1.where((element) => element.goal > 0).map((e) => '${e.pName} (${e.goal})').toList();
    final ogoals = t1.where((element) => element.ogoal > 0).map((e) => '${e.pName} (${e.ogoal} OG)').toList();
    return (goals + ogoals).join('\n');
  }

  String getDisplay2() {
    final goals = t2.where((element) => element.goal > 0).map((e) => '${e.pName} (${e.goal})').toList();
    final ogoals = t2.where((element) => element.ogoal > 0).map((e) => '${e.pName} (${e.ogoal} OG)').toList();
    return (goals + ogoals).join('\n');
  }
}
