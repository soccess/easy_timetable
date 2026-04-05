import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/database_providers.dart';
import '../../theme/app_colors.dart';
import '../components/class_creation_form.dart';
import '../components/cute_card.dart';

class ClassManagementScreen extends StatelessWidget {
  const ClassManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 350,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: ClassCreationForm(),
            ),
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final classesAsync = ref.watch(schoolClassesProvider);

                return classesAsync.when(
                  data: (classes) {
                    if (classes.isEmpty) {
                      return const Center(child: Text('등록된 학급이 없습니다.'));
                    }

                    // Group classes by course and grade
                    final groupedClasses = <String, List<dynamic>>{};
                    for (final c in classes) {
                      final key = '${c.course.displayName} ${c.grade}학년 (${c.weeklyTargetHours}시간)';
                      if (!groupedClasses.containsKey(key)) {
                        groupedClasses[key] = [];
                      }
                      groupedClasses[key]!.add(c);
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: groupedClasses.length,
                      itemBuilder: (context, index) {
                        final key = groupedClasses.keys.elementAt(index);
                        final classList = groupedClasses[key]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              key,
                              style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: classList.map((c) {
                                return CuteCard(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  color: AppColors.softLavender,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        c.className,
                                        style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const SizedBox(width: 12),
                                      CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        minSize: 0,
                                        onPressed: () {
                                          final db = ref.read(databaseProvider);
                                          db.delete(db.schoolClasses).delete(c);
                                        },
                                        child: const Icon(
                                          CupertinoIcons.trash,
                                          color: CupertinoColors.destructiveRed,
                                          size: 20,
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
                    );
                  },
                  loading: () => const Center(child: CupertinoActivityIndicator()),
                  error: (e, st) => Center(child: Text('Error: $e')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
