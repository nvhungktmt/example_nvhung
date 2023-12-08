import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:random/local/match_local.dart';
import 'package:random/local/player_local.dart';
import 'package:random/models/ui/match.dart';
import 'package:random/models/ui/player.dart';

import 'firebase_config.dart';

class FirebaseAPI {
  static Future<void> get connect async {
    await Firebase.initializeApp(
      options: DefaultFirebaseConfig.platformOptions,
    );
    return;
  }

  static Future<void> get connect2 async {
    final firebaseApp = Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(app: firebaseApp, databaseURL: 'https://myenglish-b0491-default-rtdb.firebaseio.com/');

    // await Firebase.initializeApp(
    //   options: DefaultFirebaseConfig.platformOptions,
    // );
  }

  static Future getData() async {
    await FirebaseAPI.connect;
    final ref = FirebaseDatabase.instance.ref();
    final DataSnapshot snapshot = await ref.child('my_database/data/0').get();
    // if (snapshot.exists) {
    // print(snapshot.value);
    // } else {
    // print('No data available.');
    // }
    final d = (snapshot.value as Map<dynamic, dynamic>)['players'] as String;
    final d2 = (snapshot.value as Map<dynamic, dynamic>)['matchs'] as String;
    print(d);
    print(d2);
    final players = (jsonDecode(d) as List<dynamic>).map((e) => Player.fromMap(jsonDecode(e)).toDB()).toList();
    final mat = (jsonDecode(d2) as List<dynamic>).map((e) => Match.fromMap(jsonDecode(e)).toDB()).toList();
    if (players.isNotEmpty && mat.isNotEmpty) {
      PlayerDBLocal.shared.deleteAll();
      PlayerDBLocal.shared.addAll(players);
      MatchDBLocal.shared.deleteAll();
      MatchDBLocal.shared.addAll(mat);
    }
    return;

    // GenericTypeIndicator<List<Message>> t = new GenericTypeIndicator<List<Message>>() {};
    //  List<Message> messages = snapshot.getValue(t);
  }

  static Future<bool> writeNewPost() async {
    try {
      final players = PlayerDBLocal.shared.alls.map((e) => Player.fromDb(e)).toList();
      final matchs = MatchDBLocal.shared.alls.map((e) => Match.fromDb(e)).toList();

      final text = '';
      final postData = {'player': jsonEncode(players), 'match': jsonEncode(matchs)};
      final postData2 = {'players': jsonEncode(players), 'matchs': jsonEncode(matchs)};

      // Get a key for a new Post.
      final newPostKey = FirebaseDatabase.instance.ref().child('my_database').push().key;

      // Write the new post's data simultaneously in the posts list and the`
      // user's post list.
      final Map<String, Map> updates = {};
      final Map<String, Map> updates2 = {};
      updates['/my_database/data/${DateTime.now().day}'] = postData;
      updates2['/my_database/data/0'] = postData2;
      // updates['/user-my_database/$uid/$newPostKey'] = postData;

      await FirebaseDatabase.instance.ref().update(updates);
      await FirebaseDatabase.instance.ref().update(updates2);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
}
