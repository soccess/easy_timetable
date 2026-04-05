import 'package:flutter/cupertino.dart';
import '../../theme/app_colors.dart';
import '../components/glass_sidebar.dart';
import '../components/class_creation_form.dart';
import '../components/cute_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Row(
          children: [
            const GlassSidebar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '안녕하세요! 👋',
                      style: CupertinoTheme.of(context).textTheme.navTitleTextStyle.copyWith(
                            fontSize: 48,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Easy Timetable에서 시간표를 쉽게 관리해보세요.',
                      style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 2,
                          child: ClassCreationForm(),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          flex: 1,
                          child: CuteCard(
                            color: AppColors.babyPink.withValues(alpha: 0.3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const ExcludeSemantics(
                                      child: Icon(CupertinoIcons.bell, color: AppColors.textPrimary),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '알림',
                                      style: CupertinoTheme.of(context).textTheme.navTitleTextStyle.copyWith(
                                            fontSize: 24,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  '아직 등록된 교사가 없습니다.\n먼저 교사를 등록해주세요!',
                                  style: CupertinoTheme.of(context).textTheme.textStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
