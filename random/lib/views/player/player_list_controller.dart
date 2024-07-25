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
  var isGH = false.obs;
  var filterType = 0.obs;
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
    if (filterType.value == 0 && isGH.value == false) {
      players.value = allPlayer;
    } else {
      for (var p in allPlayer) {
        var details = MatchDBLocal.shared.realm.query<MatchDetailDB>(r'pid == $0', [p.id]).toList();
        details = details.where((element) => element.isGH == (isGH.value ? 1 : 0)).toList();
        details = filterType.value == 1
            ? details.where((element) => DateTime.parse(element.date).year == DateTime.now().year).toList()
            : filterType.value == 2
                ? details.where((element) => DateTime.parse(element.date).year == DateTime.now().year - 1).toList()
                : details;
        p.goal = details.fold(0, (previousValue, element) => previousValue.value + element.goal);
        p.elo = 300 + (details.fold(0, (previousValue, element) => previousValue.value + element.elo));
        p.match = details.length;
        p.win = details.where((element) => element.win == 1).length;
        p.lost = details.where((element) => element.win == -1).length;
        players.value = allPlayer;
      }
    }
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

  void onFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Obx(() => Container(
              child: Wrap(
                children: <Widget>[
                  CheckboxListTile(
                    title: Text('isGH'),
                    value: isGH.value,
                    onChanged: (newValue) {
                      isGH.value = newValue ?? false;
                      reloadData();
                    },
                  ),
                  ListTile(
                    leading: filterType.value == 0 ? Icon(Icons.radio_button_checked_rounded) : Icon(Icons.radio_button_off),
                    title: Text('All'),
                    onTap: () {
                      filterType.value = 0;
                      reloadData();
                      // Add your filtering logic here for "All"
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: filterType.value == 1 ? Icon(Icons.radio_button_checked_rounded) : Icon(Icons.radio_button_off),
                    title: Text('This Year'),
                    onTap: () {
                      filterType.value = 1;
                      reloadData();
                      // Add your filtering logic here for "This Year"
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: filterType.value == 2 ? Icon(Icons.radio_button_checked_rounded) : Icon(Icons.radio_button_off),
                    title: Text('Last Year'),
                    onTap: () {
                      filterType.value = 2;
                      reloadData();
                      // Add your filtering logic here for "Last Year"
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ));
      },
    );
  }
}
