import 'dart:convert';

import 'package:random/commons/num_extension.dart';
import 'package:random/models/db/player_db.dart';
import 'package:realm/realm.dart';

class PlayerDBLocal {
  late Realm realm;
  static PlayerDBLocal shared = PlayerDBLocal._init();

  static PlayerDBLocal _init() {
    final config = Configuration.local([PlayerDB.schema]);
    return PlayerDBLocal()..realm = Realm(config);
  }

  test() {
    deleteAll();
    add(PlayerDB(0, 'H'));
    add(PlayerDB(0, 'H2'));
    final a = alls;
    final b = jsonEncode(a.first);
    final c = b;
  }

  add(PlayerDB e) {
    // ignore: sdk_version_since
    e.id = (realm.all<PlayerDB>().lastOrNull?.id ?? 0) + 1;
    realm.write(() {
      realm.add(e);
    });
  }

  addAll(List<PlayerDB> l) {
    realm.write(() {
      realm.addAll(l);
    });
  }

  deleteAll() {
    realm.write(() {
      realm.deleteAll<PlayerDB>();
    });
  }

  delete(PlayerDB p) {
    realm.write(() {
      realm.delete(p);
    });
  }

  List<PlayerDB> get alls {
    final allPlayer = realm.all<PlayerDB>().toList();
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
    return allPlayer;
  }

  int get id => DateTime.now().microsecondsSinceEpoch;
}
