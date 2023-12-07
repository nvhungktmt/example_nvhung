import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/views/match_list/match_list_view.dart';
import 'package:random/views/player/player_list_view.dart';
import 'package:random/views/random/random_view.dart';
import 'package:random/views/select_player/select_player_view.dart';

/// Flutter code sample for [TabBar].

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const TabBarExample(),
    );
  }
}

class TabBarExample extends StatefulWidget {
  const TabBarExample({Key? key}) : super(key: key);

  @override
  State<TabBarExample> createState() => _TabBarExampleState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _TabBarExampleState extends State<TabBarExample> with TickerProviderStateMixin {
  late final TabController _tabController;
  int? _lastIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TabBar(
        // tabAlignment: TabAlignment.,
        controller: _tabController,
        onTap: (i) {
          if (i == 2) {
            _tabController.index = _lastIndex ?? 0;
            Get.to(RandomView())?.then((value) {
              print(value);
            });
          } else {
            _lastIndex = i;
          }
        },
        tabs: const <Widget>[
          Tab(
            icon: Icon(Icons.emoji_people_outlined),
          ),
          Tab(
            icon: Icon(Icons.beach_access_sharp),
          ),
          Tab(
            icon: Icon(Icons.add_box_rounded),
          ),
          Tab(
            icon: Icon(Icons.beach_access_sharp),
          ),
          Tab(
            icon: Icon(Icons.brightness_5_sharp),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          PlayerListView(),
          MatchListView(),
          Center(
            child: Text("It's rainy here"),
          ),
          Center(
            child: Text("It's sunny here"),
          ),
          Center(
            child: Text("It's sunny here"),
          ),
        ],
      ),
    );
  }
}
