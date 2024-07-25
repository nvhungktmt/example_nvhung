import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:match_manager/commons/app_styles.dart';
import 'package:match_manager/local/player_local.dart';
import 'package:match_manager/models/db/player_db.dart';
import 'package:match_manager/models/ui/player.dart';
import 'package:match_manager/views/player/player_list_controller.dart';
import 'package:match_manager/views/select_player/select_player_controller.dart';

class SelectPlayerView extends StatelessWidget {
  const SelectPlayerView({Key? key, this.selectedPlayers}) : super(key: key);
  final List<PlayerDB>? selectedPlayers;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectPlayerController>(
      init: SelectPlayerController(selected: selectedPlayers),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Chọn cầu thủ'),
            actions: [
              IconButton(
                  onPressed: () {
                    controller.onDone();
                  },
                  icon: Icon(Icons.done))
            ],
          ),
          body: Obx(() => Wrap(
                children: controller.players.value.map((element) {
                  final isSelect = controller.selectplayers.value.contains(element);
                  return Container(
                    child: TextButton(
                        onPressed: () {
                          if (isSelect) {
                            controller.selectplayers.remove(element);
                          } else {
                            controller.selectplayers.add(element);
                          }
                        },
                        child: Text(
                          element.name,
                          style: AppStyle.normal.copyWith(color: isSelect ? Colors.blue : Colors.black),
                        )),
                  );
                }).toList(),
              )),
        );
      },
    );
  }

  Widget moreItem(PlayerListController controller, PlayerDB item) {
    return PopupMenuButton<int>(
      // initialValue: 0,
      // Callback that sets the selected popup menu item.
      onSelected: (int i) {
        if (i == 1) {
          PlayerDBLocal.shared.delete(item);
          controller.reloadData();
        }
        // setState(() {
        //   selectedMenu = item;
        // });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        const PopupMenuItem<int>(
          value: 0,
          child: Text('Sửa'),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Text(
            'Xóa',
            style: AppStyle.normal.copyWith(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
