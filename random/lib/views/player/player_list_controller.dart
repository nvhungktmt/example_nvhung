import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/commons/num_extension.dart';
import 'package:random/local/player_local.dart';
import 'package:random/models/db/player_db.dart';
// import 'package:random/commons/num_extension.dart';

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
}
