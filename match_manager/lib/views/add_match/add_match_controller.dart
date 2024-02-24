import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:match_manager/commons/num_extension.dart';
import 'package:match_manager/local/match_local.dart';
import 'package:match_manager/models/db/match_db.dart';
import 'package:match_manager/models/db/player_db.dart';

import 'package:match_manager/views/add_match/add_match_state.dart';
import 'package:match_manager/views/ranking/rank_list_controller.dart';
import 'package:match_manager/views/select_player/select_player_view.dart';
import 'package:realm/realm.dart';

class AddMatchController extends GetxController with ShareMixin {
  AddMatchState state;
  final date = DateTime.now().obs;
  final t1 = <MatchDetailDB>[].obs;
  final t2 = <MatchDetailDB>[].obs;
  final goal = 0.obs;
  final goal1 = 0.obs;
  final goal2 = 0.obs;
  final ogoal = 0.obs;
  final assit = 0.obs;
  final isGH = false.obs;
  AddMatchController({
    required this.state,
  });

  @override
  void onInit() {
    super.onInit();
    t1.value = state.t1;
    t2.value = state.t2;
    goal1.value = state.match.goal1;
    goal2.value = state.match.goal2;
    isGH.value = state.match.isGH == 1;
    date.value = state.match.date.asDate ?? DateTime.now();
  }

  void onSave() {
    try {
      var newdetails = t1.value + t2.value;
      if (state.isEdit == false) {
        state.match.details.addAll(newdetails);
        MatchDBLocal.shared.add(state.match);
      } else {
        var addDetails = newdetails.where((element) => state.match.details.every((e) => e.id != element.id)).toList();
        // var deleteDetails = state.match.details.where((element) => newdetails.every((e) => e.id != element.id));

        MatchDBLocal.shared.realm.write(() {
          state.match.date = date.value.toIso8601String();
          state.match.details.addAll(addDetails);
        });
        MatchDBLocal.shared.update(state.match, isGH.value ? 1 : 0);
      }
      Get.back();
    } catch (e) {
      showDialog(context: Get.context!, builder: (c) => AlertDialog(content: Text(e.toString())));
    }
  }

  void changeDate() {
    showDatePicker(context: Get.context!, initialDate: date.value, firstDate: DateTime(2023, 1, 1), lastDate: DateTime.now()).then((value) {
      if (value != null) {
        date.value = value;
      }
    });
  }

  void onAddT1() {
    Get.to(const SelectPlayerView())?.then((value) async {
      if (value is List<PlayerDB>) {
        final newV = await _get(value, 1);
        final oldV = t1.value + t2.value;
        final addDetails = newV.where((element) => oldV.every((e) => e.pid != element.pid)).toList();
        if (state.isEdit) {
          MatchDBLocal.shared.addDetails(addDetails, state.match);
        }
        t1.addAll(addDetails);
      }
    });
  }

  Future<List<MatchDetailDB>> _get(List<PlayerDB> players, int team) async {
    List<MatchDetailDB> values = [];
    for (var p in players) {
      values.add(await state.match.getDetail(p)
        ..team = team);
    }
    return values;
  }

  void onAddT2() {
    Get.to(const SelectPlayerView())?.then((value) async {
      if (value is List<PlayerDB>) {
        final newV = await _get(value, 2);
        final oldV = t1.value + t2.value;
        final addDetails = newV.where((element) => oldV.every((e) => e.pid != element.pid)).toList();
        if (state.isEdit) {
          MatchDBLocal.shared.addDetails(addDetails, state.match);
        }
        t2.addAll(addDetails);
      }
    });
  }

  void onClickDelete() {
    showDialog(
        context: Get.context!,
        builder: (c) => AlertDialog(
              content: Text('Bạn có chắc chắn muốn xóa không'),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Không')),
                TextButton(
                    onPressed: () {
                      Get.back();
                      if (state.isEdit) {
                        MatchDBLocal.shared.delete(state.match);
                      }
                      Get.back();
                    },
                    child: Text('Có'))
              ],
            ));
  }

  void edit(MatchDetailDB e) {
    goal.value = e.goal;
    ogoal.value = e.ogoal;
    assit.value = e.assit.value;
    showDialog(
        context: Get.context!,
        builder: (c) => AlertDialog(
              title: Text('Nhập điểm'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 500,
                  ),
                  Obx(() => _ViewItem(
                      value: goal.value,
                      title: 'Bàn thắng',
                      onPressed1: () {
                        if (goal.value > 0) {
                          goal.value -= 1;
                        }
                      },
                      onPressed2: () {
                        goal.value += 1;
                      })),
                  Obx(() => _ViewItem(
                        value: assit.value,
                        title: 'Kiến tạo',
                        onPressed1: () {
                          if (assit.value > 0) {
                            assit.value -= 1;
                          }
                        },
                        onPressed2: () {
                          assit.value += 1;
                        },
                      )),
                  Obx(() => _ViewItem(
                        value: ogoal.value,
                        title: 'Phản lưới',
                        onPressed1: () {
                          if (ogoal.value > 0) {
                            ogoal.value -= 1;
                          }
                        },
                        onPressed2: () {
                          ogoal.value += 1;
                        },
                      )),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            // PlayerDBLocal.shared.add(PlayerDB(0, name.text.trim(), elo: int.tryParse(elo.text.trim()) ?? 300));
                            // reloadData();
                            _delete(e);
                            Get.back();
                            // Navigator.of(context).pop();
                          },
                          child: Text('Xóa')),
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              // PlayerDBLocal.shared.add(PlayerDB(0, name.text.trim(), elo: int.tryParse(elo.text.trim()) ?? 300));
                              // reloadData();
                              _edit(e);
                              Get.back();
                              // Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Text('Xong'),
                            )),
                      )
                    ],
                  )
                ],
              ),
            ));
  }

  _edit(MatchDetailDB e) {
    if (state.match.details.any((element) => e.id == element.id)) {
      MatchDBLocal.shared.realm.write(() {
        final g = e.goal;
        final og = e.ogoal;
        final as = e.assit.value;
        e.goal = goal.value;
        e.ogoal = ogoal.value;
        e.assit = assit.value;
        final p = MatchDBLocal.shared.realm.find<PlayerDB>(e.pid);
        p?.goal = (p.goal ?? 0) - g + e.goal;
        p?.ogoal = (p.ogoal ?? 0) - og + e.ogoal;
        p?.assit = (p.assit ?? 0) - as + e.assit.value;
      });
      MatchDBLocal.shared.update(state.match, isGH.value ? 1 : 0);
      goal1.value = t1.fold<int>(0, (previousValue, element) => previousValue + element.goal) + t2.fold(0, (previousValue, element) => previousValue + element.ogoal);
      goal2.value = t2.fold<int>(0, (previousValue, element) => previousValue + element.goal) + t1.fold(0, (previousValue, element) => previousValue + element.ogoal);
    } else {
      e.goal = goal.value;
      e.ogoal = ogoal.value;
      e.assit = assit.value;
      goal1.value = t1.fold<int>(0, (previousValue, element) => previousValue + element.goal) + t2.fold(0, (previousValue, element) => previousValue + element.ogoal);
      goal2.value = t2.fold<int>(0, (previousValue, element) => previousValue + element.goal) + t1.fold(0, (previousValue, element) => previousValue + element.ogoal);
    }
  }

  _delete(MatchDetailDB d) {
    if (state.match.details.any((element) => d.id == element.id)) {
      if (d.team == 1) {
        t1.remove(d);
      } else {
        t2.remove(d);
      }
      goal1.value = t1.fold<int>(0, (previousValue, element) => previousValue + element.goal) + t2.fold(0, (previousValue, element) => previousValue + element.ogoal);
      goal2.value = t2.fold<int>(0, (previousValue, element) => previousValue + element.goal) + t1.fold(0, (previousValue, element) => previousValue + element.ogoal);

      // state.match.details.remove(e);
      MatchDBLocal.shared.deleteDetail(d, state.match);
      MatchDBLocal.shared.update(state.match, isGH.value ? 1 : 0);
    } else {
      if (d.team == 1) {
        t1.remove(d);
      } else {
        t2.remove(d);
      }
    }
  }

  void onChanged(bool value) {
    isGH.value = value;
  }
}

class _ViewItem extends StatelessWidget {
  final String title;
  final int value;
  final VoidCallback? onPressed1;
  final VoidCallback? onPressed2;
  const _ViewItem({Key? key, required this.value, required this.title, this.onPressed1, this.onPressed2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(child: Text(title)),
          IconButton(onPressed: onPressed1, icon: Icon(Icons.remove_circle_outline_rounded)),
          Text('$value'),
          IconButton(onPressed: onPressed2, icon: Icon(Icons.add_circle_outline_rounded)),
        ],
      ),
    );
  }
}
