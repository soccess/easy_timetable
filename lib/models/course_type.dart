enum CourseType {
  elementary('초', '초등', 1, 6),
  middle('중', '중학', 1, 3),
  high('고', '고등', 1, 3),
  major('전공', '전공과', 1, 2);

  final String abbreviation;
  final String displayName;
  final int minGrade;
  final int maxGrade;

  const CourseType(this.abbreviation, this.displayName, this.minGrade, this.maxGrade);
}
