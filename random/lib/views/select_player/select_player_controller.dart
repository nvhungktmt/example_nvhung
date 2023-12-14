import 'package:get/get.dart';
import 'package:random/local/player_local.dart';
import 'package:random/models/db/player_db.dart';
// import 'package:random/commons/num_extension.dart';

class SelectPlayerController extends GetxController {
  var players = PlayerDBLocal.shared.alls.obs;
  var selectplayers = <PlayerDB>[].obs;
  final List<PlayerDB>? selected;

  SelectPlayerController({this.selected});
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectplayers.value = selected ?? [];
  }

  void reloadData() {
    final allPlayer = PlayerDBLocal.shared.alls;

    players.value = allPlayer;
  }

  void onDone() {
    Get.back(result: selectplayers.value);
  }
}
