import 'package:flutter_test/flutter_test.dart';
import 'package:easy_timetable/models/course_type.dart';
import 'package:easy_timetable/utils/class_name_generator.dart';

void main() {
  group('generateClassName', () {
    test('generates correct name for elementary', () {
      expect(generateClassName(CourseType.elementary, 1, 1), '초1-1');
    });

    test('generates correct name for middle', () {
      expect(generateClassName(CourseType.middle, 2, 3), '중2-3');
    });

    test('generates correct name for high', () {
      expect(generateClassName(CourseType.high, 3, 5), '고3-5');
    });

    test('generates correct name for major', () {
      expect(generateClassName(CourseType.major, 1, 2), '전공1-2');
    });
  });
}
