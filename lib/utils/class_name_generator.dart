import '../models/course_type.dart';

String generateClassName(CourseType course, int grade, int classNumber) {
  return '${course.abbreviation}$grade-$classNumber';
}
