import 'package:drift/drift.dart';

class Teachers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get weeklyTargetHours => integer()();
  BoolColumn get isHomeroom => boolean()();
}
