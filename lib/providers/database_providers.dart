import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import '../models/course_type.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

// SchoolClasses Stream Provider
final schoolClassesProvider = StreamProvider<List<SchoolClassesData>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.schoolClasses).watch();
});

// Subjects Stream Provider
final subjectsProvider = StreamProvider<List<Subject>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.subjects).watch();
});

// Teachers Stream Provider
final teachersProvider = StreamProvider<List<Teacher>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.teachers).watch();
});

// Allocations Stream Provider
final allocationsProvider = StreamProvider<List<Allocation>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.allocations).watch();
});

// Timetables Stream Provider
final timetablesProvider = StreamProvider<List<Timetable>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.timetables).watch();
});
