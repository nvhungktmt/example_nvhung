// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_db.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class MatchDB extends _MatchDB with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  MatchDB(
    int id,
    String date,
    int goal1,
    int goal2, {
    int? isGH = 0,
    Iterable<MatchDetailDB> details = const [],
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<MatchDB>({
        'isGH': 0,
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'goal1', goal1);
    RealmObjectBase.set(this, 'goal2', goal2);
    RealmObjectBase.set(this, 'isGH', isGH);
    RealmObjectBase.set<RealmList<MatchDetailDB>>(
        this, 'details', RealmList<MatchDetailDB>(details));
  }

  MatchDB._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get date => RealmObjectBase.get<String>(this, 'date') as String;
  @override
  set date(String value) => RealmObjectBase.set(this, 'date', value);

  @override
  int get goal1 => RealmObjectBase.get<int>(this, 'goal1') as int;
  @override
  set goal1(int value) => RealmObjectBase.set(this, 'goal1', value);

  @override
  int get goal2 => RealmObjectBase.get<int>(this, 'goal2') as int;
  @override
  set goal2(int value) => RealmObjectBase.set(this, 'goal2', value);

  @override
  int? get isGH => RealmObjectBase.get<int>(this, 'isGH') as int?;
  @override
  set isGH(int? value) => RealmObjectBase.set(this, 'isGH', value);

  @override
  RealmList<MatchDetailDB> get details =>
      RealmObjectBase.get<MatchDetailDB>(this, 'details')
          as RealmList<MatchDetailDB>;
  @override
  set details(covariant RealmList<MatchDetailDB> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<MatchDB>> get changes =>
      RealmObjectBase.getChanges<MatchDB>(this);

  @override
  MatchDB freeze() => RealmObjectBase.freezeObject<MatchDB>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(MatchDB._);
    return const SchemaObject(ObjectType.realmObject, MatchDB, 'MatchDB', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('date', RealmPropertyType.string),
      SchemaProperty('goal1', RealmPropertyType.int),
      SchemaProperty('goal2', RealmPropertyType.int),
      SchemaProperty('isGH', RealmPropertyType.int, optional: true),
      SchemaProperty('details', RealmPropertyType.object,
          linkTarget: 'MatchDetailDB',
          collectionType: RealmCollectionType.list),
    ]);
  }
}

// ignore_for_file: type=lint
class MatchDetailDB extends _MatchDetailDB
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  MatchDetailDB(
    int id,
    int mid,
    int pid,
    String pName,
    int goal,
    int ogoal,
    int elo,
    int team,
    String date, {
    int? isGH = 0,
    int? assit = 0,
    int? win,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<MatchDetailDB>({
        'isGH': 0,
        'assit': 0,
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'mid', mid);
    RealmObjectBase.set(this, 'pid', pid);
    RealmObjectBase.set(this, 'isGH', isGH);
    RealmObjectBase.set(this, 'pName', pName);
    RealmObjectBase.set(this, 'goal', goal);
    RealmObjectBase.set(this, 'ogoal', ogoal);
    RealmObjectBase.set(this, 'assit', assit);
    RealmObjectBase.set(this, 'elo', elo);
    RealmObjectBase.set(this, 'team', team);
    RealmObjectBase.set(this, 'win', win);
    RealmObjectBase.set(this, 'date', date);
  }

  MatchDetailDB._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  int get mid => RealmObjectBase.get<int>(this, 'mid') as int;
  @override
  set mid(int value) => RealmObjectBase.set(this, 'mid', value);

  @override
  int get pid => RealmObjectBase.get<int>(this, 'pid') as int;
  @override
  set pid(int value) => RealmObjectBase.set(this, 'pid', value);

  @override
  int? get isGH => RealmObjectBase.get<int>(this, 'isGH') as int?;
  @override
  set isGH(int? value) => RealmObjectBase.set(this, 'isGH', value);

  @override
  String get pName => RealmObjectBase.get<String>(this, 'pName') as String;
  @override
  set pName(String value) => RealmObjectBase.set(this, 'pName', value);

  @override
  int get goal => RealmObjectBase.get<int>(this, 'goal') as int;
  @override
  set goal(int value) => RealmObjectBase.set(this, 'goal', value);

  @override
  int get ogoal => RealmObjectBase.get<int>(this, 'ogoal') as int;
  @override
  set ogoal(int value) => RealmObjectBase.set(this, 'ogoal', value);

  @override
  int? get assit => RealmObjectBase.get<int>(this, 'assit') as int?;
  @override
  set assit(int? value) => RealmObjectBase.set(this, 'assit', value);

  @override
  int get elo => RealmObjectBase.get<int>(this, 'elo') as int;
  @override
  set elo(int value) => RealmObjectBase.set(this, 'elo', value);

  @override
  int get team => RealmObjectBase.get<int>(this, 'team') as int;
  @override
  set team(int value) => RealmObjectBase.set(this, 'team', value);

  @override
  int? get win => RealmObjectBase.get<int>(this, 'win') as int?;
  @override
  set win(int? value) => RealmObjectBase.set(this, 'win', value);

  @override
  String get date => RealmObjectBase.get<String>(this, 'date') as String;
  @override
  set date(String value) => RealmObjectBase.set(this, 'date', value);

  @override
  Stream<RealmObjectChanges<MatchDetailDB>> get changes =>
      RealmObjectBase.getChanges<MatchDetailDB>(this);

  @override
  MatchDetailDB freeze() => RealmObjectBase.freezeObject<MatchDetailDB>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(MatchDetailDB._);
    return const SchemaObject(
        ObjectType.realmObject, MatchDetailDB, 'MatchDetailDB', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('mid', RealmPropertyType.int),
      SchemaProperty('pid', RealmPropertyType.int),
      SchemaProperty('isGH', RealmPropertyType.int, optional: true),
      SchemaProperty('pName', RealmPropertyType.string),
      SchemaProperty('goal', RealmPropertyType.int),
      SchemaProperty('ogoal', RealmPropertyType.int),
      SchemaProperty('assit', RealmPropertyType.int, optional: true),
      SchemaProperty('elo', RealmPropertyType.int),
      SchemaProperty('team', RealmPropertyType.int),
      SchemaProperty('win', RealmPropertyType.int, optional: true),
      SchemaProperty('date', RealmPropertyType.string),
    ]);
  }
}
