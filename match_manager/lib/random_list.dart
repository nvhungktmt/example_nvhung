import 'package:flutter/material.dart';

class RandomList extends StatefulWidget {
  const RandomList();

  @override
  State<RandomList> createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  List<_Entity> nums = [];
  int max = 6;
  @override
  void initState() {
    super.initState();
    nums = _genNums(max);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      if (max <= 0) {
                        return;
                      }
                      max--;
                      nums = _genNums(max);
                      setState(() {});
                    },
                    icon: Icon(Icons.remove_circle)),
                Text('$max'),
                IconButton(
                    onPressed: () {
                      max++;
                      nums = _genNums(max);
                      setState(() {});
                    },
                    icon: Icon(Icons.add_circle))
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: nums.length,
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.5),
              itemBuilder: (context, index) {
                final item = nums[index];
                return InkWell(
                  onTap: () {
                    item.isShow = true;
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    color: !item.isShow
                        ? Colors.lightBlue
                        : item.value % 2 == 0
                            ? Colors.red
                            : Colors.black,
                    child: Center(child: Text('')),
                  ),
                );
              },
            ),
          ),
        ],
      ),
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

  _Entity({required this.value, this.isShow = false});
}
