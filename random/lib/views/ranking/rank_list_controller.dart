import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/local/player_local.dart';
import 'package:random/models/db/player_db.dart';
import 'package:random/commons/num_extension.dart';
// import 'package:random/commons/num_extension.dart';

class RankListController extends GetxController {
  var players = <PlayerDB>[].obs;
  var sortBy = ERankSort.elo.obs;
  var allPlayer = <PlayerDB>[];
  @override
  void onReady() {
    super.onReady();
    reloadData();
  }

  void reloadData() {
    allPlayer = PlayerDBLocal.shared.realm.all<PlayerDB>().toList();
    switch (sortBy.value) {
      case ERankSort.elo:
        allPlayer.sort((p1, p2) {
          if (p1.isFavourite == p2.isFavourite) {
            if (p1.elo == p2.elo) {
              return p1.goal.value >= p2.goal.value ? 0 : 1;
            }
            return p1.elo.value >= p2.elo.value ? 0 : 1;
          }
          return p1.isFavourite == true
              ? 0
              : p2.isFavourite == true
                  ? 1
                  : 0;
        });
        break;
      case ERankSort.match:
        allPlayer.sort((p1, p2) {
          if (p1.isFavourite == p2.isFavourite) {
            if (p1.match == p2.match) {
              if (p1.elo == p2.elo) {
                return p1.goal.value >= p2.goal.value ? 0 : 1;
              }
              return p1.elo.value >= p2.elo.value ? 0 : 1;
            }
            return p1.match.value >= p2.match.value ? 0 : 1;
          }
          return p1.isFavourite == true
              ? 0
              : p2.isFavourite == true
                  ? 1
                  : 0;
        });
        break;
      case ERankSort.goal:
        allPlayer.sort((p1, p2) {
          if (p1.isFavourite == p2.isFavourite) {
            if (p1.goal == p2.goal) {
              if (p1.elo == p2.elo) {
                return p1.match.value >= p2.match.value ? 0 : 1;
              }
              return p1.elo.value >= p2.elo.value ? 0 : 1;
            }
            return p1.goal.value >= p2.goal.value ? 0 : 1;
          }
          return p1.isFavourite == true
              ? 0
              : p2.isFavourite == true
                  ? 1
                  : 0;
        });
        break;
    }
    players.value = allPlayer;
  }

  void changeSort() {
    if (sortBy.value == ERankSort.elo) {
      sortBy.value = ERankSort.match;
    } else if (sortBy.value == ERankSort.match) {
      sortBy.value = ERankSort.goal;
    } else {
      sortBy.value = ERankSort.elo;
    }

    reloadData();
  }
}

enum ERankSort {
  elo("Elo"),
  match("Số trận"),
  goal("Số bàn thắng");

  const ERankSort(this.value);
  final String value;
}
