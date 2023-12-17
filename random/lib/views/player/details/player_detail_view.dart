import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:random/commons/app_card.dart';
import 'package:random/commons/app_color.dart';
import 'package:random/commons/app_styles.dart';
import 'package:random/commons/num_extension.dart';
import 'package:random/local/player_local.dart';
import 'package:random/models/db/match_db.dart';
import 'package:random/models/db/player_db.dart';
import 'package:random/views/player/details/player_detail_controller.dart';

class PlayerDetailView extends StatelessWidget {
  const PlayerDetailView({Key? key, required this.player}) : super(key: key);
  final PlayerDB player;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayerDetailController>(
      init: PlayerDetailController(player),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('Thành viên'),
            actions: [],
          ),
          body: Obx(() => ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 15),
              itemBuilder: (c, i) {
                final item = controller.matchs[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: AppCard(
                    onTap: () {},
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
              itemCount: controller.matchs.value.length)),
        );
      },
    );
  }
}
