import 'package:get/get.dart';
import 'package:match_manager/local/match_local.dart';
import 'package:match_manager/models/db/match_db.dart';
import 'package:match_manager/models/db/player_db.dart';
// import 'package:match_manager/commons/num_extension.dart';

class PlayerDetailController extends GetxController {
  final PlayerDB player;
  var matchs = <MatchDB>[].obs;
  PlayerDetailController(this.player);
  @override
  void onReady() {
    super.onReady();
    Future.delayed(0.1.seconds).then((value) {
      loadData().then((value) => matchs.value = value);
    });
  }

  Future<List<MatchDB>> loadData() async {
    final details = MatchDBLocal.shared.realm.query<MatchDetailDB>(r'pid == $0', [player.id]).toList();
    var matches = <MatchDB>[];
    details.forEach((element) {
      final match = MatchDBLocal.shared.realm.find<MatchDB>(element.mid);

      if (match != null) {
        matches.add(match);
      }
    });
    return matches;
  }
}
