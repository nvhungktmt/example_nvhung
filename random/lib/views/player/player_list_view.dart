import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:match_manager/commons/app_card.dart';
import 'package:match_manager/commons/app_color.dart';
import 'package:match_manager/commons/app_styles.dart';
import 'package:match_manager/commons/num_extension.dart';
import 'package:match_manager/local/player_local.dart';
import 'package:match_manager/models/db/player_db.dart';
import 'package:match_manager/views/player/details/player_detail_view.dart';
import 'package:match_manager/views/player/player_list_controller.dart';

class PlayerListView extends StatelessWidget {
  const PlayerListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayerListController>(
      init: PlayerListController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('Thành viên'),
            actions: [
              IconButton(
                  onPressed: () {
                    controller.onFilter(context);
                  },
                  icon: const Icon(Icons.filter_alt_rounded))
            ],
          ),
          body: Obx(() => ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 15),
              itemBuilder: (c, i) {
                final item = controller.players[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: AppCard(
                    padding: const EdgeInsets.only(top: 5, bottom: 15, left: 15, right: 15),
                    onTap: () {
                      Get.to(PlayerDetailView(player: item));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            i == 0
                                ? const Image(width: 36, height: 36, image: AssetImage('assets/images/rank1.png'))
                                : i == 1
                                    ? const Image(width: 36, height: 36, image: AssetImage('assets/images/rank2.png'))
                                    : i == 2
                                        ? const Image(width: 36, height: 36, image: AssetImage('assets/images/rank3.png'))
                                        : Container(
                                            height: 24,
                                            width: 24,
                                            child: Center(child: Text('${i + 1}')),
                                            decoration: BoxDecoration(color: i == 0 ? Colors.yellow : AppColors.background, borderRadius: BorderRadius.circular(50)),
                                          ),
                            const SizedBox(width: 8),
                            Expanded(
                                child: Text(
                              item.name,
                              style: AppStyle.large,
                            )),
                            IconButton(
                                onPressed: () {
                                  PlayerDBLocal.shared.realm.write(() {
                                    item.isFavourite = !(item.isFavourite ?? false);
                                  });
                                  controller.reloadData();
                                },
                                icon: Icon(
                                  Icons.favorite_border_rounded,
                                  color: item.isFavourite == true ? Colors.red : Colors.grey,
                                )),
                            if (item.isFavourite == false) moreItem(controller, item),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text('Elo', style: AppStyle.caption), Text('${item.elo}')],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text('Trận', style: AppStyle.caption), Text('${item.match}')],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text('Thắng', style: AppStyle.caption), Text('${item.win}')],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text('Hòa', style: AppStyle.caption), Text('${item.match.value - item.win.value - item.lost.value}')],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text('Thua', style: AppStyle.caption), Text('${item.lost}')],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text('Goal', style: AppStyle.caption), Text('${item.goal}')],
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
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                controller.onAdd(context);
              },
              child: const Icon(Icons.add)),
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
        } else if (i == 0) {
          controller.onEdit(item);
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
