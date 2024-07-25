import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:match_manager/firebase/firebase_api_connect.dart';

class SyncView extends StatefulWidget {
  const SyncView({Key? key}) : super(key: key);

  @override
  State<SyncView> createState() => _SyncViewState();
}

class _SyncViewState extends State<SyncView> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Đồng bộ'),
        actions: [
          IconButton(
              onPressed: () {
                // controller.onAdd(context);
              },
              icon: Icon(Icons.add_circle))
        ],
      ),
      body: ListView(
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
                _showAlert(context);
              },
              child: Text('Lấy dữ liệu mới nhất')),
        ],
      ),
    );
  }

  _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Dữ liệu cũ trên máy sẽ mất. Bạn có chắc chắn không?'),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Không')),
          TextButton(
              onPressed: () {
                FirebaseAPI.getData();
                Get.back();
              },
              child: Text('Có'))
        ],
      ),
    );
    FirebaseAPI.getData();
  }
}
