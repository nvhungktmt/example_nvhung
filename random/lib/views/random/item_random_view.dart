import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:match_manager/commons/app_styles.dart';
import 'package:match_manager/models/db/player_db.dart';
import 'package:match_manager/views/select_player/select_player_view.dart';

class ItemRandomView extends StatefulWidget {
  final int? max;
  final String? text;
  const ItemRandomView({this.max, this.text});

  @override
  State<ItemRandomView> createState() => _ItemRandomViewState();
}

class _ItemRandomViewState extends State<ItemRandomView> {
  List<_Entity> nums = [];
  int _max = 6;
  List<_Entity> _players = [];
  List<_Entity> _selectplayers = [];
  _Entity? _player;
  List<PlayerDB>? _playerDBs;
  @override
  void initState() {
    super.initState();
    _max = widget.max ?? 6;
    nums = _genNums(_max);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.text ?? ''),
              IconButton(
                  onPressed: () {
                    if (_max <= 0) {
                      return;
                    }
                    _max--;
                    nums = _genNums(_max);
                    setState(() {});
                  },
                  icon: Icon(Icons.remove_circle)),
              Text('$_max'),
              IconButton(
                  onPressed: () {
                    _max++;
                    nums = _genNums(_max);
                    setState(() {});
                  },
                  icon: Icon(Icons.add_circle)),
              TextButton(
                  onPressed: () {
                    Get.to(SelectPlayerView(selectedPlayers: _playerDBs))?.then((value) {
                      if (value is List<PlayerDB>) {
                        _playerDBs = value;
                        _players = value.map((e) => _Entity(value: 0, data: e)).toList();
                        _player = _players.firstOrNull;
                        _max = _players.length;
                        nums = _genNums(_max);
                      }
                      setState(() {});
                    });
                  },
                  child: Text('Chọn anh hùng'))
            ],
          ),
        ),
        Wrap(
          children: _players.map((element) {
            final isSelect = _player == element;
            final _isSelected = _selectplayers.contains(element);
            final e = element.data as PlayerDB;
            return Container(
              child: TextButton(
                  onPressed: () {
                    if (_isSelected) {
                      // _player = element;
                      // controller.selectplayers.remove(element);
                    } else {
                      _player = element;
                      // controller.selectplayers.add(element);
                    }
                    setState(() {});
                  },
                  child: Text(
                    e.name,
                    style: AppStyle.normal.copyWith(
                        color: _isSelected
                            ? Colors.grey
                            : isSelect
                                ? Colors.blue
                                : Colors.black),
                  )),
            );
          }).toList(),
        ),
        Wrap(
          children: nums.map((item) {
            final data = item.data;
            String n = '';
            if (data is PlayerDB) {
              n = data.name;
            }
            return InkWell(
              onTap: () {
                if (item.isShow == false) {
                  item.isShow = true;
                  if (_player != null) {
                    item.data = _player?.data;
                    _selectplayers.add(_player!);
                    _player = null;
                  }
                }
                setState(() {});
              },
              child: Container(
                height: 50,
                width: 66,
                margin: const EdgeInsets.all(8),
                color: !item.isShow
                    ? Colors.lightBlue
                    : item.value % 2 == 0
                        ? Colors.red
                        : Colors.black,
                child: Center(
                    child: Text(
                  n,
                  style: AppStyle.caption.copyWith(color: Colors.white),
                )),
              ),
            );
          }).toList(),
        )
        // Flexible(
        //   child: GridView.builder(
        //     itemCount: nums.length,
        //     padding: const EdgeInsets.all(15),
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.5),
        //     itemBuilder: (context, index) {
        //       final item = nums[index];
        //       return InkWell(
        //         onTap: () {
        //           item.isShow = true;
        //           setState(() {});
        //         },
        //         child: Container(
        //           margin: const EdgeInsets.all(8),
        //           color: !item.isShow
        //               ? Colors.lightBlue
        //               : item.value % 2 == 0
        //                   ? Colors.red
        //                   : Colors.black,
        //           child: Center(child: Text('')),
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }

  List<_Entity> _genNums(int max) {
    final res = List.generate(max, (index) => index + 1);
    res.shuffle();
    return res.map((e) => _Entity(value: e)).toList();
  }
}

class _Entity {
  final int value;
  bool isShow;
  dynamic data;

  _Entity({required this.value, this.isShow = false, this.data});
}
