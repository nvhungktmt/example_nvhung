// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:match_manager/models/db/match_db.dart';

class AddMatchState {
  bool isEdit = true;
  MatchDB match;
  AddMatchState({
    this.isEdit = true,
    required this.match,
  });

  List<MatchDetailDB> get t1 => match.details.where((element) => element.team == 1).toList();
  List<MatchDetailDB> get t2 => match.details.where((element) => element.team == 2).toList();
}
