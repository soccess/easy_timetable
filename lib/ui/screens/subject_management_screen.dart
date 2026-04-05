import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/database_providers.dart';
import '../../database/app_database.dart';
import '../../models/course_type.dart';
import '../../theme/app_colors.dart';
import '../components/cute_card.dart';

class SubjectManagementScreen extends ConsumerStatefulWidget {
  const SubjectManagementScreen({super.key});

  @override
  ConsumerState<SubjectManagementScreen> createState() => _SubjectManagementScreenState();
}

class _SubjectManagementScreenState extends ConsumerState<SubjectManagementScreen> {
  final TextEditingController _subjectNameController = TextEditingController();
  CourseType _selectedCourse = CourseType.middle;
  int _grade = 1;
  int _weeklyHours = 3;

  final Set<int> _selectedSubjectIds = {};

  @override
  void dispose() {
    _subjectNameController.dispose();
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

  void _showBatchCopyPopup(List<Subject> allSubjects) {
    if (_selectedSubjectIds.isEmpty) return;

    final selectedSubjects = allSubjects.where((s) => _selectedSubjectIds.contains(s.id)).toList();

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return _BatchCopyDialog(selectedSubjects: selectedSubjects);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final subjectsAsync = ref.watch(subjectsProvider);

    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left form
          SizedBox(
            width: 350,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: CuteCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Semantics(
                      label: '새 과목 생성 양식',
                      child: Text(
                        '새 과목 생성',
                        style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Semantics(
                      label: '과정 선택 버튼, 현재 ${_selectedCourse.name}',
                      button: true,
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: _showCoursePicker,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('과정: ${_selectedCourse.name}'),
                            const SizedBox(width: 8),
                            const Icon(CupertinoIcons.chevron_down, size: 16),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text('학년: '),
                        Semantics(
                          label: '학년 선택, 현재 $_grade학년',
                          value: '$_grade',
                          child: Row(
                            children: [
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: _grade > _selectedCourse.minGrade ? () => setState(() => _grade--) : null,
                                child: const ExcludeSemantics(child: Icon(CupertinoIcons.minus_circle)),
                              ),
                              SizedBox(width: 40, child: Center(child: Text('$_grade'))),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: _grade < _selectedCourse.maxGrade ? () => setState(() => _grade++) : null,
                                child: const ExcludeSemantics(child: Icon(CupertinoIcons.add_circled)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Semantics(
                      label: '과목명 입력 필드',
                      child: CupertinoTextField(
                        controller: _subjectNameController,
                        placeholder: '과목명 입력',
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text('주당 시수: '),
                        Semantics(
                          label: '주당 시수 선택, 현재 $_weeklyHours시간',
                          value: '$_weeklyHours',
                          child: Row(
                            children: [
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: _weeklyHours > 1 ? () => setState(() => _weeklyHours--) : null,
                                child: const ExcludeSemantics(child: Icon(CupertinoIcons.minus_circle)),
                              ),
                              SizedBox(width: 40, child: Center(child: Text('$_weeklyHours'))),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: _weeklyHours < 40 ? () => setState(() => _weeklyHours++) : null,
                                child: const ExcludeSemantics(child: Icon(CupertinoIcons.add_circled)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoButton(
                        color: AppColors.pastelMint,
                        borderRadius: BorderRadius.circular(20),
                        onPressed: () async {
                          if (_subjectNameController.text.isEmpty) return;
                          final db = ref.read(databaseProvider);
                          await db.into(db.subjects).insert(
                            SubjectsCompanion.insert(
                              course: _selectedCourse,
                              grade: _grade,
                              subjectName: _subjectNameController.text,
                              weeklyTargetHours: _weeklyHours,
                            ),
                          );
                          _subjectNameController.clear();
                        },
                        child: const Semantics(
                          label: '과목 추가 버튼',
                          button: true,
                          child: Text(
                            '과목 추가',
                            style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Right list
          Expanded(
            child: subjectsAsync.when(
              data: (subjects) {
                final groupedSubjects = <String, List<Subject>>{};
                for (final s in subjects) {
                  final key = '${s.course.name} ${s.grade}학년';
                  if (!groupedSubjects.containsKey(key)) {
                    groupedSubjects[key] = [];
                  }
                  groupedSubjects[key]!.add(s);
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('등록된 과목', style: CupertinoTheme.of(context).textTheme.navTitleTextStyle),
                          if (_selectedSubjectIds.isNotEmpty)
                            Semantics(
                              label: '선택된 ${_selectedSubjectIds.length}개의 과목 일괄 복사',
                              button: true,
                              child: CupertinoButton(
                                color: AppColors.babyPink,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                onPressed: () => _showBatchCopyPopup(subjects),
                                child: const Text('과목 일괄 복사', style: TextStyle(color: AppColors.textPrimary)),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: subjects.isEmpty
                          ? const Center(child: Text('등록된 과목이 없습니다.'))
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: groupedSubjects.length,
                              itemBuilder: (context, index) {
                                final key = groupedSubjects.keys.elementAt(index);
                                final list = groupedSubjects[key]!;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(key, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 10),
                                    Wrap(
                                      spacing: 12,
                                      runSpacing: 12,
                                      children: list.map((s) {
                                        final isSelected = _selectedSubjectIds.contains(s.id);
                                        return CuteCard(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                          color: isSelected ? AppColors.pastelMint : AppColors.softLavender,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Semantics(
                                                label: '${s.subjectName} 선택',
                                                checked: isSelected,
                                                child: CupertinoButton(
                                                  padding: EdgeInsets.zero,
                                                  minSize: 0,
                                                  onPressed: () {
                                                    setState(() {
                                                      if (isSelected) {
                                                        _selectedSubjectIds.remove(s.id);
                                                      } else {
                                                        _selectedSubjectIds.add(s.id);
                                                      }
                                                    });
                                                  },
                                                  child: Icon(
                                                    isSelected ? CupertinoIcons.checkmark_square_fill : CupertinoIcons.square,
                                                    color: AppColors.textPrimary,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                '${s.subjectName}(${s.weeklyTargetHours})',
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(width: 8),
                                              Semantics(
                                                label: '${s.subjectName} 삭제',
                                                button: true,
                                                child: CupertinoButton(
                                                  padding: EdgeInsets.zero,
                                                  minSize: 0,
                                                  onPressed: () {
                                                    final db = ref.read(databaseProvider);
                                                    db.delete(db.subjects).delete(s);
                                                    setState(() {
                                                      _selectedSubjectIds.remove(s.id);
                                                    });
                                                  },
                                                  child: const Icon(CupertinoIcons.trash, color: CupertinoColors.destructiveRed, size: 20),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CupertinoActivityIndicator()),
              error: (e, st) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}

class _BatchCopyDialog extends ConsumerStatefulWidget {
  final List<Subject> selectedSubjects;

  const _BatchCopyDialog({required this.selectedSubjects});

  @override
  ConsumerState<_BatchCopyDialog> createState() => _BatchCopyDialogState();
}

class _BatchCopyDialogState extends ConsumerState<_BatchCopyDialog> {
  final Set<String> _selectedTargets = {};

  late final List<String> _allTargets;

  @override
  void initState() {
    super.initState();
    _allTargets = [];
    for (var course in CourseType.values) {
      for (int g = course.minGrade; g <= course.maxGrade; g++) {
        _allTargets.add('${course.name} $g학년');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('과목 일괄 복사'),
      content: SizedBox(
        width: 300,
        height: 400,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text('선택된 과목: ${widget.selectedSubjects.map((e) => e.subjectName).join(', ')}'),
            const SizedBox(height: 10),
            const Text('복사할 대상을 선택하세요:'),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _allTargets.length,
                itemBuilder: (context, index) {
                  final target = _allTargets[index];
                  final isSelected = _selectedTargets.contains(target);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedTargets.remove(target);
                        } else {
                          _selectedTargets.add(target);
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Icon(isSelected ? CupertinoIcons.checkmark_square_fill : CupertinoIcons.square),
                          const SizedBox(width: 8),
                          Text(target),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () async {
            final db = ref.read(databaseProvider);
            final currentSubjects = await db.select(db.subjects).get();

            for (final target in _selectedTargets) {
              final parts = target.split(' ');
              final courseName = parts[0];
              final gradeStr = parts[1].replaceAll('학년', '');
              final grade = int.parse(gradeStr);

              final course = CourseType.values.firstWhere((c) => c.name == courseName);

              for (final subjectToCopy in widget.selectedSubjects) {
                // Check if identical subject already exists in target
                final exists = currentSubjects.any((s) =>
                  s.course == course &&
                  s.grade == grade &&
                  s.subjectName == subjectToCopy.subjectName
                );

                if (!exists) {
                  await db.into(db.subjects).insert(
                    SubjectsCompanion.insert(
                      course: course,
                      grade: grade,
                      subjectName: subjectToCopy.subjectName,
                      weeklyTargetHours: subjectToCopy.weeklyTargetHours,
                    )
                  );
                }
              }
            }
            if (context.mounted) Navigator.pop(context);
          },
          child: const Text('복사 실행'),
        ),
      ],
    );
  }
}
