// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_db.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class PlayerDB extends _PlayerDB
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  PlayerDB(
    int id,
    String name, {
    int? goal = 0,
    int? ogoal = 0,
    int? match = 0,
    int? win = 0,
    int? lost = 0,
    int? assit = 0,
    int? elo = 0,
    bool? isFavourite,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<PlayerDB>({
        'goal': 0,
        'ogoal': 0,
        'match': 0,
        'win': 0,
        'lost': 0,
        'assit': 0,
        'elo': 0,
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'goal', goal);
    RealmObjectBase.set(this, 'ogoal', ogoal);
    RealmObjectBase.set(this, 'match', match);
    RealmObjectBase.set(this, 'win', win);
    RealmObjectBase.set(this, 'lost', lost);
    RealmObjectBase.set(this, 'assit', assit);
    RealmObjectBase.set(this, 'elo', elo);
    RealmObjectBase.set(this, 'isFavourite', isFavourite);
  }

  PlayerDB._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int? get goal => RealmObjectBase.get<int>(this, 'goal') as int?;
  @override
  set goal(int? value) => RealmObjectBase.set(this, 'goal', value);

  @override
  int? get ogoal => RealmObjectBase.get<int>(this, 'ogoal') as int?;
  @override
  set ogoal(int? value) => RealmObjectBase.set(this, 'ogoal', value);

  @override
  int? get match => RealmObjectBase.get<int>(this, 'match') as int?;
  @override
  set match(int? value) => RealmObjectBase.set(this, 'match', value);

  @override
  int? get win => RealmObjectBase.get<int>(this, 'win') as int?;
  @override
  set win(int? value) => RealmObjectBase.set(this, 'win', value);

  @override
  int? get lost => RealmObjectBase.get<int>(this, 'lost') as int?;
  @override
  set lost(int? value) => RealmObjectBase.set(this, 'lost', value);

  @override
  int? get assit => RealmObjectBase.get<int>(this, 'assit') as int?;
  @override
  set assit(int? value) => RealmObjectBase.set(this, 'assit', value);

  @override
  int? get elo => RealmObjectBase.get<int>(this, 'elo') as int?;
  @override
  set elo(int? value) => RealmObjectBase.set(this, 'elo', value);

  @override
  bool? get isFavourite =>
      RealmObjectBase.get<bool>(this, 'isFavourite') as bool?;
  @override
  set isFavourite(bool? value) =>
      RealmObjectBase.set(this, 'isFavourite', value);

  @override
  Stream<RealmObjectChanges<PlayerDB>> get changes =>
      RealmObjectBase.getChanges<PlayerDB>(this);

  @override
  PlayerDB freeze() => RealmObjectBase.freezeObject<PlayerDB>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(PlayerDB._);
    return const SchemaObject(ObjectType.realmObject, PlayerDB, 'PlayerDB', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('goal', RealmPropertyType.int, optional: true),
      SchemaProperty('ogoal', RealmPropertyType.int, optional: true),
      SchemaProperty('match', RealmPropertyType.int, optional: true),
      SchemaProperty('win', RealmPropertyType.int, optional: true),
      SchemaProperty('lost', RealmPropertyType.int, optional: true),
      SchemaProperty('assit', RealmPropertyType.int, optional: true),
      SchemaProperty('elo', RealmPropertyType.int, optional: true),
      SchemaProperty('isFavourite', RealmPropertyType.bool, optional: true),
    ]);
  }
}
