import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/url_helper.dart';
import '../../state/window_manager.dart';

class SafariWindow extends StatefulWidget {
  final WindowManager windowManager;

  const SafariWindow({super.key, required this.windowManager});

  @override
  State<SafariWindow> createState() => _SafariWindowState();
}

class _SafariWindowState extends State<SafariWindow> {
  int _activeTab = 0;

  final List<Map<String, dynamic>> _tabs = [
    {
      'title': 'GitHub / Pari1i1i',
      'url': AppStrings.githubUrl,
      'icon': FontAwesomeIcons.github,
      'color': const Color(0xFF24292E),
      'desc': 'Eksplorasi seluruh repository open-source & kontribusi coding Fachri Achmad.',
    },
    {
      'title': 'LinkedIn / fachriii',
      'url': AppStrings.linkedinUrl,
      'icon': FontAwesomeIcons.linkedin,
      'color': const Color(0xFF0A66C2),
      'desc': 'Profil profesional, riwayat karier, sertifikasi industri, dan jaringan kerja.',
    },
    {
      'title': 'Instagram / achmadfachrii__',
      'url': AppStrings.instagramUrl,
      'icon': FontAwesomeIcons.instagram,
      'color': const Color(0xFFE4405F),
      'desc': 'Update kegiatan sehari-hari, eksplorasi teknologi, dan visual creative feed.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = widget.windowManager.isDarkMode;
    final currentTab = _tabs[_activeTab];

    return Column(
      children: [
        // Safari Top Navigation Bar
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E22) : const Color(0xFFE5E5EA),
            border: Border(
              bottom: BorderSide(
                color: isDark ? const Color(0x22FFFFFF) : const Color(0x18000000),
                width: 0.8,
              ),
            ),
          ),
          child: Row(
            children: [
              // Back/Forward buttons
              Icon(Icons.arrow_back_ios_rounded, size: 14, color: isDark ? Colors.white38 : Colors.black38),
              const SizedBox(width: 12),
              Icon(Icons.arrow_forward_ios_rounded, size: 14, color: isDark ? Colors.white38 : Colors.black38),
              const SizedBox(width: 16),
              // Search / URL bar
              Expanded(
                child: Container(
                  height: 28,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF2B2B30) : Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isDark ? const Color(0x22FFFFFF) : const Color(0x15000000),
                      width: 0.8,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.lock_rounded, size: 12, color: AppColors.accentGreen),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          currentTab['url'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InkWell(
                        onTap: () => UrlHelper.openUrl(currentTab['url'] as String),
                        child: Icon(Icons.refresh_rounded, size: 14, color: isDark ? Colors.white60 : Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              InkWell(
                onTap: () => UrlHelper.openUrl(currentTab['url'] as String),
                child: const Icon(Icons.open_in_new_rounded, size: 16, color: AppColors.accentBlue),
              ),
            ],
          ),
        ),

        // Safari Tab Bar
        Container(
          height: 34,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF161618) : const Color(0xFFDCDCE0),
          ),
          child: Row(
            children: _tabs.asMap().entries.map((entry) {
              final idx = entry.key;
              final tab = entry.value;
              final isSelected = _activeTab == idx;

              return Expanded(
                child: InkWell(
                  onTap: () => setState(() => _activeTab = idx),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (isDark ? const Color(0xFF2A2A2E) : Colors.white)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        FaIcon(tab['icon'] as IconData, size: 12, color: tab['color'] as Color),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            tab['title'] as String,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        // Webpage Preview Card
        Expanded(
          child: Container(
            color: isDark ? const Color(0xFF1E1E22) : const Color(0xFFF2F2F7),
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 550),
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.contentCardDark : AppColors.contentCardLight,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? const Color(0x22FFFFFF) : const Color(0x18000000),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: (currentTab['color'] as Color).withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: FaIcon(
                          currentTab['icon'] as IconData,
                          size: 32,
                          color: currentTab['color'] as Color,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      currentTab['title'] as String,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currentTab['desc'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SelectableText(
                      currentTab['url'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.accentBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => UrlHelper.openUrl(currentTab['url'] as String),
                      icon: const Icon(Icons.launch_rounded, size: 16),
                      label: const Text('Buka Website'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
