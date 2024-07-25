import 'package:realm/realm.dart';

part 'person.g.dart'; // Đảm bảo bạn đã cài đặt build_runner để tạo file này

@RealmModel()
class _Person {
  @PrimaryKey()
  late ObjectId id;

  late String name;
  late String birthDate;
  late String relationship;
  late String relationshipId; // ID của mối quan hệ
  late String gender; // Giới tính
}
