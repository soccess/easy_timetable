import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/database_providers.dart';
import '../../database/app_database.dart';
import '../../theme/app_colors.dart';
import '../components/cute_card.dart';

class TimeAllocationScreen extends ConsumerStatefulWidget {
  const TimeAllocationScreen({super.key});

  @override
  ConsumerState<TimeAllocationScreen> createState() => _TimeAllocationScreenState();
}

class _TimeAllocationScreenState extends ConsumerState<TimeAllocationScreen> {
  Subject? _selectedSubject;
  final List<Teacher> _selectedTeachers = [];

  void _showSubjectPicker(List<Subject> subjects) {
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
                _selectedSubject = subjects[selectedItem];
                _selectedTeachers.clear();
              });
            },
            children: List<Widget>.generate(subjects.length, (int index) {
              final s = subjects[index];
              return Center(
                child: Text('${s.course.displayName} ${s.grade}학년 ${s.subjectName}'),
              );
            }),
          ),
        ),
      ),
    );
  }

  void _showTeacherPicker(List<Teacher> allTeachers) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('교사 추가'),
          content: SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: allTeachers.length,
              itemBuilder: (context, index) {
                final t = allTeachers[index];
                return CupertinoButton(
                  child: Text(t.name),
                  onPressed: () {
                    if (!_selectedTeachers.any((teacher) => teacher.id == t.id)) {
                      setState(() {
                        _selectedTeachers.add(t);
                      });
                    }
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final subjectsAsync = ref.watch(subjectsProvider);
    final classesAsync = ref.watch(schoolClassesProvider);
    final teachersAsync = ref.watch(teachersProvider);
    final allocationsAsync = ref.watch(allocationsProvider);

    if (subjectsAsync.isLoading || classesAsync.isLoading || teachersAsync.isLoading || allocationsAsync.isLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }

    final allSubjects = subjectsAsync.value ?? [];
    final allClasses = classesAsync.value ?? [];
    final allTeachers = teachersAsync.value ?? [];
    final allAllocations = allocationsAsync.value ?? [];

    return SafeArea(
      child: Column(
        children: [
          // Step 1: Subject Picker Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Text('과목 선택: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: AppColors.softLavender,
                  onPressed: allSubjects.isEmpty ? null : () => _showSubjectPicker(allSubjects),
                  child: Text(
                    _selectedSubject != null
                        ? '${_selectedSubject!.course.displayName} ${_selectedSubject!.grade}학년 ${_selectedSubject!.subjectName}'
                        : '과목을 선택하세요',
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 1, color: CupertinoColors.systemGrey4),
          // Main Grid Area
          Expanded(
            child: _selectedSubject == null
                ? const Center(child: Text('과목을 선택하면 배정 화면이 나타납니다.'))
                : _buildGrid(allClasses, allTeachers, allAllocations),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(List<SchoolClassesData> allClasses, List<Teacher> allTeachers, List<Allocation> allAllocations) {
    // Filter classes matching selected subject's course and grade
    final matchingClasses = allClasses
        .where((c) => _selectedSubject != null && c.course == _selectedSubject!.course && c.grade == _selectedSubject!.grade)
        .toList();

    if (matchingClasses.isEmpty) {
      return const Center(child: Text('이 과목에 해당하는 반이 없습니다. 반 관리에서 반을 먼저 생성해주세요.'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row: Blank cell + Teacher Columns + Add Teacher Button
              Row(
                children: [
                  const SizedBox(width: 150), // Empty space for class names column
                  ..._selectedTeachers.map((teacher) {
                    final allocatedToTeacher = allAllocations
                        .where((a) => a.teacherId == teacher.id)
                        .fold(0, (sum, a) => sum + a.assignedHours);
                    final remaining = teacher.weeklyTargetHours - allocatedToTeacher;
                    final isFull = remaining <= 0;

                    return Container(
                      width: 120,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: CuteCard(
                        padding: const EdgeInsets.all(8),
                        color: isFull ? AppColors.babyPink : AppColors.pastelMint,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    teacher.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  minSize: 0,
                                  onPressed: () async {
                                    // Remove all allocations for this teacher and subject before removing them from UI
                                    final db = ref.read(databaseProvider);
                                    final allocationsToDelete = allAllocations.where((a) =>
                                      a.teacherId == teacher.id &&
                                      a.subjectId == _selectedSubject!.id
                                    ).toList();

                                    for (final a in allocationsToDelete) {
                                      await db.delete(db.allocations).delete(a);
                                    }

                                    setState(() {
                                      _selectedTeachers.remove(teacher);
                                    });
                                  },
                                  child: const Icon(CupertinoIcons.clear_thick, size: 16, color: CupertinoColors.destructiveRed),
                                ),
                              ],
                            ),
                            Text('($remaining/${teacher.weeklyTargetHours})', style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 8),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => _showTeacherPicker(allTeachers),
                    child: const Icon(CupertinoIcons.add_circled_solid, size: 36, color: AppColors.textPrimary),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Class Rows
              ...matchingClasses.map((schoolClass) {
                final allocatedToClass = allAllocations
                    .where((a) => a.classId == schoolClass.id && a.subjectId == _selectedSubject!.id)
                    .fold(0, (sum, a) => sum + a.assignedHours);
                final remainingClass = _selectedSubject!.weeklyTargetHours - allocatedToClass;
                final isClassFull = remainingClass <= 0;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      // Class Header Cell
                      SizedBox(
                        width: 150,
                        child: CuteCard(
                          padding: const EdgeInsets.all(12),
                          color: isClassFull ? AppColors.babyPink : AppColors.softLavender,
                          child: Text(
                            '${schoolClass.className}\n($allocatedToClass/${_selectedSubject!.weeklyTargetHours})',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      // Allocation Cells
                      ..._selectedTeachers.map((teacher) {
                        final allocation = allAllocations.where((a) =>
                            a.classId == schoolClass.id &&
                            a.subjectId == _selectedSubject!.id &&
                            a.teacherId == teacher.id).firstOrNull;

                        final assigned = allocation?.assignedHours ?? 0;

                        return Container(
                          width: 120,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          child: Semantics(
                            label: '${schoolClass.className} ${teacher.name} 선생님 시수 입력, 현재 $assigned시간',
                            child: CuteCard(
                              padding: EdgeInsets.zero,
                              color: CupertinoColors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    minSize: 0,
                                    onPressed: assigned > 0 ? () async {
                                      final db = ref.read(databaseProvider);
                                      if (assigned - 1 == 0) {
                                        await db.delete(db.allocations).delete(allocation!);
                                      } else {
                                        await db.update(db.allocations).replace(allocation!.copyWith(assignedHours: assigned - 1));
                                      }
                                    } : null,
                                    child: const Icon(CupertinoIcons.minus_circle),
                                  ),
                                  SizedBox(
                                    width: 30,
                                    child: Center(
                                      child: Text(assigned.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                    ),
                                  ),
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    minSize: 0,
                                    onPressed: remainingClass > 0 ? () async {
                                      final db = ref.read(databaseProvider);
                                      if (allocation == null) {
                                        await db.into(db.allocations).insert(
                                          AllocationsCompanion.insert(
                                            classId: schoolClass.id,
                                            subjectId: _selectedSubject!.id,
                                            teacherId: teacher.id,
                                            assignedHours: 1,
                                          )
                                        );
                                      } else {
                                        await db.update(db.allocations).replace(allocation.copyWith(assignedHours: assigned + 1));
                                      }
                                    } : null,
                                    child: const Icon(CupertinoIcons.add_circled),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
