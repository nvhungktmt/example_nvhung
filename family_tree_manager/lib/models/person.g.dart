// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Person extends _Person with RealmEntity, RealmObjectBase, RealmObject {
  Person(
    ObjectId id,
    String name,
    String birthDate,
    String relationship,
    String relationshipId,
    String gender,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'birthDate', birthDate);
    RealmObjectBase.set(this, 'relationship', relationship);
    RealmObjectBase.set(this, 'relationshipId', relationshipId);
    RealmObjectBase.set(this, 'gender', gender);
  }

  Person._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get birthDate =>
      RealmObjectBase.get<String>(this, 'birthDate') as String;
  @override
  set birthDate(String value) => RealmObjectBase.set(this, 'birthDate', value);

  @override
  String get relationship =>
      RealmObjectBase.get<String>(this, 'relationship') as String;
  @override
  set relationship(String value) =>
      RealmObjectBase.set(this, 'relationship', value);

  @override
  String get relationshipId =>
      RealmObjectBase.get<String>(this, 'relationshipId') as String;
  @override
  set relationshipId(String value) =>
      RealmObjectBase.set(this, 'relationshipId', value);

  @override
  String get gender => RealmObjectBase.get<String>(this, 'gender') as String;
  @override
  set gender(String value) => RealmObjectBase.set(this, 'gender', value);

  @override
  Stream<RealmObjectChanges<Person>> get changes =>
      RealmObjectBase.getChanges<Person>(this);

  @override
  Person freeze() => RealmObjectBase.freezeObject<Person>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Person._);
    return const SchemaObject(ObjectType.realmObject, Person, 'Person', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('birthDate', RealmPropertyType.string),
      SchemaProperty('relationship', RealmPropertyType.string),
      SchemaProperty('relationshipId', RealmPropertyType.string),
      SchemaProperty('gender', RealmPropertyType.string),
    ]);
  }
}
