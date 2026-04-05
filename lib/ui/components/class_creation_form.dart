import 'package:flutter/cupertino.dart';
import '../../models/course_type.dart';
import '../../utils/class_name_generator.dart';
import '../../theme/app_colors.dart';
import 'cute_card.dart';

class ClassCreationForm extends StatefulWidget {
  const ClassCreationForm({super.key});

  @override
  State<ClassCreationForm> createState() => _ClassCreationFormState();
}

class _ClassCreationFormState extends State<ClassCreationForm> {
  CourseType _selectedCourse = CourseType.middle;
  int _grade = 2;
  int _classNumber = 1;

  final FocusNode _gradeFocus = FocusNode();
  final FocusNode _classNumberFocus = FocusNode();
  final FocusNode _submitFocus = FocusNode();

  @override
  void dispose() {
    _gradeFocus.dispose();
    _classNumberFocus.dispose();
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
                child: Text(CourseType.values[index].name),
              );
            }),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final generatedName = generateClassName(_selectedCourse, _grade, _classNumber);

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
            label: '과정 선택 버튼, 현재 $_selectedCourse',
            button: true,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _showCoursePicker,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('과정: ${_selectedCourse.name}'),
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
              Semantics(
                label: '학년 선택, 현재 $_grade학년',
                value: '$_grade',
                child: CupertinoStepper(
                  value: _grade.toDouble(),
                  min: _selectedCourse.minGrade.toDouble(),
                  max: _selectedCourse.maxGrade.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      _grade = value.toInt();
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('반: '),
              Semantics(
                label: '반 선택, 현재 $_classNumber반',
                value: '$_classNumber',
                child: CupertinoStepper(
                  value: _classNumber.toDouble(),
                  min: 1,
                  max: 20,
                  onChanged: (value) {
                    setState(() {
                      _classNumber = value.toInt();
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.softLavender.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const ExcludeSemantics(
                  child: Icon(CupertinoIcons.info_circle, color: AppColors.textSecondary),
                ),
                const SizedBox(width: 12),
                Semantics(
                  label: '생성될 학급 이름',
                  value: generatedName,
                  child: Text(
                    '미리보기: $generatedName',
                    style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: AppColors.pastelMint,
              borderRadius: BorderRadius.circular(20),
              onPressed: () {
                // TODO: Save logic
              },
              child: Semantics(
                label: '$generatedName 학급 추가하기',
                button: true,
                child: Text(
                  '학급 추가',
                  style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Simple CupertinoStepper implementation since it's not built-in to Cupertino by default
class CupertinoStepper extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const CupertinoStepper({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: value > min ? () => onChanged(value - 1) : null,
          child: const ExcludeSemantics(child: Icon(CupertinoIcons.minus_circle)),
        ),
        SizedBox(
          width: 40,
          child: Center(
            child: Text(value.toInt().toString()),
          ),
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: value < max ? () => onChanged(value + 1) : null,
          child: const ExcludeSemantics(child: Icon(CupertinoIcons.add_circled)),
        ),
      ],
    );
  }
}
