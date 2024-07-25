import 'package:realm/realm.dart';
import '../models/person.dart';

class RealmService {
  late Realm realm;

  RealmService() {
    final config = Configuration.local([Person.schema]);
    realm = Realm(config);
  }
  List<Person> getRelatedPersons(String relationshipId) {
    return realm.all<Person>().where((person) => person.relationshipId == relationshipId).toList();
  }

  void insertPerson(Person person) {
    realm.write(() {
      realm.add(person);
    });
  }

  List<Person> getPersons() {
    return realm.all<Person>().toList();
  }

  void updatePerson(Person updatedPerson) {
    final person = realm.find<Person>(updatedPerson.id);
    if (person != null) {
      realm.write(() {
        person.name = updatedPerson.name;
        person.birthDate = updatedPerson.birthDate;
        person.relationship = updatedPerson.relationship;
        person.relationshipId = updatedPerson.relationshipId;
        person.gender = updatedPerson.gender;
      });
    }
  }

  void deletePerson(ObjectId id) {
    final person = realm.find<Person>(id);
    if (person != null) {
      realm.write(() {
        realm.delete(person);
      });
    }
  }
}
