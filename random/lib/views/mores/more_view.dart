import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:match_manager/firebase/firebase_api_connect.dart';
import 'package:match_manager/views/mores/syncs/sync_view.dart';

class MoreView extends StatefulWidget {
  const MoreView({Key? key}) : super(key: key);

  @override
  State<MoreView> createState() => _MoreViewState();
}

class _MoreViewState extends State<MoreView> {
  bool _isConnect = false;
  String _text = '';
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
        Text(_text),
        TextButton(
            onPressed: () async {
              Get.to(const SyncView());
            },
            child: Text('Đồng bộ')),
        
      ],
    );
  }

 
}
