// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SchoolClassesTable extends SchoolClasses
    with TableInfo<$SchoolClassesTable, SchoolClassesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SchoolClassesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<CourseType, String> course =
      GeneratedColumn<String>(
        'course',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<CourseType>($SchoolClassesTable.$convertercourse);
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<int> grade = GeneratedColumn<int>(
    'grade',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classNumberMeta = const VerificationMeta(
    'classNumber',
  );
  @override
  late final GeneratedColumn<int> classNumber = GeneratedColumn<int>(
    'class_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classNameMeta = const VerificationMeta(
    'className',
  );
  @override
  late final GeneratedColumn<String> className = GeneratedColumn<String>(
    'class_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weeklyTargetHoursMeta = const VerificationMeta(
    'weeklyTargetHours',
  );
  @override
  late final GeneratedColumn<int> weeklyTargetHours = GeneratedColumn<int>(
    'weekly_target_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    course,
    grade,
    classNumber,
    className,
    weeklyTargetHours,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'school_classes';
  @override
  VerificationContext validateIntegrity(
    Insertable<SchoolClassesData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('grade')) {
      context.handle(
        _gradeMeta,
        grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta),
      );
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('class_number')) {
      context.handle(
        _classNumberMeta,
        classNumber.isAcceptableOrUnknown(
          data['class_number']!,
          _classNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_classNumberMeta);
    }
    if (data.containsKey('class_name')) {
      context.handle(
        _classNameMeta,
        className.isAcceptableOrUnknown(data['class_name']!, _classNameMeta),
      );
    } else if (isInserting) {
      context.missing(_classNameMeta);
    }
    if (data.containsKey('weekly_target_hours')) {
      context.handle(
        _weeklyTargetHoursMeta,
        weeklyTargetHours.isAcceptableOrUnknown(
          data['weekly_target_hours']!,
          _weeklyTargetHoursMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weeklyTargetHoursMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SchoolClassesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SchoolClassesData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      course: $SchoolClassesTable.$convertercourse.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}course'],
        )!,
      ),
      grade: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grade'],
      )!,
      classNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}class_number'],
      )!,
      className: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_name'],
      )!,
      weeklyTargetHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekly_target_hours'],
      )!,
    );
  }

  @override
  $SchoolClassesTable createAlias(String alias) {
    return $SchoolClassesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CourseType, String, String> $convertercourse =
      const EnumNameConverter<CourseType>(CourseType.values);
}

class SchoolClassesData extends DataClass
    implements Insertable<SchoolClassesData> {
  final int id;
  final CourseType course;
  final int grade;
  final int classNumber;
  final String className;
  final int weeklyTargetHours;
  const SchoolClassesData({
    required this.id,
    required this.course,
    required this.grade,
    required this.classNumber,
    required this.className,
    required this.weeklyTargetHours,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['course'] = Variable<String>(
        $SchoolClassesTable.$convertercourse.toSql(course),
      );
    }
    map['grade'] = Variable<int>(grade);
    map['class_number'] = Variable<int>(classNumber);
    map['class_name'] = Variable<String>(className);
    map['weekly_target_hours'] = Variable<int>(weeklyTargetHours);
    return map;
  }

  SchoolClassesCompanion toCompanion(bool nullToAbsent) {
    return SchoolClassesCompanion(
      id: Value(id),
      course: Value(course),
      grade: Value(grade),
      classNumber: Value(classNumber),
      className: Value(className),
      weeklyTargetHours: Value(weeklyTargetHours),
    );
  }

  factory SchoolClassesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SchoolClassesData(
      id: serializer.fromJson<int>(json['id']),
      course: $SchoolClassesTable.$convertercourse.fromJson(
        serializer.fromJson<String>(json['course']),
      ),
      grade: serializer.fromJson<int>(json['grade']),
      classNumber: serializer.fromJson<int>(json['classNumber']),
      className: serializer.fromJson<String>(json['className']),
      weeklyTargetHours: serializer.fromJson<int>(json['weeklyTargetHours']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'course': serializer.toJson<String>(
        $SchoolClassesTable.$convertercourse.toJson(course),
      ),
      'grade': serializer.toJson<int>(grade),
      'classNumber': serializer.toJson<int>(classNumber),
      'className': serializer.toJson<String>(className),
      'weeklyTargetHours': serializer.toJson<int>(weeklyTargetHours),
    };
  }

  SchoolClassesData copyWith({
    int? id,
    CourseType? course,
    int? grade,
    int? classNumber,
    String? className,
    int? weeklyTargetHours,
  }) => SchoolClassesData(
    id: id ?? this.id,
    course: course ?? this.course,
    grade: grade ?? this.grade,
    classNumber: classNumber ?? this.classNumber,
    className: className ?? this.className,
    weeklyTargetHours: weeklyTargetHours ?? this.weeklyTargetHours,
  );
  SchoolClassesData copyWithCompanion(SchoolClassesCompanion data) {
    return SchoolClassesData(
      id: data.id.present ? data.id.value : this.id,
      course: data.course.present ? data.course.value : this.course,
      grade: data.grade.present ? data.grade.value : this.grade,
      classNumber: data.classNumber.present
          ? data.classNumber.value
          : this.classNumber,
      className: data.className.present ? data.className.value : this.className,
      weeklyTargetHours: data.weeklyTargetHours.present
          ? data.weeklyTargetHours.value
          : this.weeklyTargetHours,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SchoolClassesData(')
          ..write('id: $id, ')
          ..write('course: $course, ')
          ..write('grade: $grade, ')
          ..write('classNumber: $classNumber, ')
          ..write('className: $className, ')
          ..write('weeklyTargetHours: $weeklyTargetHours')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, course, grade, classNumber, className, weeklyTargetHours);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SchoolClassesData &&
          other.id == this.id &&
          other.course == this.course &&
          other.grade == this.grade &&
          other.classNumber == this.classNumber &&
          other.className == this.className &&
          other.weeklyTargetHours == this.weeklyTargetHours);
}

class SchoolClassesCompanion extends UpdateCompanion<SchoolClassesData> {
  final Value<int> id;
  final Value<CourseType> course;
  final Value<int> grade;
  final Value<int> classNumber;
  final Value<String> className;
  final Value<int> weeklyTargetHours;
  const SchoolClassesCompanion({
    this.id = const Value.absent(),
    this.course = const Value.absent(),
    this.grade = const Value.absent(),
    this.classNumber = const Value.absent(),
    this.className = const Value.absent(),
    this.weeklyTargetHours = const Value.absent(),
  });
  SchoolClassesCompanion.insert({
    this.id = const Value.absent(),
    required CourseType course,
    required int grade,
    required int classNumber,
    required String className,
    required int weeklyTargetHours,
  }) : course = Value(course),
       grade = Value(grade),
       classNumber = Value(classNumber),
       className = Value(className),
       weeklyTargetHours = Value(weeklyTargetHours);
  static Insertable<SchoolClassesData> custom({
    Expression<int>? id,
    Expression<String>? course,
    Expression<int>? grade,
    Expression<int>? classNumber,
    Expression<String>? className,
    Expression<int>? weeklyTargetHours,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (course != null) 'course': course,
      if (grade != null) 'grade': grade,
      if (classNumber != null) 'class_number': classNumber,
      if (className != null) 'class_name': className,
      if (weeklyTargetHours != null) 'weekly_target_hours': weeklyTargetHours,
    });
  }

  SchoolClassesCompanion copyWith({
    Value<int>? id,
    Value<CourseType>? course,
    Value<int>? grade,
    Value<int>? classNumber,
    Value<String>? className,
    Value<int>? weeklyTargetHours,
  }) {
    return SchoolClassesCompanion(
      id: id ?? this.id,
      course: course ?? this.course,
      grade: grade ?? this.grade,
      classNumber: classNumber ?? this.classNumber,
      className: className ?? this.className,
      weeklyTargetHours: weeklyTargetHours ?? this.weeklyTargetHours,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (course.present) {
      map['course'] = Variable<String>(
        $SchoolClassesTable.$convertercourse.toSql(course.value),
      );
    }
    if (grade.present) {
      map['grade'] = Variable<int>(grade.value);
    }
    if (classNumber.present) {
      map['class_number'] = Variable<int>(classNumber.value);
    }
    if (className.present) {
      map['class_name'] = Variable<String>(className.value);
    }
    if (weeklyTargetHours.present) {
      map['weekly_target_hours'] = Variable<int>(weeklyTargetHours.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SchoolClassesCompanion(')
          ..write('id: $id, ')
          ..write('course: $course, ')
          ..write('grade: $grade, ')
          ..write('classNumber: $classNumber, ')
          ..write('className: $className, ')
          ..write('weeklyTargetHours: $weeklyTargetHours')
          ..write(')'))
        .toString();
  }
}

class $SubjectsTable extends Subjects with TableInfo<$SubjectsTable, Subject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<CourseType, String> course =
      GeneratedColumn<String>(
        'course',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<CourseType>($SubjectsTable.$convertercourse);
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<int> grade = GeneratedColumn<int>(
    'grade',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectNameMeta = const VerificationMeta(
    'subjectName',
  );
  @override
  late final GeneratedColumn<String> subjectName = GeneratedColumn<String>(
    'subject_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weeklyTargetHoursMeta = const VerificationMeta(
    'weeklyTargetHours',
  );
  @override
  late final GeneratedColumn<int> weeklyTargetHours = GeneratedColumn<int>(
    'weekly_target_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    course,
    grade,
    subjectName,
    weeklyTargetHours,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subjects';
  @override
  VerificationContext validateIntegrity(
    Insertable<Subject> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('grade')) {
      context.handle(
        _gradeMeta,
        grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta),
      );
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('subject_name')) {
      context.handle(
        _subjectNameMeta,
        subjectName.isAcceptableOrUnknown(
          data['subject_name']!,
          _subjectNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subjectNameMeta);
    }
    if (data.containsKey('weekly_target_hours')) {
      context.handle(
        _weeklyTargetHoursMeta,
        weeklyTargetHours.isAcceptableOrUnknown(
          data['weekly_target_hours']!,
          _weeklyTargetHoursMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weeklyTargetHoursMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subject(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      course: $SubjectsTable.$convertercourse.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}course'],
        )!,
      ),
      grade: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grade'],
      )!,
      subjectName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_name'],
      )!,
      weeklyTargetHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekly_target_hours'],
      )!,
    );
  }

  @override
  $SubjectsTable createAlias(String alias) {
    return $SubjectsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CourseType, String, String> $convertercourse =
      const EnumNameConverter<CourseType>(CourseType.values);
}

class Subject extends DataClass implements Insertable<Subject> {
  final int id;
  final CourseType course;
  final int grade;
  final String subjectName;
  final int weeklyTargetHours;
  const Subject({
    required this.id,
    required this.course,
    required this.grade,
    required this.subjectName,
    required this.weeklyTargetHours,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['course'] = Variable<String>(
        $SubjectsTable.$convertercourse.toSql(course),
      );
    }
    map['grade'] = Variable<int>(grade);
    map['subject_name'] = Variable<String>(subjectName);
    map['weekly_target_hours'] = Variable<int>(weeklyTargetHours);
    return map;
  }

  SubjectsCompanion toCompanion(bool nullToAbsent) {
    return SubjectsCompanion(
      id: Value(id),
      course: Value(course),
      grade: Value(grade),
      subjectName: Value(subjectName),
      weeklyTargetHours: Value(weeklyTargetHours),
    );
  }

  factory Subject.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subject(
      id: serializer.fromJson<int>(json['id']),
      course: $SubjectsTable.$convertercourse.fromJson(
        serializer.fromJson<String>(json['course']),
      ),
      grade: serializer.fromJson<int>(json['grade']),
      subjectName: serializer.fromJson<String>(json['subjectName']),
      weeklyTargetHours: serializer.fromJson<int>(json['weeklyTargetHours']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'course': serializer.toJson<String>(
        $SubjectsTable.$convertercourse.toJson(course),
      ),
      'grade': serializer.toJson<int>(grade),
      'subjectName': serializer.toJson<String>(subjectName),
      'weeklyTargetHours': serializer.toJson<int>(weeklyTargetHours),
    };
  }

  Subject copyWith({
    int? id,
    CourseType? course,
    int? grade,
    String? subjectName,
    int? weeklyTargetHours,
  }) => Subject(
    id: id ?? this.id,
    course: course ?? this.course,
    grade: grade ?? this.grade,
    subjectName: subjectName ?? this.subjectName,
    weeklyTargetHours: weeklyTargetHours ?? this.weeklyTargetHours,
  );
  Subject copyWithCompanion(SubjectsCompanion data) {
    return Subject(
      id: data.id.present ? data.id.value : this.id,
      course: data.course.present ? data.course.value : this.course,
      grade: data.grade.present ? data.grade.value : this.grade,
      subjectName: data.subjectName.present
          ? data.subjectName.value
          : this.subjectName,
      weeklyTargetHours: data.weeklyTargetHours.present
          ? data.weeklyTargetHours.value
          : this.weeklyTargetHours,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subject(')
          ..write('id: $id, ')
          ..write('course: $course, ')
          ..write('grade: $grade, ')
          ..write('subjectName: $subjectName, ')
          ..write('weeklyTargetHours: $weeklyTargetHours')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, course, grade, subjectName, weeklyTargetHours);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subject &&
          other.id == this.id &&
          other.course == this.course &&
          other.grade == this.grade &&
          other.subjectName == this.subjectName &&
          other.weeklyTargetHours == this.weeklyTargetHours);
}

class SubjectsCompanion extends UpdateCompanion<Subject> {
  final Value<int> id;
  final Value<CourseType> course;
  final Value<int> grade;
  final Value<String> subjectName;
  final Value<int> weeklyTargetHours;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.course = const Value.absent(),
    this.grade = const Value.absent(),
    this.subjectName = const Value.absent(),
    this.weeklyTargetHours = const Value.absent(),
  });
  SubjectsCompanion.insert({
    this.id = const Value.absent(),
    required CourseType course,
    required int grade,
    required String subjectName,
    required int weeklyTargetHours,
  }) : course = Value(course),
       grade = Value(grade),
       subjectName = Value(subjectName),
       weeklyTargetHours = Value(weeklyTargetHours);
  static Insertable<Subject> custom({
    Expression<int>? id,
    Expression<String>? course,
    Expression<int>? grade,
    Expression<String>? subjectName,
    Expression<int>? weeklyTargetHours,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (course != null) 'course': course,
      if (grade != null) 'grade': grade,
      if (subjectName != null) 'subject_name': subjectName,
      if (weeklyTargetHours != null) 'weekly_target_hours': weeklyTargetHours,
    });
  }

  SubjectsCompanion copyWith({
    Value<int>? id,
    Value<CourseType>? course,
    Value<int>? grade,
    Value<String>? subjectName,
    Value<int>? weeklyTargetHours,
  }) {
    return SubjectsCompanion(
      id: id ?? this.id,
      course: course ?? this.course,
      grade: grade ?? this.grade,
      subjectName: subjectName ?? this.subjectName,
      weeklyTargetHours: weeklyTargetHours ?? this.weeklyTargetHours,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (course.present) {
      map['course'] = Variable<String>(
        $SubjectsTable.$convertercourse.toSql(course.value),
      );
    }
    if (grade.present) {
      map['grade'] = Variable<int>(grade.value);
    }
    if (subjectName.present) {
      map['subject_name'] = Variable<String>(subjectName.value);
    }
    if (weeklyTargetHours.present) {
      map['weekly_target_hours'] = Variable<int>(weeklyTargetHours.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectsCompanion(')
          ..write('id: $id, ')
          ..write('course: $course, ')
          ..write('grade: $grade, ')
          ..write('subjectName: $subjectName, ')
          ..write('weeklyTargetHours: $weeklyTargetHours')
          ..write(')'))
        .toString();
  }
}

class $TeachersTable extends Teachers with TableInfo<$TeachersTable, Teacher> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeachersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weeklyTargetHoursMeta = const VerificationMeta(
    'weeklyTargetHours',
  );
  @override
  late final GeneratedColumn<int> weeklyTargetHours = GeneratedColumn<int>(
    'weekly_target_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isHomeroomMeta = const VerificationMeta(
    'isHomeroom',
  );
  @override
  late final GeneratedColumn<bool> isHomeroom = GeneratedColumn<bool>(
    'is_homeroom',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_homeroom" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    weeklyTargetHours,
    isHomeroom,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'teachers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Teacher> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('weekly_target_hours')) {
      context.handle(
        _weeklyTargetHoursMeta,
        weeklyTargetHours.isAcceptableOrUnknown(
          data['weekly_target_hours']!,
          _weeklyTargetHoursMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weeklyTargetHoursMeta);
    }
    if (data.containsKey('is_homeroom')) {
      context.handle(
        _isHomeroomMeta,
        isHomeroom.isAcceptableOrUnknown(data['is_homeroom']!, _isHomeroomMeta),
      );
    } else if (isInserting) {
      context.missing(_isHomeroomMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Teacher map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Teacher(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      weeklyTargetHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekly_target_hours'],
      )!,
      isHomeroom: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_homeroom'],
      )!,
    );
  }

  @override
  $TeachersTable createAlias(String alias) {
    return $TeachersTable(attachedDatabase, alias);
  }
}

class Teacher extends DataClass implements Insertable<Teacher> {
  final int id;
  final String name;
  final int weeklyTargetHours;
  final bool isHomeroom;
  const Teacher({
    required this.id,
    required this.name,
    required this.weeklyTargetHours,
    required this.isHomeroom,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['weekly_target_hours'] = Variable<int>(weeklyTargetHours);
    map['is_homeroom'] = Variable<bool>(isHomeroom);
    return map;
  }

  TeachersCompanion toCompanion(bool nullToAbsent) {
    return TeachersCompanion(
      id: Value(id),
      name: Value(name),
      weeklyTargetHours: Value(weeklyTargetHours),
      isHomeroom: Value(isHomeroom),
    );
  }

  factory Teacher.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Teacher(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      weeklyTargetHours: serializer.fromJson<int>(json['weeklyTargetHours']),
      isHomeroom: serializer.fromJson<bool>(json['isHomeroom']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'weeklyTargetHours': serializer.toJson<int>(weeklyTargetHours),
      'isHomeroom': serializer.toJson<bool>(isHomeroom),
    };
  }

  Teacher copyWith({
    int? id,
    String? name,
    int? weeklyTargetHours,
    bool? isHomeroom,
  }) => Teacher(
    id: id ?? this.id,
    name: name ?? this.name,
    weeklyTargetHours: weeklyTargetHours ?? this.weeklyTargetHours,
    isHomeroom: isHomeroom ?? this.isHomeroom,
  );
  Teacher copyWithCompanion(TeachersCompanion data) {
    return Teacher(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      weeklyTargetHours: data.weeklyTargetHours.present
          ? data.weeklyTargetHours.value
          : this.weeklyTargetHours,
      isHomeroom: data.isHomeroom.present
          ? data.isHomeroom.value
          : this.isHomeroom,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Teacher(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('weeklyTargetHours: $weeklyTargetHours, ')
          ..write('isHomeroom: $isHomeroom')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, weeklyTargetHours, isHomeroom);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Teacher &&
          other.id == this.id &&
          other.name == this.name &&
          other.weeklyTargetHours == this.weeklyTargetHours &&
          other.isHomeroom == this.isHomeroom);
}

class TeachersCompanion extends UpdateCompanion<Teacher> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> weeklyTargetHours;
  final Value<bool> isHomeroom;
  const TeachersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.weeklyTargetHours = const Value.absent(),
    this.isHomeroom = const Value.absent(),
  });
  TeachersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int weeklyTargetHours,
    required bool isHomeroom,
  }) : name = Value(name),
       weeklyTargetHours = Value(weeklyTargetHours),
       isHomeroom = Value(isHomeroom);
  static Insertable<Teacher> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? weeklyTargetHours,
    Expression<bool>? isHomeroom,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (weeklyTargetHours != null) 'weekly_target_hours': weeklyTargetHours,
      if (isHomeroom != null) 'is_homeroom': isHomeroom,
    });
  }

  TeachersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? weeklyTargetHours,
    Value<bool>? isHomeroom,
  }) {
    return TeachersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      weeklyTargetHours: weeklyTargetHours ?? this.weeklyTargetHours,
      isHomeroom: isHomeroom ?? this.isHomeroom,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (weeklyTargetHours.present) {
      map['weekly_target_hours'] = Variable<int>(weeklyTargetHours.value);
    }
    if (isHomeroom.present) {
      map['is_homeroom'] = Variable<bool>(isHomeroom.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeachersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('weeklyTargetHours: $weeklyTargetHours, ')
          ..write('isHomeroom: $isHomeroom')
          ..write(')'))
        .toString();
  }
}

class $AllocationsTable extends Allocations
    with TableInfo<$AllocationsTable, Allocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AllocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<int> classId = GeneratedColumn<int>(
    'class_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES school_classes (id)',
    ),
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id)',
    ),
  );
  static const VerificationMeta _teacherIdMeta = const VerificationMeta(
    'teacherId',
  );
  @override
  late final GeneratedColumn<int> teacherId = GeneratedColumn<int>(
    'teacher_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES teachers (id)',
    ),
  );
  static const VerificationMeta _assignedHoursMeta = const VerificationMeta(
    'assignedHours',
  );
  @override
  late final GeneratedColumn<int> assignedHours = GeneratedColumn<int>(
    'assigned_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    classId,
    subjectId,
    teacherId,
    assignedHours,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'allocations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Allocation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('teacher_id')) {
      context.handle(
        _teacherIdMeta,
        teacherId.isAcceptableOrUnknown(data['teacher_id']!, _teacherIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teacherIdMeta);
    }
    if (data.containsKey('assigned_hours')) {
      context.handle(
        _assignedHoursMeta,
        assignedHours.isAcceptableOrUnknown(
          data['assigned_hours']!,
          _assignedHoursMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_assignedHoursMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Allocation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Allocation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}class_id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subject_id'],
      )!,
      teacherId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}teacher_id'],
      )!,
      assignedHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}assigned_hours'],
      )!,
    );
  }

  @override
  $AllocationsTable createAlias(String alias) {
    return $AllocationsTable(attachedDatabase, alias);
  }
}

class Allocation extends DataClass implements Insertable<Allocation> {
  final int id;
  final int classId;
  final int subjectId;
  final int teacherId;
  final int assignedHours;
  const Allocation({
    required this.id,
    required this.classId,
    required this.subjectId,
    required this.teacherId,
    required this.assignedHours,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['class_id'] = Variable<int>(classId);
    map['subject_id'] = Variable<int>(subjectId);
    map['teacher_id'] = Variable<int>(teacherId);
    map['assigned_hours'] = Variable<int>(assignedHours);
    return map;
  }

  AllocationsCompanion toCompanion(bool nullToAbsent) {
    return AllocationsCompanion(
      id: Value(id),
      classId: Value(classId),
      subjectId: Value(subjectId),
      teacherId: Value(teacherId),
      assignedHours: Value(assignedHours),
    );
  }

  factory Allocation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Allocation(
      id: serializer.fromJson<int>(json['id']),
      classId: serializer.fromJson<int>(json['classId']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
      teacherId: serializer.fromJson<int>(json['teacherId']),
      assignedHours: serializer.fromJson<int>(json['assignedHours']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'classId': serializer.toJson<int>(classId),
      'subjectId': serializer.toJson<int>(subjectId),
      'teacherId': serializer.toJson<int>(teacherId),
      'assignedHours': serializer.toJson<int>(assignedHours),
    };
  }

  Allocation copyWith({
    int? id,
    int? classId,
    int? subjectId,
    int? teacherId,
    int? assignedHours,
  }) => Allocation(
    id: id ?? this.id,
    classId: classId ?? this.classId,
    subjectId: subjectId ?? this.subjectId,
    teacherId: teacherId ?? this.teacherId,
    assignedHours: assignedHours ?? this.assignedHours,
  );
  Allocation copyWithCompanion(AllocationsCompanion data) {
    return Allocation(
      id: data.id.present ? data.id.value : this.id,
      classId: data.classId.present ? data.classId.value : this.classId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      teacherId: data.teacherId.present ? data.teacherId.value : this.teacherId,
      assignedHours: data.assignedHours.present
          ? data.assignedHours.value
          : this.assignedHours,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Allocation(')
          ..write('id: $id, ')
          ..write('classId: $classId, ')
          ..write('subjectId: $subjectId, ')
          ..write('teacherId: $teacherId, ')
          ..write('assignedHours: $assignedHours')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, classId, subjectId, teacherId, assignedHours);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Allocation &&
          other.id == this.id &&
          other.classId == this.classId &&
          other.subjectId == this.subjectId &&
          other.teacherId == this.teacherId &&
          other.assignedHours == this.assignedHours);
}

class AllocationsCompanion extends UpdateCompanion<Allocation> {
  final Value<int> id;
  final Value<int> classId;
  final Value<int> subjectId;
  final Value<int> teacherId;
  final Value<int> assignedHours;
  const AllocationsCompanion({
    this.id = const Value.absent(),
    this.classId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.teacherId = const Value.absent(),
    this.assignedHours = const Value.absent(),
  });
  AllocationsCompanion.insert({
    this.id = const Value.absent(),
    required int classId,
    required int subjectId,
    required int teacherId,
    required int assignedHours,
  }) : classId = Value(classId),
       subjectId = Value(subjectId),
       teacherId = Value(teacherId),
       assignedHours = Value(assignedHours);
  static Insertable<Allocation> custom({
    Expression<int>? id,
    Expression<int>? classId,
    Expression<int>? subjectId,
    Expression<int>? teacherId,
    Expression<int>? assignedHours,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (classId != null) 'class_id': classId,
      if (subjectId != null) 'subject_id': subjectId,
      if (teacherId != null) 'teacher_id': teacherId,
      if (assignedHours != null) 'assigned_hours': assignedHours,
    });
  }

  AllocationsCompanion copyWith({
    Value<int>? id,
    Value<int>? classId,
    Value<int>? subjectId,
    Value<int>? teacherId,
    Value<int>? assignedHours,
  }) {
    return AllocationsCompanion(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      subjectId: subjectId ?? this.subjectId,
      teacherId: teacherId ?? this.teacherId,
      assignedHours: assignedHours ?? this.assignedHours,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<int>(classId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (teacherId.present) {
      map['teacher_id'] = Variable<int>(teacherId.value);
    }
    if (assignedHours.present) {
      map['assigned_hours'] = Variable<int>(assignedHours.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AllocationsCompanion(')
          ..write('id: $id, ')
          ..write('classId: $classId, ')
          ..write('subjectId: $subjectId, ')
          ..write('teacherId: $teacherId, ')
          ..write('assignedHours: $assignedHours')
          ..write(')'))
        .toString();
  }
}

class $TimetablesTable extends Timetables
    with TableInfo<$TimetablesTable, Timetable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimetablesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _allocationIdMeta = const VerificationMeta(
    'allocationId',
  );
  @override
  late final GeneratedColumn<int> allocationId = GeneratedColumn<int>(
    'allocation_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES allocations (id)',
    ),
  );
  static const VerificationMeta _dayOfWeekMeta = const VerificationMeta(
    'dayOfWeek',
  );
  @override
  late final GeneratedColumn<int> dayOfWeek = GeneratedColumn<int>(
    'day_of_week',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _periodMeta = const VerificationMeta('period');
  @override
  late final GeneratedColumn<int> period = GeneratedColumn<int>(
    'period',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, allocationId, dayOfWeek, period];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'timetables';
  @override
  VerificationContext validateIntegrity(
    Insertable<Timetable> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('allocation_id')) {
      context.handle(
        _allocationIdMeta,
        allocationId.isAcceptableOrUnknown(
          data['allocation_id']!,
          _allocationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_allocationIdMeta);
    }
    if (data.containsKey('day_of_week')) {
      context.handle(
        _dayOfWeekMeta,
        dayOfWeek.isAcceptableOrUnknown(data['day_of_week']!, _dayOfWeekMeta),
      );
    } else if (isInserting) {
      context.missing(_dayOfWeekMeta);
    }
    if (data.containsKey('period')) {
      context.handle(
        _periodMeta,
        period.isAcceptableOrUnknown(data['period']!, _periodMeta),
      );
    } else if (isInserting) {
      context.missing(_periodMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Timetable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Timetable(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      allocationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}allocation_id'],
      )!,
      dayOfWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_of_week'],
      )!,
      period: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}period'],
      )!,
    );
  }

  @override
  $TimetablesTable createAlias(String alias) {
    return $TimetablesTable(attachedDatabase, alias);
  }
}

class Timetable extends DataClass implements Insertable<Timetable> {
  final int id;
  final int allocationId;
  final int dayOfWeek;
  final int period;
  const Timetable({
    required this.id,
    required this.allocationId,
    required this.dayOfWeek,
    required this.period,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['allocation_id'] = Variable<int>(allocationId);
    map['day_of_week'] = Variable<int>(dayOfWeek);
    map['period'] = Variable<int>(period);
    return map;
  }

  TimetablesCompanion toCompanion(bool nullToAbsent) {
    return TimetablesCompanion(
      id: Value(id),
      allocationId: Value(allocationId),
      dayOfWeek: Value(dayOfWeek),
      period: Value(period),
    );
  }

  factory Timetable.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Timetable(
      id: serializer.fromJson<int>(json['id']),
      allocationId: serializer.fromJson<int>(json['allocationId']),
      dayOfWeek: serializer.fromJson<int>(json['dayOfWeek']),
      period: serializer.fromJson<int>(json['period']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'allocationId': serializer.toJson<int>(allocationId),
      'dayOfWeek': serializer.toJson<int>(dayOfWeek),
      'period': serializer.toJson<int>(period),
    };
  }

  Timetable copyWith({
    int? id,
    int? allocationId,
    int? dayOfWeek,
    int? period,
  }) => Timetable(
    id: id ?? this.id,
    allocationId: allocationId ?? this.allocationId,
    dayOfWeek: dayOfWeek ?? this.dayOfWeek,
    period: period ?? this.period,
  );
  Timetable copyWithCompanion(TimetablesCompanion data) {
    return Timetable(
      id: data.id.present ? data.id.value : this.id,
      allocationId: data.allocationId.present
          ? data.allocationId.value
          : this.allocationId,
      dayOfWeek: data.dayOfWeek.present ? data.dayOfWeek.value : this.dayOfWeek,
      period: data.period.present ? data.period.value : this.period,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Timetable(')
          ..write('id: $id, ')
          ..write('allocationId: $allocationId, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('period: $period')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, allocationId, dayOfWeek, period);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Timetable &&
          other.id == this.id &&
          other.allocationId == this.allocationId &&
          other.dayOfWeek == this.dayOfWeek &&
          other.period == this.period);
}

class TimetablesCompanion extends UpdateCompanion<Timetable> {
  final Value<int> id;
  final Value<int> allocationId;
  final Value<int> dayOfWeek;
  final Value<int> period;
  const TimetablesCompanion({
    this.id = const Value.absent(),
    this.allocationId = const Value.absent(),
    this.dayOfWeek = const Value.absent(),
    this.period = const Value.absent(),
  });
  TimetablesCompanion.insert({
    this.id = const Value.absent(),
    required int allocationId,
    required int dayOfWeek,
    required int period,
  }) : allocationId = Value(allocationId),
       dayOfWeek = Value(dayOfWeek),
       period = Value(period);
  static Insertable<Timetable> custom({
    Expression<int>? id,
    Expression<int>? allocationId,
    Expression<int>? dayOfWeek,
    Expression<int>? period,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (allocationId != null) 'allocation_id': allocationId,
      if (dayOfWeek != null) 'day_of_week': dayOfWeek,
      if (period != null) 'period': period,
    });
  }

  TimetablesCompanion copyWith({
    Value<int>? id,
    Value<int>? allocationId,
    Value<int>? dayOfWeek,
    Value<int>? period,
  }) {
    return TimetablesCompanion(
      id: id ?? this.id,
      allocationId: allocationId ?? this.allocationId,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      period: period ?? this.period,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (allocationId.present) {
      map['allocation_id'] = Variable<int>(allocationId.value);
    }
    if (dayOfWeek.present) {
      map['day_of_week'] = Variable<int>(dayOfWeek.value);
    }
    if (period.present) {
      map['period'] = Variable<int>(period.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimetablesCompanion(')
          ..write('id: $id, ')
          ..write('allocationId: $allocationId, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('period: $period')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SchoolClassesTable schoolClasses = $SchoolClassesTable(this);
  late final $SubjectsTable subjects = $SubjectsTable(this);
  late final $TeachersTable teachers = $TeachersTable(this);
  late final $AllocationsTable allocations = $AllocationsTable(this);
  late final $TimetablesTable timetables = $TimetablesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    schoolClasses,
    subjects,
    teachers,
    allocations,
    timetables,
  ];
}

typedef $$SchoolClassesTableCreateCompanionBuilder =
    SchoolClassesCompanion Function({
      Value<int> id,
      required CourseType course,
      required int grade,
      required int classNumber,
      required String className,
      required int weeklyTargetHours,
    });
typedef $$SchoolClassesTableUpdateCompanionBuilder =
    SchoolClassesCompanion Function({
      Value<int> id,
      Value<CourseType> course,
      Value<int> grade,
      Value<int> classNumber,
      Value<String> className,
      Value<int> weeklyTargetHours,
    });

final class $$SchoolClassesTableReferences
    extends
        BaseReferences<_$AppDatabase, $SchoolClassesTable, SchoolClassesData> {
  $$SchoolClassesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$AllocationsTable, List<Allocation>>
  _allocationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.allocations,
    aliasName: $_aliasNameGenerator(
      db.schoolClasses.id,
      db.allocations.classId,
    ),
  );

  $$AllocationsTableProcessedTableManager get allocationsRefs {
    final manager = $$AllocationsTableTableManager(
      $_db,
      $_db.allocations,
    ).filter((f) => f.classId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_allocationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SchoolClassesTableFilterComposer
    extends Composer<_$AppDatabase, $SchoolClassesTable> {
  $$SchoolClassesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CourseType, CourseType, String> get course =>
      $composableBuilder(
        column: $table.course,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get classNumber => $composableBuilder(
    column: $table.classNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get className => $composableBuilder(
    column: $table.className,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weeklyTargetHours => $composableBuilder(
    column: $table.weeklyTargetHours,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> allocationsRefs(
    Expression<bool> Function($$AllocationsTableFilterComposer f) f,
  ) {
    final $$AllocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.allocations,
      getReferencedColumn: (t) => t.classId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllocationsTableFilterComposer(
            $db: $db,
            $table: $db.allocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SchoolClassesTableOrderingComposer
    extends Composer<_$AppDatabase, $SchoolClassesTable> {
  $$SchoolClassesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get course => $composableBuilder(
    column: $table.course,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get classNumber => $composableBuilder(
    column: $table.classNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get className => $composableBuilder(
    column: $table.className,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weeklyTargetHours => $composableBuilder(
    column: $table.weeklyTargetHours,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SchoolClassesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SchoolClassesTable> {
  $$SchoolClassesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CourseType, String> get course =>
      $composableBuilder(column: $table.course, builder: (column) => column);

  GeneratedColumn<int> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<int> get classNumber => $composableBuilder(
    column: $table.classNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get className =>
      $composableBuilder(column: $table.className, builder: (column) => column);

  GeneratedColumn<int> get weeklyTargetHours => $composableBuilder(
    column: $table.weeklyTargetHours,
    builder: (column) => column,
  );

  Expression<T> allocationsRefs<T extends Object>(
    Expression<T> Function($$AllocationsTableAnnotationComposer a) f,
  ) {
    final $$AllocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.allocations,
      getReferencedColumn: (t) => t.classId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.allocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SchoolClassesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SchoolClassesTable,
          SchoolClassesData,
          $$SchoolClassesTableFilterComposer,
          $$SchoolClassesTableOrderingComposer,
          $$SchoolClassesTableAnnotationComposer,
          $$SchoolClassesTableCreateCompanionBuilder,
          $$SchoolClassesTableUpdateCompanionBuilder,
          (SchoolClassesData, $$SchoolClassesTableReferences),
          SchoolClassesData,
          PrefetchHooks Function({bool allocationsRefs})
        > {
  $$SchoolClassesTableTableManager(_$AppDatabase db, $SchoolClassesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SchoolClassesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SchoolClassesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SchoolClassesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<CourseType> course = const Value.absent(),
                Value<int> grade = const Value.absent(),
                Value<int> classNumber = const Value.absent(),
                Value<String> className = const Value.absent(),
                Value<int> weeklyTargetHours = const Value.absent(),
              }) => SchoolClassesCompanion(
                id: id,
                course: course,
                grade: grade,
                classNumber: classNumber,
                className: className,
                weeklyTargetHours: weeklyTargetHours,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required CourseType course,
                required int grade,
                required int classNumber,
                required String className,
                required int weeklyTargetHours,
              }) => SchoolClassesCompanion.insert(
                id: id,
                course: course,
                grade: grade,
                classNumber: classNumber,
                className: className,
                weeklyTargetHours: weeklyTargetHours,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SchoolClassesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({allocationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (allocationsRefs) db.allocations],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (allocationsRefs)
                    await $_getPrefetchedData<
                      SchoolClassesData,
                      $SchoolClassesTable,
                      Allocation
                    >(
                      currentTable: table,
                      referencedTable: $$SchoolClassesTableReferences
                          ._allocationsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SchoolClassesTableReferences(
                            db,
                            table,
                            p0,
                          ).allocationsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.classId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SchoolClassesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SchoolClassesTable,
      SchoolClassesData,
      $$SchoolClassesTableFilterComposer,
      $$SchoolClassesTableOrderingComposer,
      $$SchoolClassesTableAnnotationComposer,
      $$SchoolClassesTableCreateCompanionBuilder,
      $$SchoolClassesTableUpdateCompanionBuilder,
      (SchoolClassesData, $$SchoolClassesTableReferences),
      SchoolClassesData,
      PrefetchHooks Function({bool allocationsRefs})
    >;
typedef $$SubjectsTableCreateCompanionBuilder =
    SubjectsCompanion Function({
      Value<int> id,
      required CourseType course,
      required int grade,
      required String subjectName,
      required int weeklyTargetHours,
    });
typedef $$SubjectsTableUpdateCompanionBuilder =
    SubjectsCompanion Function({
      Value<int> id,
      Value<CourseType> course,
      Value<int> grade,
      Value<String> subjectName,
      Value<int> weeklyTargetHours,
    });

final class $$SubjectsTableReferences
    extends BaseReferences<_$AppDatabase, $SubjectsTable, Subject> {
  $$SubjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AllocationsTable, List<Allocation>>
  _allocationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.allocations,
    aliasName: $_aliasNameGenerator(db.subjects.id, db.allocations.subjectId),
  );

  $$AllocationsTableProcessedTableManager get allocationsRefs {
    final manager = $$AllocationsTableTableManager(
      $_db,
      $_db.allocations,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_allocationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SubjectsTableFilterComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CourseType, CourseType, String> get course =>
      $composableBuilder(
        column: $table.course,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subjectName => $composableBuilder(
    column: $table.subjectName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weeklyTargetHours => $composableBuilder(
    column: $table.weeklyTargetHours,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> allocationsRefs(
    Expression<bool> Function($$AllocationsTableFilterComposer f) f,
  ) {
    final $$AllocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.allocations,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllocationsTableFilterComposer(
            $db: $db,
            $table: $db.allocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get course => $composableBuilder(
    column: $table.course,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subjectName => $composableBuilder(
    column: $table.subjectName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weeklyTargetHours => $composableBuilder(
    column: $table.weeklyTargetHours,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SubjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CourseType, String> get course =>
      $composableBuilder(column: $table.course, builder: (column) => column);

  GeneratedColumn<int> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<String> get subjectName => $composableBuilder(
    column: $table.subjectName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get weeklyTargetHours => $composableBuilder(
    column: $table.weeklyTargetHours,
    builder: (column) => column,
  );

  Expression<T> allocationsRefs<T extends Object>(
    Expression<T> Function($$AllocationsTableAnnotationComposer a) f,
  ) {
    final $$AllocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.allocations,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.allocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubjectsTable,
          Subject,
          $$SubjectsTableFilterComposer,
          $$SubjectsTableOrderingComposer,
          $$SubjectsTableAnnotationComposer,
          $$SubjectsTableCreateCompanionBuilder,
          $$SubjectsTableUpdateCompanionBuilder,
          (Subject, $$SubjectsTableReferences),
          Subject,
          PrefetchHooks Function({bool allocationsRefs})
        > {
  $$SubjectsTableTableManager(_$AppDatabase db, $SubjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<CourseType> course = const Value.absent(),
                Value<int> grade = const Value.absent(),
                Value<String> subjectName = const Value.absent(),
                Value<int> weeklyTargetHours = const Value.absent(),
              }) => SubjectsCompanion(
                id: id,
                course: course,
                grade: grade,
                subjectName: subjectName,
                weeklyTargetHours: weeklyTargetHours,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required CourseType course,
                required int grade,
                required String subjectName,
                required int weeklyTargetHours,
              }) => SubjectsCompanion.insert(
                id: id,
                course: course,
                grade: grade,
                subjectName: subjectName,
                weeklyTargetHours: weeklyTargetHours,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SubjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({allocationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (allocationsRefs) db.allocations],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (allocationsRefs)
                    await $_getPrefetchedData<
                      Subject,
                      $SubjectsTable,
                      Allocation
                    >(
                      currentTable: table,
                      referencedTable: $$SubjectsTableReferences
                          ._allocationsRefsTable(db),
                      managerFromTypedResult: (p0) => $$SubjectsTableReferences(
                        db,
                        table,
                        p0,
                      ).allocationsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.subjectId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SubjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubjectsTable,
      Subject,
      $$SubjectsTableFilterComposer,
      $$SubjectsTableOrderingComposer,
      $$SubjectsTableAnnotationComposer,
      $$SubjectsTableCreateCompanionBuilder,
      $$SubjectsTableUpdateCompanionBuilder,
      (Subject, $$SubjectsTableReferences),
      Subject,
      PrefetchHooks Function({bool allocationsRefs})
    >;
typedef $$TeachersTableCreateCompanionBuilder =
    TeachersCompanion Function({
      Value<int> id,
      required String name,
      required int weeklyTargetHours,
      required bool isHomeroom,
    });
typedef $$TeachersTableUpdateCompanionBuilder =
    TeachersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> weeklyTargetHours,
      Value<bool> isHomeroom,
    });

final class $$TeachersTableReferences
    extends BaseReferences<_$AppDatabase, $TeachersTable, Teacher> {
  $$TeachersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AllocationsTable, List<Allocation>>
  _allocationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.allocations,
    aliasName: $_aliasNameGenerator(db.teachers.id, db.allocations.teacherId),
  );

  $$AllocationsTableProcessedTableManager get allocationsRefs {
    final manager = $$AllocationsTableTableManager(
      $_db,
      $_db.allocations,
    ).filter((f) => f.teacherId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_allocationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TeachersTableFilterComposer
    extends Composer<_$AppDatabase, $TeachersTable> {
  $$TeachersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weeklyTargetHours => $composableBuilder(
    column: $table.weeklyTargetHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isHomeroom => $composableBuilder(
    column: $table.isHomeroom,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> allocationsRefs(
    Expression<bool> Function($$AllocationsTableFilterComposer f) f,
  ) {
    final $$AllocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.allocations,
      getReferencedColumn: (t) => t.teacherId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllocationsTableFilterComposer(
            $db: $db,
            $table: $db.allocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TeachersTableOrderingComposer
    extends Composer<_$AppDatabase, $TeachersTable> {
  $$TeachersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weeklyTargetHours => $composableBuilder(
    column: $table.weeklyTargetHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isHomeroom => $composableBuilder(
    column: $table.isHomeroom,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TeachersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeachersTable> {
  $$TeachersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get weeklyTargetHours => $composableBuilder(
    column: $table.weeklyTargetHours,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isHomeroom => $composableBuilder(
    column: $table.isHomeroom,
    builder: (column) => column,
  );

  Expression<T> allocationsRefs<T extends Object>(
    Expression<T> Function($$AllocationsTableAnnotationComposer a) f,
  ) {
    final $$AllocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.allocations,
      getReferencedColumn: (t) => t.teacherId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.allocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TeachersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeachersTable,
          Teacher,
          $$TeachersTableFilterComposer,
          $$TeachersTableOrderingComposer,
          $$TeachersTableAnnotationComposer,
          $$TeachersTableCreateCompanionBuilder,
          $$TeachersTableUpdateCompanionBuilder,
          (Teacher, $$TeachersTableReferences),
          Teacher,
          PrefetchHooks Function({bool allocationsRefs})
        > {
  $$TeachersTableTableManager(_$AppDatabase db, $TeachersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeachersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeachersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeachersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> weeklyTargetHours = const Value.absent(),
                Value<bool> isHomeroom = const Value.absent(),
              }) => TeachersCompanion(
                id: id,
                name: name,
                weeklyTargetHours: weeklyTargetHours,
                isHomeroom: isHomeroom,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int weeklyTargetHours,
                required bool isHomeroom,
              }) => TeachersCompanion.insert(
                id: id,
                name: name,
                weeklyTargetHours: weeklyTargetHours,
                isHomeroom: isHomeroom,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TeachersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({allocationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (allocationsRefs) db.allocations],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (allocationsRefs)
                    await $_getPrefetchedData<
                      Teacher,
                      $TeachersTable,
                      Allocation
                    >(
                      currentTable: table,
                      referencedTable: $$TeachersTableReferences
                          ._allocationsRefsTable(db),
                      managerFromTypedResult: (p0) => $$TeachersTableReferences(
                        db,
                        table,
                        p0,
                      ).allocationsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.teacherId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TeachersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeachersTable,
      Teacher,
      $$TeachersTableFilterComposer,
      $$TeachersTableOrderingComposer,
      $$TeachersTableAnnotationComposer,
      $$TeachersTableCreateCompanionBuilder,
      $$TeachersTableUpdateCompanionBuilder,
      (Teacher, $$TeachersTableReferences),
      Teacher,
      PrefetchHooks Function({bool allocationsRefs})
    >;
typedef $$AllocationsTableCreateCompanionBuilder =
    AllocationsCompanion Function({
      Value<int> id,
      required int classId,
      required int subjectId,
      required int teacherId,
      required int assignedHours,
    });
typedef $$AllocationsTableUpdateCompanionBuilder =
    AllocationsCompanion Function({
      Value<int> id,
      Value<int> classId,
      Value<int> subjectId,
      Value<int> teacherId,
      Value<int> assignedHours,
    });

final class $$AllocationsTableReferences
    extends BaseReferences<_$AppDatabase, $AllocationsTable, Allocation> {
  $$AllocationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SchoolClassesTable _classIdTable(_$AppDatabase db) =>
      db.schoolClasses.createAlias(
        $_aliasNameGenerator(db.allocations.classId, db.schoolClasses.id),
      );

  $$SchoolClassesTableProcessedTableManager get classId {
    final $_column = $_itemColumn<int>('class_id')!;

    final manager = $$SchoolClassesTableTableManager(
      $_db,
      $_db.schoolClasses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_classIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias(
        $_aliasNameGenerator(db.allocations.subjectId, db.subjects.id),
      );

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<int>('subject_id')!;

    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TeachersTable _teacherIdTable(_$AppDatabase db) =>
      db.teachers.createAlias(
        $_aliasNameGenerator(db.allocations.teacherId, db.teachers.id),
      );

  $$TeachersTableProcessedTableManager get teacherId {
    final $_column = $_itemColumn<int>('teacher_id')!;

    final manager = $$TeachersTableTableManager(
      $_db,
      $_db.teachers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teacherIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TimetablesTable, List<Timetable>>
  _timetablesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.timetables,
    aliasName: $_aliasNameGenerator(
      db.allocations.id,
      db.timetables.allocationId,
    ),
  );

  $$TimetablesTableProcessedTableManager get timetablesRefs {
    final manager = $$TimetablesTableTableManager(
      $_db,
      $_db.timetables,
    ).filter((f) => f.allocationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_timetablesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AllocationsTableFilterComposer
    extends Composer<_$AppDatabase, $AllocationsTable> {
  $$AllocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get assignedHours => $composableBuilder(
    column: $table.assignedHours,
    builder: (column) => ColumnFilters(column),
  );

  $$SchoolClassesTableFilterComposer get classId {
    final $$SchoolClassesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.classId,
      referencedTable: $db.schoolClasses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SchoolClassesTableFilterComposer(
            $db: $db,
            $table: $db.schoolClasses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeachersTableFilterComposer get teacherId {
    final $$TeachersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teacherId,
      referencedTable: $db.teachers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeachersTableFilterComposer(
            $db: $db,
            $table: $db.teachers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> timetablesRefs(
    Expression<bool> Function($$TimetablesTableFilterComposer f) f,
  ) {
    final $$TimetablesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timetables,
      getReferencedColumn: (t) => t.allocationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimetablesTableFilterComposer(
            $db: $db,
            $table: $db.timetables,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AllocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $AllocationsTable> {
  $$AllocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get assignedHours => $composableBuilder(
    column: $table.assignedHours,
    builder: (column) => ColumnOrderings(column),
  );

  $$SchoolClassesTableOrderingComposer get classId {
    final $$SchoolClassesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.classId,
      referencedTable: $db.schoolClasses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SchoolClassesTableOrderingComposer(
            $db: $db,
            $table: $db.schoolClasses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeachersTableOrderingComposer get teacherId {
    final $$TeachersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teacherId,
      referencedTable: $db.teachers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeachersTableOrderingComposer(
            $db: $db,
            $table: $db.teachers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AllocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AllocationsTable> {
  $$AllocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get assignedHours => $composableBuilder(
    column: $table.assignedHours,
    builder: (column) => column,
  );

  $$SchoolClassesTableAnnotationComposer get classId {
    final $$SchoolClassesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.classId,
      referencedTable: $db.schoolClasses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SchoolClassesTableAnnotationComposer(
            $db: $db,
            $table: $db.schoolClasses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeachersTableAnnotationComposer get teacherId {
    final $$TeachersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teacherId,
      referencedTable: $db.teachers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeachersTableAnnotationComposer(
            $db: $db,
            $table: $db.teachers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> timetablesRefs<T extends Object>(
    Expression<T> Function($$TimetablesTableAnnotationComposer a) f,
  ) {
    final $$TimetablesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timetables,
      getReferencedColumn: (t) => t.allocationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimetablesTableAnnotationComposer(
            $db: $db,
            $table: $db.timetables,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AllocationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AllocationsTable,
          Allocation,
          $$AllocationsTableFilterComposer,
          $$AllocationsTableOrderingComposer,
          $$AllocationsTableAnnotationComposer,
          $$AllocationsTableCreateCompanionBuilder,
          $$AllocationsTableUpdateCompanionBuilder,
          (Allocation, $$AllocationsTableReferences),
          Allocation,
          PrefetchHooks Function({
            bool classId,
            bool subjectId,
            bool teacherId,
            bool timetablesRefs,
          })
        > {
  $$AllocationsTableTableManager(_$AppDatabase db, $AllocationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AllocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AllocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AllocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> classId = const Value.absent(),
                Value<int> subjectId = const Value.absent(),
                Value<int> teacherId = const Value.absent(),
                Value<int> assignedHours = const Value.absent(),
              }) => AllocationsCompanion(
                id: id,
                classId: classId,
                subjectId: subjectId,
                teacherId: teacherId,
                assignedHours: assignedHours,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int classId,
                required int subjectId,
                required int teacherId,
                required int assignedHours,
              }) => AllocationsCompanion.insert(
                id: id,
                classId: classId,
                subjectId: subjectId,
                teacherId: teacherId,
                assignedHours: assignedHours,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AllocationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                classId = false,
                subjectId = false,
                teacherId = false,
                timetablesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (timetablesRefs) db.timetables],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (classId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.classId,
                                    referencedTable:
                                        $$AllocationsTableReferences
                                            ._classIdTable(db),
                                    referencedColumn:
                                        $$AllocationsTableReferences
                                            ._classIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (subjectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.subjectId,
                                    referencedTable:
                                        $$AllocationsTableReferences
                                            ._subjectIdTable(db),
                                    referencedColumn:
                                        $$AllocationsTableReferences
                                            ._subjectIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (teacherId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.teacherId,
                                    referencedTable:
                                        $$AllocationsTableReferences
                                            ._teacherIdTable(db),
                                    referencedColumn:
                                        $$AllocationsTableReferences
                                            ._teacherIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (timetablesRefs)
                        await $_getPrefetchedData<
                          Allocation,
                          $AllocationsTable,
                          Timetable
                        >(
                          currentTable: table,
                          referencedTable: $$AllocationsTableReferences
                              ._timetablesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AllocationsTableReferences(
                                db,
                                table,
                                p0,
                              ).timetablesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.allocationId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AllocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AllocationsTable,
      Allocation,
      $$AllocationsTableFilterComposer,
      $$AllocationsTableOrderingComposer,
      $$AllocationsTableAnnotationComposer,
      $$AllocationsTableCreateCompanionBuilder,
      $$AllocationsTableUpdateCompanionBuilder,
      (Allocation, $$AllocationsTableReferences),
      Allocation,
      PrefetchHooks Function({
        bool classId,
        bool subjectId,
        bool teacherId,
        bool timetablesRefs,
      })
    >;
typedef $$TimetablesTableCreateCompanionBuilder =
    TimetablesCompanion Function({
      Value<int> id,
      required int allocationId,
      required int dayOfWeek,
      required int period,
    });
typedef $$TimetablesTableUpdateCompanionBuilder =
    TimetablesCompanion Function({
      Value<int> id,
      Value<int> allocationId,
      Value<int> dayOfWeek,
      Value<int> period,
    });

final class $$TimetablesTableReferences
    extends BaseReferences<_$AppDatabase, $TimetablesTable, Timetable> {
  $$TimetablesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AllocationsTable _allocationIdTable(_$AppDatabase db) =>
      db.allocations.createAlias(
        $_aliasNameGenerator(db.timetables.allocationId, db.allocations.id),
      );

  $$AllocationsTableProcessedTableManager get allocationId {
    final $_column = $_itemColumn<int>('allocation_id')!;

    final manager = $$AllocationsTableTableManager(
      $_db,
      $_db.allocations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_allocationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TimetablesTableFilterComposer
    extends Composer<_$AppDatabase, $TimetablesTable> {
  $$TimetablesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnFilters(column),
  );

  $$AllocationsTableFilterComposer get allocationId {
    final $$AllocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.allocationId,
      referencedTable: $db.allocations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllocationsTableFilterComposer(
            $db: $db,
            $table: $db.allocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimetablesTableOrderingComposer
    extends Composer<_$AppDatabase, $TimetablesTable> {
  $$TimetablesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnOrderings(column),
  );

  $$AllocationsTableOrderingComposer get allocationId {
    final $$AllocationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.allocationId,
      referencedTable: $db.allocations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllocationsTableOrderingComposer(
            $db: $db,
            $table: $db.allocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimetablesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimetablesTable> {
  $$TimetablesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dayOfWeek =>
      $composableBuilder(column: $table.dayOfWeek, builder: (column) => column);

  GeneratedColumn<int> get period =>
      $composableBuilder(column: $table.period, builder: (column) => column);

  $$AllocationsTableAnnotationComposer get allocationId {
    final $$AllocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.allocationId,
      referencedTable: $db.allocations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.allocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimetablesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TimetablesTable,
          Timetable,
          $$TimetablesTableFilterComposer,
          $$TimetablesTableOrderingComposer,
          $$TimetablesTableAnnotationComposer,
          $$TimetablesTableCreateCompanionBuilder,
          $$TimetablesTableUpdateCompanionBuilder,
          (Timetable, $$TimetablesTableReferences),
          Timetable,
          PrefetchHooks Function({bool allocationId})
        > {
  $$TimetablesTableTableManager(_$AppDatabase db, $TimetablesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimetablesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimetablesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimetablesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> allocationId = const Value.absent(),
                Value<int> dayOfWeek = const Value.absent(),
                Value<int> period = const Value.absent(),
              }) => TimetablesCompanion(
                id: id,
                allocationId: allocationId,
                dayOfWeek: dayOfWeek,
                period: period,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int allocationId,
                required int dayOfWeek,
                required int period,
              }) => TimetablesCompanion.insert(
                id: id,
                allocationId: allocationId,
                dayOfWeek: dayOfWeek,
                period: period,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TimetablesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({allocationId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (allocationId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.allocationId,
                                referencedTable: $$TimetablesTableReferences
                                    ._allocationIdTable(db),
                                referencedColumn: $$TimetablesTableReferences
                                    ._allocationIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TimetablesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TimetablesTable,
      Timetable,
      $$TimetablesTableFilterComposer,
      $$TimetablesTableOrderingComposer,
      $$TimetablesTableAnnotationComposer,
      $$TimetablesTableCreateCompanionBuilder,
      $$TimetablesTableUpdateCompanionBuilder,
      (Timetable, $$TimetablesTableReferences),
      Timetable,
      PrefetchHooks Function({bool allocationId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SchoolClassesTableTableManager get schoolClasses =>
      $$SchoolClassesTableTableManager(_db, _db.schoolClasses);
  $$SubjectsTableTableManager get subjects =>
      $$SubjectsTableTableManager(_db, _db.subjects);
  $$TeachersTableTableManager get teachers =>
      $$TeachersTableTableManager(_db, _db.teachers);
  $$AllocationsTableTableManager get allocations =>
      $$AllocationsTableTableManager(_db, _db.allocations);
  $$TimetablesTableTableManager get timetables =>
      $$TimetablesTableTableManager(_db, _db.timetables);
}
