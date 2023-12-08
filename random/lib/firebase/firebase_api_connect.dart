import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
    final DataSnapshot snapshot = await ref.child('my_database/users').get();
    // if (snapshot.exists) {
    // print(snapshot.value);
    // } else {
    // print('No data available.');
    // }
    final d = (snapshot.value as Map<dynamic, dynamic>)['author'] as String;
    print(d.substring(d.length - 1, d.length));
    print(d.length);
    return;

    // GenericTypeIndicator<List<Message>> t = new GenericTypeIndicator<List<Message>>() {};
    //  List<Message> messages = snapshot.getValue(t);
  }

  static void writeNewPost(String username) async {
    // A post entry.
    final postData = {'author': username};

    // Get a key for a new Post.
    final newPostKey = FirebaseDatabase.instance.ref().child('my_database').push().key;

    // Write the new post's data simultaneously in the posts list and the`
    // user's post list.
    final Map<String, Map> updates = {};
    updates['/my_database/users'] = postData;
    // updates['/user-my_database/$uid/$newPostKey'] = postData;

    return FirebaseDatabase.instance.ref().update(updates);
  }
}
