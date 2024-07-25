// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:match_manager/commons/app_card.dart';
import 'package:match_manager/commons/app_color.dart';

import 'package:match_manager/commons/app_styles.dart';
import 'package:match_manager/models/db/match_db.dart';
import 'package:match_manager/views/mores/giapha/add/add_giapha_controller.dart';
import 'package:match_manager/views/mores/giapha/add/add_giapha_state.dart';

class AddGiaphaView extends StatelessWidget {
  final AddGiaphaState state;
  const AddGiaphaView({
    Key? key,
    required this.state,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddGiaphaController>(
      init: AddGiaphaController(state: state),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: const Text('Thêm người mới'),
            actions: [
              IconButton(
                  onPressed: () {
                    controller.onSave();
                  },
                  icon: const Icon(Icons.done))
            ],
          ),
          body: ListView(
            children: [
              RepaintBoundary(
                key: controller.globalKey,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(10),
                  children: [
                    AppCard(
                      onTap: () {
                        controller.changeDate();
                      },
                      child: Row(
                        children: [
                          const Expanded(child: Text('Ngày sinh')),
                          Obx(() => Text(DateFormat('dd/MM/yyyy').format(controller.date.value))),
                        ],
                      ),
                    ),
                    Obx(() => AppCard(
                            child: TextFormField(
                          controller: controller.nameContr,
                        ))),
                    Container(height: 30),
                    Obx(() => Switch(value: controller.isGH.value, onChanged: controller.onChanged)),
                    TextButton(
                        onPressed: () {
                          controller.onClickDelete();
                        },
                        child: Text('Xóa'))
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
