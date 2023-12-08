import 'package:flutter/material.dart';
import 'package:random/firebase/firebase_api_connect.dart';

class MoreView extends StatefulWidget {
  const MoreView({Key? key}) : super(key: key);

  @override
  State<MoreView> createState() => _MoreViewState();
}

class _MoreViewState extends State<MoreView> {
  bool _isConnect = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAPI.connect.then((value) {
      _isConnect = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextButton(
            onPressed: () async {
              await FirebaseAPI.connect;
              var text = 'A';
              for (var i = 0; i < 100000; i++) {
                text += '$i';
              }
              text += 'Z';
              FirebaseAPI.writeNewPost(text);
            },
            child: Text('Save')),
        TextButton(
            onPressed: () async {
              FirebaseAPI.getData();
            },
            child: Text('Get')),
      ],
    );
  }
}
