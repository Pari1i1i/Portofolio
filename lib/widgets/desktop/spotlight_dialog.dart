import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/url_helper.dart';
import '../../data/models/achievement_model.dart';
import '../../data/models/window_model.dart';
import '../../data/portfolio_data.dart';
import '../../state/window_manager.dart';

class SpotlightDialog extends StatefulWidget {
  final WindowManager windowManager;

  const SpotlightDialog({super.key, required this.windowManager});

  @override
  State<SpotlightDialog> createState() => _SpotlightDialogState();
}

class _SpotlightDialogState extends State<SpotlightDialog> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.windowManager.isDarkMode;

    final matchedProjects = PortfolioData.projects
        .where((p) => p.title.toLowerCase().contains(_query.toLowerCase()) ||
            p.description.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    final matchedAchievements = PortfolioData.achievements
        .where((a) => a.title.toLowerCase().contains(_query.toLowerCase()) ||
            a.description.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Positioned(
      top: 100,
      left: (MediaQuery.of(context).size.width - 550) / 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            width: 550,
            constraints: const BoxConstraints(maxHeight: 460),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xDD1E1E24) : const Color(0xEEF2F2F6),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? const Color(0x33FFFFFF) : const Color(0x18000000),
                width: 0.8,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Search Input Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.search_rounded, size: 22, color: AppColors.accentBlue),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          autofocus: true,
                          style: TextStyle(
                            fontSize: 18,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Spotlight Search',
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: isDark ? Colors.white38 : Colors.black38,
                            ),
                            border: InputBorder.none,
                          ),
                          onChanged: (val) => setState(() => _query = val),
                        ),
                      ),
                      if (_query.isNotEmpty)
                        IconButton(
                          onPressed: () {
                            _controller.clear();
                            setState(() => _query = '');
                          },
                          icon: const Icon(Icons.clear_rounded, size: 18),
                        ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  color: isDark ? const Color(0x22FFFFFF) : const Color(0x18000000),
                ),

                // Search Results
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    children: [
                      if (_query.isEmpty) ...[
                        _buildSectionHeader('APPLICATIONS', isDark),
                        _buildAppItem('About Me', Icons.person_rounded, () {
                          widget.windowManager.closeOverlays();
                          widget.windowManager.openWindow(WindowType.about);
                        }, isDark),
                        _buildAppItem('Projects Showcase', Icons.folder_special_rounded, () {
                          widget.windowManager.closeOverlays();
                          widget.windowManager.openWindow(WindowType.projects);
                        }, isDark),
                        _buildAppItem('Achievement (Akademik & Partisipan)', Icons.emoji_events_rounded, () {
                          widget.windowManager.closeOverlays();
                          widget.windowManager.openWindow(WindowType.achievements);
                        }, isDark),
                        _buildAppItem('Terminal', Icons.terminal_rounded, () {
                          widget.windowManager.closeOverlays();
                          widget.windowManager.openWindow(WindowType.terminal);
                        }, isDark),
                        _buildAppItem('Contact (Email)', Icons.mail_rounded, () {
                          widget.windowManager.closeOverlays();
                          UrlHelper.openEmail(AppStrings.email);
                        }, isDark),
                      ] else ...[
                        if (matchedProjects.isNotEmpty) ...[
                          _buildSectionHeader('PROJECTS', isDark),
                          ...matchedProjects.map((p) => _buildResultTile(
                                title: p.title,
                                subtitle: p.subtitle,
                                icon: Icons.folder_open_rounded,
                                onTap: () {
                                  widget.windowManager.closeOverlays();
                                  widget.windowManager.openWindow(WindowType.projects);
                                },
                                isDark: isDark,
                              )),
                        ],
                        if (matchedAchievements.isNotEmpty) ...[
                          _buildSectionHeader('ACHIEVEMENTS', isDark),
                          ...matchedAchievements.map((a) => _buildResultTile(
                                title: a.title,
                                subtitle: '${a.category.displayName} • ${a.badgeText}',
                                icon: Icons.workspace_premium_rounded,
                                onTap: () {
                                  widget.windowManager.closeOverlays();
                                  widget.windowManager.openWindow(
                                    WindowType.achievements,
                                    subFolder: a.category.folderName,
                                  );
                                },
                                isDark: isDark,
                              )),
                        ],
                        if (matchedProjects.isEmpty && matchedAchievements.isEmpty)
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: Text(
                                'No results found for "$_query"',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isDark ? Colors.white54 : Colors.black54,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 8, bottom: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
          color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
        ),
      ),
    );
  }

  Widget _buildAppItem(String title, IconData icon, VoidCallback onTap, bool isDark) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      hoverColor: AppColors.accentBlue.withValues(alpha: 0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.accentBlue.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, size: 16, color: AppColors.accentBlue),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      hoverColor: AppColors.accentBlue.withValues(alpha: 0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 18, color: AppColors.accentBlue),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
