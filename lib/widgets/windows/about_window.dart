import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/url_helper.dart';
import '../../data/models/window_model.dart';
import '../../data/portfolio_data.dart';
import '../../state/window_manager.dart';
import '../common/image_placeholder.dart';

class AboutWindow extends StatelessWidget {
  final WindowManager windowManager;

  const AboutWindow({super.key, required this.windowManager});

  @override
  Widget build(BuildContext context) {
    final isDark = windowManager.isDarkMode;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Profile Card
          _buildProfileHeader(isDark),
          const SizedBox(height: 24),

          // Quick Stats Row
          _buildStatsRow(isDark),
          const SizedBox(height: 28),

          // About Section
          Text(
            'About Me',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            AppStrings.bio,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 28),

          // Skills Grid
          Text(
            'Technical Expertise',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 14),
          _buildSkillsSection(isDark),
          const SizedBox(height: 28),

          // Quick Navigation Actions
          _buildActionButtons(context, isDark),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.contentCardDark : AppColors.contentCardLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0x22FFFFFF) : const Color(0x15000000),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentBlue.withValues(alpha: 0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(44),
              child: const SafeAssetImage(
                assetPath: AppAssets.profile,
                width: 88,
                height: 88,
                fallbackTitle: 'FA',
                fallbackIcon: Icons.person_rounded,
                fallbackGradient: [Color(0xFF2563EB), Color(0xFF7C3AED)],
              ),
            ),
          ),
          const SizedBox(width: 20),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      AppStrings.name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.accentGreen.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.accentGreen.withValues(alpha: 0.5)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(radius: 3.5, backgroundColor: AppColors.accentGreen),
                          SizedBox(width: 5),
                          Text(
                            'Open for Opportunities',
                            style: TextStyle(
                              color: AppColors.accentGreen,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  AppStrings.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.accentBlue,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 15,
                          color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          AppStrings.location,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.mail_outline_rounded,
                          size: 15,
                          color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                        ),
                        const SizedBox(width: 4),
                        InkWell(
                          onTap: () => UrlHelper.openEmail(AppStrings.email),
                          child: Text(
                            AppStrings.email,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(bool isDark) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 600;
        final items = PortfolioData.stats.map((s) {
          return Expanded(
            flex: isNarrow ? 0 : 1,
            child: Container(
              margin: EdgeInsets.all(isNarrow ? 4 : 6),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.contentCardDark : AppColors.contentCardLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? const Color(0x1FFFFFFF) : const Color(0x12000000),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    s['value']!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    s['label']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList();

        if (isNarrow) {
          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: PortfolioData.stats.map((s) {
              return SizedBox(
                width: (constraints.maxWidth - 16) / 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.contentCardDark : AppColors.contentCardLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark ? const Color(0x1FFFFFFF) : const Color(0x12000000),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        s['value']!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accentBlue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        s['label']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }

        return Row(children: items);
      },
    );
  }

  Widget _buildSkillsSection(bool isDark) {
    return Column(
      children: PortfolioData.skills.entries.map((entry) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? AppColors.contentCardDark : AppColors.contentCardLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? const Color(0x1FFFFFFF) : const Color(0x12000000),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accentPurple,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: entry.value.map((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0x28FFFFFF) : const Color(0x15000000),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      skill,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isDark) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () => windowManager.openWindow(WindowType.projects),
          icon: const Icon(Icons.rocket_launch_rounded, size: 16),
          label: const Text('View 6 Projects'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        OutlinedButton.icon(
          onPressed: () => windowManager.openWindow(WindowType.achievements),
          icon: const Icon(Icons.emoji_events_rounded, size: 16),
          label: const Text('View Achievements'),
          style: OutlinedButton.styleFrom(
            foregroundColor: isDark ? Colors.white : Colors.black87,
            side: BorderSide(color: isDark ? Colors.white24 : Colors.black26),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        IconButton(
          onPressed: () => UrlHelper.openUrl(AppStrings.githubUrl),
          icon: const FaIcon(FontAwesomeIcons.github, size: 20),
          tooltip: 'GitHub',
        ),
        IconButton(
          onPressed: () => UrlHelper.openUrl(AppStrings.linkedinUrl),
          icon: const FaIcon(FontAwesomeIcons.linkedin, size: 20),
          tooltip: 'LinkedIn',
        ),
      ],
    );
  }
}
