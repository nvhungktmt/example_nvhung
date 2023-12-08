import 'package:flutter/material.dart';
import 'package:random/firebase/firebase_api_connect.dart';

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
              _text = 'Đang đồng bộ';
              setState(() {});
              await FirebaseAPI.connect;

              final suc = await FirebaseAPI.writeNewPost();
              _text = suc ? 'Đồng bộ thành công' : 'Đồng bộ thất bại';
              setState(() {});
            },
            child: Text('Đồng bộ dữ liệu')),
        TextButton(
            onPressed: () async {
              FirebaseAPI.getData();
            },
            child: Text('Lấy dữ liệu mới nhất')),
      ],
    );
  }
}
