import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:match_manager/commons/app_card.dart';
import 'package:match_manager/commons/app_color.dart';
import 'package:match_manager/commons/app_styles.dart';
import 'package:match_manager/commons/num_extension.dart';
import 'package:match_manager/local/player_local.dart';
import 'package:match_manager/models/db/match_db.dart';
import 'package:match_manager/models/db/player_db.dart';
import 'package:match_manager/views/match_list/match_list_controller.dart';
import 'package:match_manager/views/player/player_list_controller.dart';

class MatchListView extends StatelessWidget {
  const MatchListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchListController>(
      init: MatchListController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Trận đấu'),
            // elevation: 1,
            actions: [
              IconButton(
                  onPressed: () {
                    controller.onAdd(context);
                  },
                  icon: Icon(Icons.add_circle))
            ],
          ),
          body: Obx(() => ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 15),
              itemBuilder: (c, i) {
                final item = controller.players[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: AppCard(
                    onTap: () {
                      controller.onEdit(item);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(item.date.dateString ?? '', style: AppStyle.large),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('${item.goal1}', style: AppStyle.huge),
                                  Text(item.getDisplay1(), style: AppStyle.caption),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('${item.goal2}', style: AppStyle.huge),
                                  Text(item.getDisplay2(), style: AppStyle.caption),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (c, i) => Container(height: 1),
              itemCount: controller.players.value.length)),
        );
      },
    );
  }

  Widget moreItem(MatchListController controller, PlayerDB item) {
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
