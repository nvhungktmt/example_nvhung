import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/commons/num_extension.dart';
import 'package:random/local/match_local.dart';
import 'package:random/local/player_local.dart';
import 'package:random/models/db/match_db.dart';
import 'package:random/models/db/player_db.dart';
import 'package:random/views/add_match/add_match_state.dart';
import 'package:random/views/add_match/add_match_view.dart';
// import 'package:random/commons/num_extension.dart';

class MatchListController extends GetxController {
  var players = MatchDBLocal.shared.alls.reversed.toList().obs;

  void onAdd(BuildContext context) {
    Get.to(AddMatchView(
      state: AddMatchState(isEdit: false, match: MatchDB(PlayerDBLocal.shared.id, DateTime.now().toIso8601String(), 0, 0)),
    ))?.then((value) {
      reloadData();
    });
  }

  void reloadData() {
    final allPlayer = MatchDBLocal.shared.alls.reversed.toList();

    players.value = allPlayer;
  }

  onEdit(MatchDB item) {
    Get.to(AddMatchView(
      state: AddMatchState(match: item),
    ))?.then((value) {
      reloadData();
    });
  }
}
