import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/commons/app_card.dart';
import 'package:random/commons/app_color.dart';
import 'package:random/commons/app_styles.dart';
import 'package:random/commons/num_extension.dart';
import 'package:random/views/player/details/player_detail_view.dart';
import 'package:random/views/ranking/rank_list_controller.dart';

class RankListView extends StatelessWidget {
  const RankListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RankListController>(
      init: RankListController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('Xếp hạng theo'),
            actions: [
              TextButton(
                  onPressed: () {
                    controller.changeSort();
                  },
                  child: Obx(() => Text(controller.sortBy.value.value))),
              IconButton(
                  onPressed: () {
                    controller.share();
                  },
                  icon: const Icon(Icons.share_rounded))
            ],
          ),
          body: Obx(() => ListView(
                children: [
                  RepaintBoundary(
                    key: controller.globalKey,
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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
                        itemCount: controller.players.value.length),
                  ),
                ],
              )),
        );
      },
    );
  }
}
