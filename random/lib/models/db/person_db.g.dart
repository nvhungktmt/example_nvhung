// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_db.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class PersonDB extends _PersonDB
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  PersonDB(
    int id, {
    String name = "",
    int gender = 0,
    String rel = "",
    String birth = "",
    int relId = 0,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<PersonDB>({
        'id': DateTime.now().millisecondsSinceEpoch,
        'name': "",
        'gender': 0,
        'rel': "",
        'birth': "",
        'relId': 0,
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'gender', gender);
    RealmObjectBase.set(this, 'rel', rel);
    RealmObjectBase.set(this, 'birth', birth);
    RealmObjectBase.set(this, 'relId', relId);
  }

  PersonDB._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get gender => RealmObjectBase.get<int>(this, 'gender') as int;
  @override
  set gender(int value) => RealmObjectBase.set(this, 'gender', value);

  @override
  String get rel => RealmObjectBase.get<String>(this, 'rel') as String;
  @override
  set rel(String value) => RealmObjectBase.set(this, 'rel', value);

  @override
  String get birth => RealmObjectBase.get<String>(this, 'birth') as String;
  @override
  set birth(String value) => RealmObjectBase.set(this, 'birth', value);

  @override
  int get relId => RealmObjectBase.get<int>(this, 'relId') as int;
  @override
  set relId(int value) => RealmObjectBase.set(this, 'relId', value);

  @override
  Stream<RealmObjectChanges<PersonDB>> get changes =>
      RealmObjectBase.getChanges<PersonDB>(this);

  @override
  PersonDB freeze() => RealmObjectBase.freezeObject<PersonDB>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(PersonDB._);
    return const SchemaObject(ObjectType.realmObject, PersonDB, 'PersonDB', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('gender', RealmPropertyType.int),
      SchemaProperty('rel', RealmPropertyType.string),
      SchemaProperty('birth', RealmPropertyType.string),
      SchemaProperty('relId', RealmPropertyType.int),
    ]);
  }
}
