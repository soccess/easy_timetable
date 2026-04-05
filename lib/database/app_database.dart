import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import '../models/course_type.dart';
import 'tables/school_classes.dart';
import 'tables/subjects.dart';
import 'tables/teachers.dart';
import 'tables/allocations.dart';
import 'tables/timetables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [SchoolClasses, Subjects, Teachers, Allocations, Timetables])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'easy_timetable.sqlite'));


    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
