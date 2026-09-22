import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/url_helper.dart';
import '../../data/models/window_model.dart';
import '../../state/window_manager.dart';

class AppleMenuDialog extends StatelessWidget {
  final WindowManager windowManager;

  const AppleMenuDialog({super.key, required this.windowManager});

  @override
  Widget build(BuildContext context) {
    final isDark = windowManager.isDarkMode;

    return Positioned(
      top: 32,
      left: 12,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Container(
            width: 220,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xDD1E1E22) : const Color(0xEEF0F0F4),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDark ? const Color(0x33FFFFFF) : const Color(0x18000000),
                width: 0.8,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildMenuItem(
                  'About This Mac',
                  isDark,
                  onTap: () {
                    windowManager.closeOverlays();
                    windowManager.openWindow(WindowType.about);
                  },
                ),
                _buildDivider(isDark),
                _buildMenuItem(
                  'System Settings...',
                  isDark,
                  onTap: () {
                    windowManager.closeOverlays();
                    windowManager.openWindow(WindowType.settings);
                  },
                ),
                _buildMenuItem(
                  'Visit GitHub Repository',
                  isDark,
                  onTap: () {
                    windowManager.closeOverlays();
                    UrlHelper.openUrl(AppStrings.githubUrl);
                  },
                ),
                _buildDivider(isDark),
                _buildMenuItem(
                  'Force Quit All Apps',
                  isDark,
                  onTap: () {
                    windowManager.closeOverlays();
                    final openTypes = windowManager.windows.keys.toList();
                    for (final t in openTypes) {
                      windowManager.closeWindow(t);
                    }
                  },
                ),
                _buildDivider(isDark),
                _buildMenuItem(
                  'Sleep',
                  isDark,
                  onTap: () {
                    windowManager.closeOverlays();
                  },
                ),
                _buildMenuItem(
                  'Restart...',
                  isDark,
                  onTap: () {
                    windowManager.closeOverlays();
                    final openTypes = windowManager.windows.keys.toList();
                    for (final t in openTypes) {
                      windowManager.closeWindow(t);
                    }
                    windowManager.openWindow(WindowType.about);
                  },
                ),
                _buildMenuItem(
                  'Lock Screen',
                  isDark,
                  onTap: () {
                    windowManager.closeOverlays();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, bool isDark, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      hoverColor: AppColors.accentBlue.withValues(alpha: 0.8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Divider(
        height: 1,
        color: isDark ? const Color(0x22FFFFFF) : const Color(0x15000000),
      ),
    );
  }
}
