import 'dart:ui';
import 'package:flutter/cupertino.dart';
import '../../theme/app_colors.dart';

class GlassSidebar extends StatelessWidget {
  const GlassSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: AppColors.softLavender.withValues(alpha: 0.3),
        border: Border(
          right: BorderSide(
            color: AppColors.softLavender.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Easy Timetable',
                  style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                ),
                const SizedBox(height: 40),
                _SidebarItem(
                  icon: CupertinoIcons.home,
                  title: '홈',
                  isActive: true,
                ),
                const SizedBox(height: 20),
                _SidebarItem(
                  icon: CupertinoIcons.book,
                  title: '학급 관리',
                  isActive: false,
                ),
                const SizedBox(height: 20),
                _SidebarItem(
                  icon: CupertinoIcons.person_3,
                  title: '교사 관리',
                  isActive: false,
                ),
                const Spacer(),
                const _SidebarItem(
                  icon: CupertinoIcons.settings,
                  title: '설정',
                  isActive: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isActive;

  const _SidebarItem({
    required this.icon,
    required this.title,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? AppColors.pastelMint.withValues(alpha: 0.5) : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ExcludeSemantics(
            child: Icon(
              icon,
              color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}
