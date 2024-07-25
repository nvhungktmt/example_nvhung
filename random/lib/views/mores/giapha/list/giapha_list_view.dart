import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:match_manager/views/mores/giapha/list/item_giapha_list_view.dart';

import 'package:match_manager/views/random/random_controller.dart';

class GiaphaListView extends StatelessWidget {
  const GiaphaListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RandomController>(
      init: RandomController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Gia phả'),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(AddG)
                  },
                  icon: Icon(Icons.add_circle))
            ],
          ),
          body: Obx(() => ListView.separated(
              shrinkWrap: true,
              itemBuilder: (c, i) {
                final items = controller.players[i];
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ItemGiaphaListView(),
                );
              },
              separatorBuilder: (c, i) => Container(color: Colors.grey, height: 1),
              itemCount: controller.players.value.length)),
        );
      },
    );
  }
}
