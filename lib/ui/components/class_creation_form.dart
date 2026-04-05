import 'package:flutter/cupertino.dart';
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

  void _showCoursePicker() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 250,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoPicker(
            magnification: 1.22,
            squeeze: 1.2,
            useMagnifier: true,
            itemExtent: 32.0,
            onSelectedItemChanged: (int selectedItem) {
              setState(() {
                _selectedCourse = CourseType.values[selectedItem];
                // Reset grade if it exceeds new course max
                if (_grade > _selectedCourse.maxGrade) {
                  _grade = _selectedCourse.maxGrade;
                }
              });
            },
            children: List<Widget>.generate(CourseType.values.length, (int index) {
              return Center(
                child: Text(CourseType.values[index].displayName),
              );
            }),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CuteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '새 학급 생성',
            style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
            semanticsLabel: '새 학급 생성 양식',
          ),
          const SizedBox(height: 20),
          Semantics(
            label: '과정 선택 버튼, 현재 ${_selectedCourse.displayName}',
            button: true,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _showCoursePicker,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('과정: ${_selectedCourse.displayName}'),
                  const SizedBox(width: 8),
                  const ExcludeSemantics(child: Icon(CupertinoIcons.chevron_down, size: 16)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('학년: '),
              CupertinoStepper(
                semanticLabel: '학년 선택',
                suffix: '학년',
                value: _grade.toDouble(),
                min: _selectedCourse.minGrade.toDouble(),
                max: _selectedCourse.maxGrade.toDouble(),
                onChanged: (value) {
                  setState(() {
                    _grade = value.toInt();
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('생성할 반 개수: '),
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
              Text('주당 시수: '),
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

