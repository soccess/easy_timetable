enum CourseType {
  elementary('초', 1, 6),
  middle('중', 1, 3),
  high('고', 1, 3),
  major('전공', 1, 2);

  final String abbreviation;
  final int minGrade;
  final int maxGrade;

  const CourseType(this.abbreviation, this.minGrade, this.maxGrade);
}
