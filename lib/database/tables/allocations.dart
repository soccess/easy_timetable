import 'package:drift/drift.dart';
import 'school_classes.dart';
import 'subjects.dart';
import 'teachers.dart';

class Allocations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get classId => integer().references(SchoolClasses, #id)();
  IntColumn get subjectId => integer().references(Subjects, #id)();
  IntColumn get teacherId => integer().references(Teachers, #id)();
  IntColumn get assignedHours => integer()();
}
