import 'package:drift/drift.dart';
import '../../models/course_type.dart';

class Subjects extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get course => textEnum<CourseType>()();
  IntColumn get grade => integer()();
  TextColumn get subjectName => text()();
  IntColumn get weeklyTargetHours => integer()();
}
