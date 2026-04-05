import 'package:drift/drift.dart';
import '../../models/course_type.dart';

class SchoolClasses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get course => textEnum<CourseType>()();
  IntColumn get grade => integer()();
  IntColumn get classNumber => integer()();
  TextColumn get className => text()();
  IntColumn get weeklyTargetHours => integer()();
}
