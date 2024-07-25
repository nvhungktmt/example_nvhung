import 'package:realm/realm.dart';

part 'person_db.g.dart';

@RealmModel()
class _PersonDB {
  @PrimaryKey()
  int id = DateTime.now().millisecondsSinceEpoch;
  String name = "";
  int gender = 0;
  String rel = "";
  String birth = "";
  int relId = 0;
}

// extension PersonDBExt on PersonDB {
//   PersonDB init() {
//     return PersonDB(id = DateTime.now().millisecondsSinceEpoch);
//   }
// }
