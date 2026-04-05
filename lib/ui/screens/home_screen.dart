import 'package:flutter/cupertino.dart';
import '../../theme/app_colors.dart';
import 'class_management_screen.dart';
import 'subject_management_screen.dart';
import 'teacher_management_screen.dart';
import 'time_allocation_screen.dart';
import 'timetable_placement_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    ClassManagementScreen(),
    SubjectManagementScreen(),
    TeacherManagementScreen(),
    TimeAllocationScreen(),
    TimetablePlacementScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColors.softLavender.withValues(alpha: 0.8),
        middle: CupertinoSlidingSegmentedControl<int>(
          groupValue: _currentIndex,
          backgroundColor: AppColors.background,
          thumbColor: AppColors.pastelMint,
          children: {
            0: _buildTabItem('반 관리', CupertinoIcons.book, 0),
            1: _buildTabItem('과목 관리', CupertinoIcons.book_solid, 1),
            2: _buildTabItem('교사 관리', CupertinoIcons.person_3, 2),
            3: _buildTabItem('시수 배정', CupertinoIcons.square_grid_2x2, 3),
            4: _buildTabItem('시간표 배정', CupertinoIcons.calendar, 4),
          },
          onValueChanged: (int? value) {
            if (value != null) {
              setState(() {
                _currentIndex = value;
              });
            }
          },
        ),
      ),
      child: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
      ),
    );
  }

  Widget _buildTabItem(String label, IconData icon, int index) {
    final isActive = _currentIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
