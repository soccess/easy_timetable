import 'package:flutter/cupertino.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/database_providers.dart';
import '../../database/app_database.dart';
import '../../theme/app_colors.dart';
import '../components/cute_card.dart';

class TimetablePlacementScreen extends ConsumerStatefulWidget {
  const TimetablePlacementScreen({super.key});

  @override
  ConsumerState<TimetablePlacementScreen> createState() => _TimetablePlacementScreenState();
}

class _TimetablePlacementScreenState extends ConsumerState<TimetablePlacementScreen> {
  SchoolClassesData? _selectedClass;
  Teacher? _selectedTeacher;

  final List<String> _days = ['월', '화', '수', '목', '금'];

  @override
  Widget build(BuildContext context) {
    final classesAsync = ref.watch(schoolClassesProvider);
    final teachersAsync = ref.watch(teachersProvider);
    final allocationsAsync = ref.watch(allocationsProvider);
    final timetablesAsync = ref.watch(timetablesProvider);
    final subjectsAsync = ref.watch(subjectsProvider);

    if (classesAsync.isLoading || teachersAsync.isLoading || allocationsAsync.isLoading || timetablesAsync.isLoading || subjectsAsync.isLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }

    final allClasses = classesAsync.value ?? [];
    final allTeachers = teachersAsync.value ?? [];
    final allAllocations = allocationsAsync.value ?? [];
    final allTimetables = timetablesAsync.value ?? [];
    final allSubjects = subjectsAsync.value ?? [];

    if (allClasses.isEmpty) {
      return const Center(child: Text('등록된 학급이 없습니다.'));
    }

    // Default selection
    if (_selectedClass == null && allClasses.isNotEmpty) {
      _selectedClass = allClasses.first;
    }

    return SafeArea(
      child: Column(
        children: [
          // Class Selector Header for Q1
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    final idx = allClasses.indexOf(_selectedClass!);
                    if (idx > 0) {
                      setState(() {
                        _selectedClass = allClasses[idx - 1];
                      });
                    }
                  },
                  child: Semantics(
                    label: '이전 반으로 이동',
                    child: const Icon(CupertinoIcons.left_chevron),
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  _selectedClass?.className ?? '',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    final idx = allClasses.indexOf(_selectedClass!);
                    if (idx < allClasses.length - 1) {
                      setState(() {
                        _selectedClass = allClasses[idx + 1];
                      });
                    }
                  },
                  child: Semantics(
                    label: '다음 반으로 이동',
                    child: const Icon(CupertinoIcons.right_chevron),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                // Left Column (Q1 & Q3)
                Expanded(
                  child: Column(
                    children: [
                      // Q1: Class Timetable
                      Expanded(
                        flex: 2,
                        child: _buildClassTimetable(allTimetables, allAllocations, allSubjects, allTeachers),
                      ),
                      Container(height: 1, color: CupertinoColors.systemGrey4),
                      // Q3: Class Allocation Cards
                      Expanded(
                        flex: 1,
                        child: _buildClassAllocationCards(allAllocations, allSubjects, allTeachers, allTimetables),
                      ),
                    ],
                  ),
                ),
                Container(width: 1, color: CupertinoColors.systemGrey4),
                // Right Column (Q2 & Q4)
                Expanded(
                  child: Column(
                    children: [
                      // Q2: Teacher Timetable
                      Expanded(
                        flex: 2,
                        child: _buildTeacherTimetable(allTimetables, allAllocations, allSubjects, allClasses),
                      ),
                      Container(height: 1, color: CupertinoColors.systemGrey4),
                      // Q4: Teacher Allocation Cards
                      Expanded(
                        flex: 1,
                        child: _buildTeacherAllocationCards(allAllocations, allSubjects, allClasses, allTimetables),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassTimetable(List<Timetable> allTimetables, List<Allocation> allAllocations, List<Subject> allSubjects, List<Teacher> allTeachers) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('반 시간표', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: List.generate(5, (dayIndex) {
                final day = dayIndex + 1;
                return Expanded(
                  child: Column(
                    children: [
                      Text(_days[dayIndex], style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      ...List.generate(7, (periodIndex) {
                        final period = periodIndex + 1;

                        // Find if there's a timetable entry here
                        final timetableEntry = allTimetables.where((t) =>
                          t.dayOfWeek == day &&
                          t.period == period &&
                          allAllocations.any((a) => a.id == t.allocationId && a.classId == _selectedClass!.id)
                        ).firstOrNull;

                        return Expanded(
                          child: DragTarget<Allocation>(
                            onWillAcceptWithDetails: (details) {
                              // Check if cell is empty
                              if (timetableEntry != null) return false;
                              // Check if teacher is already busy at this time
                              final teacherId = details.data.teacherId;
                              final teacherBusy = allTimetables.any((t) =>
                                t.dayOfWeek == day &&
                                t.period == period &&
                                allAllocations.any((a) => a.id == t.allocationId && a.teacherId == teacherId)
                              );
                              return !teacherBusy;
                            },
                            onAcceptWithDetails: (details) async {
                              final db = ref.read(databaseProvider);
                              await db.into(db.timetables).insert(
                                TimetablesCompanion.insert(
                                  allocationId: details.data.id,
                                  dayOfWeek: day,
                                  period: period,
                                )
                              );

                              if (context.mounted) {
                                final allocation = allAllocations.firstWhere((a) => a.id == details.data.id);
                                final subject = allSubjects.firstWhere((s) => s.id == allocation.subjectId);
                                final teacher = allTeachers.firstWhere((t) => t.id == allocation.teacherId);
                                final usedHours = allTimetables.where((t) => t.allocationId == allocation.id).length;
                                final remainingHours = allocation.assignedHours - usedHours - 1; // -1 for the one just added
                                SemanticsService.announce(
                                  '${subject.subjectName} ${teacher.name}, ${_days[dayIndex]}요일 $period교시에 배치됨. 남은 시수 $remainingHours시간',
                                  TextDirection.ltr,
                                );
                              }
                            },
                            builder: (context, candidateData, rejectedData) {
                              if (timetableEntry != null) {
                                final allocation = allAllocations.where((a) => a.id == timetableEntry.allocationId).firstOrNull;
                                final subject = allocation != null ? allSubjects.where((s) => s.id == allocation.subjectId).firstOrNull : null;
                                final teacher = allocation != null ? allTeachers.where((t) => t.id == allocation.teacherId).firstOrNull : null;

                                if (allocation == null || subject == null || teacher == null) return const SizedBox.shrink();

                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedTeacher = teacher;
                                      });
                                    },
                                    child: Semantics(
                                      label: '${_days[dayIndex]}요일 $period교시, ${subject.subjectName} ${teacher.name}',
                                      child: CuteCard(
                                        padding: const EdgeInsets.all(4),
                                        color: AppColors.pastelMint,
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Text(
                                                '${subject.subjectName}\n${teacher.name}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            Positioned(
                                              right: -10,
                                              top: -10,
                                              child: CupertinoButton(
                                                padding: EdgeInsets.zero,
                                                minSize: 0,
                                                onPressed: () async {
                                                  final db = ref.read(databaseProvider);
                                                  await db.delete(db.timetables).delete(timetableEntry);
                                                },
                                                child: const Icon(CupertinoIcons.clear_thick, size: 14, color: CupertinoColors.destructiveRed),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }

                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Semantics(
                                  label: '${_days[dayIndex]}요일 $period교시, 빈 칸',
                                  child: CuteCard(
                                    padding: EdgeInsets.zero,
                                    color: candidateData.isNotEmpty ? AppColors.babyPink : CupertinoColors.systemGrey5,
                                    child: const Center(child: Text('')),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClassAllocationCards(List<Allocation> allAllocations, List<Subject> allSubjects, List<Teacher> allTeachers, List<Timetable> allTimetables) {
    if (_selectedClass == null) return const SizedBox();

    final classAllocations = allAllocations.where((a) => a.classId == _selectedClass!.id).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('배정 대기 카드 (드래그하세요)', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: classAllocations.map((a) {
                final subject = allSubjects.where((s) => s.id == a.subjectId).firstOrNull;
                final teacher = allTeachers.where((t) => t.id == a.teacherId).firstOrNull;

                if (subject == null || teacher == null) return const SizedBox.shrink();

                final usedHours = allTimetables.where((t) => t.allocationId == a.id).length;
                final remainingHours = a.assignedHours - usedHours;

                if (remainingHours <= 0) return const SizedBox.shrink();

                final cardWidget = GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTeacher = teacher;
                    });
                  },
                  child: CuteCard(
                    padding: const EdgeInsets.all(8),
                    color: AppColors.softLavender,
                    child: Text(
                      '${subject.subjectName}\n${teacher.name} $remainingHours',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );

                return Draggable<Allocation>(
                  data: a,
                  feedback: DefaultTextStyle(
                    style: CupertinoTheme.of(context).textTheme.textStyle,
                    child: Opacity(
                      opacity: 0.8,
                      child: cardWidget,
                    ),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.3,
                    child: cardWidget,
                  ),
                  child: Semantics(
                    label: '${subject.subjectName} ${teacher.name}, 남은 시수 $remainingHours시간',
                    child: cardWidget,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTeacherTimetable(List<Timetable> allTimetables, List<Allocation> allAllocations, List<Subject> allSubjects, List<SchoolClassesData> allClasses) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _selectedTeacher == null ? '교사 시간표' : '${_selectedTeacher!.name} 교사 시간표',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: List.generate(5, (dayIndex) {
                final day = dayIndex + 1;
                return Expanded(
                  child: Column(
                    children: [
                      Text(_days[dayIndex], style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      ...List.generate(7, (periodIndex) {
                        final period = periodIndex + 1;

                        // Find if there's a timetable entry here for the selected teacher
                        Timetable? timetableEntry;
                        if (_selectedTeacher != null) {
                          timetableEntry = allTimetables.where((t) =>
                            t.dayOfWeek == day &&
                            t.period == period &&
                            allAllocations.any((a) => a.id == t.allocationId && a.teacherId == _selectedTeacher!.id)
                          ).firstOrNull;
                        }

                        if (timetableEntry != null) {
                          final allocation = allAllocations.where((a) => a.id == timetableEntry!.allocationId).firstOrNull;
                          final subject = allocation != null ? allSubjects.where((s) => s.id == allocation.subjectId).firstOrNull : null;
                          final schoolClass = allocation != null ? allClasses.where((c) => c.id == allocation.classId).firstOrNull : null;

                          if (allocation == null || subject == null || schoolClass == null) return const SizedBox.shrink();

                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedClass = schoolClass;
                                  });
                                },
                                child: CuteCard(
                                  padding: const EdgeInsets.all(4),
                                  color: AppColors.babyPink,
                                  child: Center(
                                    child: Text(
                                      '${subject.subjectName}\n${schoolClass.className}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }

                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CuteCard(
                              padding: EdgeInsets.zero,
                              color: CupertinoColors.systemGrey5,
                              child: const Center(child: Text('')),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTeacherAllocationCards(List<Allocation> allAllocations, List<Subject> allSubjects, List<SchoolClassesData> allClasses, List<Timetable> allTimetables) {
    if (_selectedTeacher == null) {
      return const Center(child: Text('반 시간표에서 카드를 클릭하여\n교사를 선택하세요.', textAlign: TextAlign.center));
    }

    final teacherAllocations = allAllocations.where((a) => a.teacherId == _selectedTeacher!.id).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('교사 배정 현황', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: teacherAllocations.map((a) {
                final subject = allSubjects.where((s) => s.id == a.subjectId).firstOrNull;
                final schoolClass = allClasses.where((c) => c.id == a.classId).firstOrNull;

                if (subject == null || schoolClass == null) return const SizedBox.shrink();

                final usedHours = allTimetables.where((t) => t.allocationId == a.id).length;
                final remainingHours = a.assignedHours - usedHours;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedClass = schoolClass;
                    });
                  },
                  child: CuteCard(
                    padding: const EdgeInsets.all(8),
                    color: remainingHours > 0 ? AppColors.softLavender : CupertinoColors.systemGrey4,
                    child: Text(
                      '${subject.subjectName}\n${schoolClass.className} (잔여: $remainingHours)',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
