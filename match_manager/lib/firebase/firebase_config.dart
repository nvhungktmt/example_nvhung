import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
          // appId: '1:448618578101:web:0b650370bb29e29cac3efc',
          // apiKey: 'AIzaSyAgUhHU8wSJgO5MVNy95tMT07NEjzMOfz0',
          // projectId: 'react-native-firebase-testing',
          // messagingSenderId: '448618578101',
          apiKey: "AIzaSyCetgbgDO30--ZffGOYjG0MjqFMmcJc2ak",
          authDomain: "myenglish-b0491.firebaseapp.com",
          databaseURL: "https://myenglish-b0491-default-rtdb.firebaseio.com",
          projectId: "myenglish-b0491",
          storageBucket: "myenglish-b0491.appspot.com",
          messagingSenderId: "544772859470",
          appId: "1:544772859470:web:57ac740940280aadf6451f",
          measurementId: "G-MBR9NXLPZ2");
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:544772859470:ios:8c5bd3d2eff57ef0f6451f',
        apiKey: 'AIzaSyCetgbgDO30--ZffGOYjG0MjqFMmcJc2ak',
        projectId: 'myenglish-b0491',
        messagingSenderId: '544772859470',
        iosBundleId: 'nvhung1.com.myenglish',
      );
    } else {
      // Android
      return const FirebaseOptions(
        // appId: '1:448618578101:android:0446912d5f1476b6ac3efc',
        // apiKey: 'AIzaSyCuu4tbv9CwwTudNOweMNstzZHIDBhgJxA',
        // projectId: 'react-native-firebase-testing',
        // messagingSenderId: '448618578101',
        apiKey: "AIzaSyCetgbgDO30--ZffGOYjG0MjqFMmcJc2ak",
          authDomain: "myenglish-b0491.firebaseapp.com",
          databaseURL: "https://myenglish-b0491-default-rtdb.firebaseio.com",
          projectId: "myenglish-b0491",
          storageBucket: "myenglish-b0491.appspot.com",
          messagingSenderId: "544772859470",
          appId: "1:544772859470:android:7d3dab4fc26cf9b6f6451f",
          measurementId: "G-MBR9NXLPZ2"
      );
    }
  }
}
