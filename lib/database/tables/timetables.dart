import 'package:drift/drift.dart';
import 'allocations.dart';

class Timetables extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get allocationId => integer().references(Allocations, #id)();
  IntColumn get dayOfWeek => integer()(); // 1 to 5 (Monday to Friday)
  IntColumn get period => integer()(); // 1 to 7
}
