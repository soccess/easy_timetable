import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show DropdownButton, DropdownMenuItem, Material, MaterialType;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/course_type.dart';
import '../../utils/class_name_generator.dart';
import '../../theme/app_colors.dart';
import '../../providers/database_providers.dart';
import '../../database/app_database.dart';
import 'cute_card.dart';
import 'cupertino_stepper.dart';

class ClassCreationForm extends StatefulWidget {
  const ClassCreationForm({super.key});

  @override
  State<ClassCreationForm> createState() => _ClassCreationFormState();
}

class _ClassCreationFormState extends State<ClassCreationForm> {
  CourseType _selectedCourse = CourseType.middle;
  int _grade = 1;
  int _classCount = 1;
  int _weeklyHours = 30;

  final FocusNode _gradeFocus = FocusNode();
  final FocusNode _classCountFocus = FocusNode();
  final FocusNode _weeklyHoursFocus = FocusNode();
  final FocusNode _submitFocus = FocusNode();

  @override
  void dispose() {
    _gradeFocus.dispose();
    _classCountFocus.dispose();
    _weeklyHoursFocus.dispose();
    _submitFocus.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return CuteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Semantics(
            header: true,
            child: Text(
              '새 학급 생성',
              style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const ExcludeSemantics(child: Text('과정: ')),
              const SizedBox(width: 8),
              Material(
                type: MaterialType.transparency,
                child: Semantics(
                  label: '과정 선택',
                  child: DropdownButton<CourseType>(
                    value: _selectedCourse,
                    items: CourseType.values.map((CourseType course) {
                      return DropdownMenuItem<CourseType>(
                        value: course,
                        child: Text(course.displayName),
                      );
                    }).toList(),
                    onChanged: (CourseType? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedCourse = newValue;
                          if (_grade > _selectedCourse.maxGrade) {
                            _grade = _selectedCourse.maxGrade;
                          }
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const ExcludeSemantics(child: Text('학년: ')),
              const SizedBox(width: 8),
              Material(
                type: MaterialType.transparency,
                child: Semantics(
                  label: '학년 선택',
                  child: DropdownButton<int>(
                    value: _grade,
                    items: List.generate(_selectedCourse.maxGrade, (index) => index + 1).map((int g) {
                      return DropdownMenuItem<int>(
                        value: g,
                        child: Text('$g학년'),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _grade = newValue;
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const ExcludeSemantics(child: Text('생성할 반 개수: ')),
              CupertinoStepper(
                semanticLabel: '생성할 반 개수',
                suffix: '개',
                value: _classCount.toDouble(),
                min: 1,
                max: 20,
                onChanged: (value) {
                  setState(() {
                    _classCount = value.toInt();
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const ExcludeSemantics(child: Text('주당 시수: ')),
              CupertinoStepper(
                semanticLabel: '주당 시수',
                suffix: '시간',
                value: _weeklyHours.toDouble(),
                min: 1,
                max: 40,
                onChanged: (value) {
                  setState(() {
                    _weeklyHours = value.toInt();
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: Consumer(
              builder: (context, ref, child) {
                return CupertinoButton(
                  color: AppColors.pastelMint,
                  borderRadius: BorderRadius.circular(20),
                  onPressed: () async {
                    final db = ref.read(databaseProvider);
                    for (int i = 1; i <= _classCount; i++) {
                      final generatedName = generateClassName(_selectedCourse, _grade, i);
                      await db.into(db.schoolClasses).insert(
                        SchoolClassesCompanion.insert(
                          course: _selectedCourse,
                          grade: _grade,
                          classNumber: i,
                          className: generatedName,
                          weeklyTargetHours: _weeklyHours,
                        ),
                      );
                    }
                  },
                  child: Semantics(
                    label: '${_selectedCourse.name} $_grade학년 $_classCount개 학급 추가하기',
                    button: true,
                    child: Text(
                      '학급 추가',
                      style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

