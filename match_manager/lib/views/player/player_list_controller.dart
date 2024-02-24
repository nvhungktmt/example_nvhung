import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:match_manager/commons/num_extension.dart';
import 'package:match_manager/local/match_local.dart';
import 'package:match_manager/local/player_local.dart';
import 'package:match_manager/models/db/match_db.dart';
import 'package:match_manager/models/db/player_db.dart';
// import 'package:match_manager/commons/num_extension.dart';

class PlayerListController extends GetxController {
  var players = PlayerDBLocal.shared.alls.obs;

  void onAdd(BuildContext context) {
    final name = TextEditingController();
    final elo = TextEditingController();
    elo.text = '300';
    showDialog(
        context: Get.context!,
        builder: (c) => AlertDialog(
              title: Text('Thêm thành viên'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: name,
                    decoration: InputDecoration(labelText: 'Họ và tên*'),
                  ),
                  TextField(
                    controller: elo,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Điểm Elo*'),
                  ),
                  TextButton(
                      onPressed: () {
                        if (elo.text.trim().isNotEmpty && name.text.trim().isNotEmpty) {
                          PlayerDBLocal.shared.add(PlayerDB(0, name.text.trim(), elo: int.tryParse(elo.text.trim()) ?? 300));
                          reloadData();
                          Get.back();
                          // Navigator.of(context).pop();
                        }
                      },
                      child: Text('Xong'))
                ],
              ),
            ));
  }

  void reloadData() {
    final allPlayer = PlayerDBLocal.shared.alls;

    players.value = allPlayer;
  }

  void onEdit(PlayerDB item) {
    final name = TextEditingController();
    name.text = item.name;
    showDialog(
        context: Get.context!,
        builder: (c) => AlertDialog(
              title: Text('Sửa thành viên'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: name,
                    decoration: InputDecoration(labelText: 'Họ và tên*'),
                  ),
                  TextButton(
                      onPressed: () {
                        if (name.text.trim().isNotEmpty) {
                          MatchDBLocal.shared.editName(name.text.trim(), item);
                          reloadData();
                          Get.back();
                          // Navigator.of(context).pop();
                        }
                      },
                      child: Text('Xong'))
                ],
              ),
            ));
  }
}
