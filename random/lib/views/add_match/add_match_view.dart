// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:random/commons/app_card.dart';
import 'package:random/commons/app_color.dart';

import 'package:random/commons/app_styles.dart';
import 'package:random/models/db/match_db.dart';
import 'package:random/views/add_match/add_match_controller.dart';
import 'package:random/views/add_match/add_match_state.dart';

class AddMatchView extends StatelessWidget {
  final AddMatchState state;
  const AddMatchView({
    Key? key,
    required this.state,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddMatchController>(
      init: AddMatchController(state: state),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: const Text('Trận đấu'),
            actions: [
              IconButton(
                  onPressed: () {
                    controller.onSave();
                  },
                  icon: const Icon(Icons.done))
            ],
          ),
          body: ListView(
            padding: EdgeInsets.all(10),
            children: [
              AppCard(
                onTap: () {
                  controller.changeDate();
                },
                child: Row(
                  children: [
                    const Expanded(child: Text('Ngày')),
                    Obx(() => Text(DateFormat('dd/MM/yyyy').format(controller.date.value))),
                  ],
                ),
              ),
              Obx(() => AppCard(
                    child: _TeamView(
                      team: controller.t1.value,
                      onAddPressed: () {
                        controller.onAddT1();
                      },
                      onPressed: (e) {
                        controller.edit(e);
                      },
                      title: 'Đội 1 - Bàn thắng:  ${controller.goal1.value}',
                    ),
                  )),
              Obx(() => AppCard(
                    child: _TeamView(
                      team: controller.t2.value,
                      onAddPressed: () {
                        controller.onAddT2();
                      },
                      onPressed: (e) {
                        controller.edit(e);
                      },
                      title: 'Đội 2 - Bàn thắng:  ${controller.goal2.value}',
                    ),
                  )),
              Container(height: 30),
              TextButton(
                  onPressed: () {
                    controller.onClickDelete();
                  },
                  child: Text('Xóa'))
            ],
          ),
        );
      },
    );
  }
}

class _TeamView extends StatelessWidget {
  final VoidCallback? onAddPressed;
  final void Function(MatchDetailDB)? onPressed;
  final List<MatchDetailDB> team;
  final String title;
  const _TeamView({
    Key? key,
    this.onPressed,
    required this.team,
    this.onAddPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [Expanded(child: Text(title)), IconButton(onPressed: onAddPressed, icon: const Icon(Icons.add_circle_outline))],
          ),
        ),
        Wrap(
            children: team.map((e) {
          return _ItemView(
            e: e,
            onPressed: onPressed,
          );
        }).toList())
      ],
    );
  }
}

class _ItemView extends StatelessWidget {
  final MatchDetailDB e;
  final void Function(MatchDetailDB)? onPressed;
  const _ItemView({
    Key? key,
    required this.e,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = e.pName;
    if (e.goal > 0) {
      text += ' (${e.goal})';
    }
    if (e.ogoal > 0) {
      text += ' (${e.ogoal} OG)';
    }
    return Container(
      child: TextButton(
          onPressed: () {
            onPressed?.call(e);
          },
          child: Text(text, style: AppStyle.normal.copyWith(color: Colors.black))),
    );
  }
}
