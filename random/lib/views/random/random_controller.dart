import 'package:get/get.dart';
import 'package:match_manager/local/player_local.dart';
// import 'package:match_manager/commons/num_extension.dart';

class RandomController extends GetxController {
  var players = <List<PlayerDBLocal>>[].obs;
  @override
  void onInit() {
    super.onInit();
    players.add([]);
    players.add([]);
    players.add([]);
    players.add([]);
  }
}
