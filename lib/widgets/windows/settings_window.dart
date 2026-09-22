import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../state/window_manager.dart';

class SettingsWindow extends StatelessWidget {
  final WindowManager windowManager;

  const SettingsWindow({super.key, required this.windowManager});

  @override
  Widget build(BuildContext context) {
    final isDark = windowManager.isDarkMode;

    final wallpapers = [
      {'name': 'macOS Dark', 'path': AppAssets.wallpaperMacDark, 'colors': [const Color(0xFF0F172A), const Color(0xFF1E1B4B)]},
      {'name': 'Sonoma', 'path': AppAssets.wallpaperSonoma, 'colors': [const Color(0xFF1E3A8A), const Color(0xFF3B0764)]},
      {'name': 'Sequoia', 'path': AppAssets.wallpaperSequoia, 'colors': [const Color(0xFF064E3B), const Color(0xFF0F172A)]},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Appearance & Theme',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.contentCardDark : AppColors.contentCardLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? const Color(0x22FFFFFF) : const Color(0x15000000),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                      color: AppColors.accentBlue,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dark Mode',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                          ),
                        ),
                        Text(
                          isDark ? 'Currently Dark Theme' : 'Currently Light Theme',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Switch(
                  value: isDark,
                  activeColor: AppColors.accentBlue,
                  onChanged: (_) => windowManager.toggleTheme(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          Text(
            'Desktop Wallpaper',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: wallpapers.map((w) {
              final isSelected = windowManager.currentWallpaper == w['path'];
              final colors = w['colors'] as List<Color>;

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: InkWell(
                    onTap: () => windowManager.setWallpaper(w['path'] as String),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.contentCardDark : AppColors.contentCardLight,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected ? AppColors.accentBlue : (isDark ? const Color(0x22FFFFFF) : const Color(0x15000000)),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: LinearGradient(
                                colors: colors,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: isSelected
                                ? const Center(child: Icon(Icons.check_circle_rounded, color: Colors.white, size: 24))
                                : null,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            w['name'] as String,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 24),
          Text(
            'System Controls',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.contentCardDark : AppColors.contentCardLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? const Color(0x22FFFFFF) : const Color(0x15000000),
              ),
            ),
            child: Column(
              children: [
                // Brightness slider
                Row(
                  children: [
                    const Icon(Icons.brightness_medium_rounded, size: 18),
                    const SizedBox(width: 12),
                    const Text('Display Brightness', style: TextStyle(fontSize: 12)),
                    Expanded(
                      child: Slider(
                        value: windowManager.brightness,
                        activeColor: AppColors.accentBlue,
                        onChanged: (v) => windowManager.setBrightness(v),
                      ),
                    ),
                    Text('${(windowManager.brightness * 100).toInt()}%', style: const TextStyle(fontSize: 11)),
                  ],
                ),
                const Divider(),
                // Volume slider
                Row(
                  children: [
                    const Icon(Icons.volume_up_rounded, size: 18),
                    const SizedBox(width: 12),
                    const Text('Audio Volume', style: TextStyle(fontSize: 12)),
                    Expanded(
                      child: Slider(
                        value: windowManager.volume,
                        activeColor: AppColors.accentBlue,
                        onChanged: (v) => windowManager.setVolume(v),
                      ),
                    ),
                    Text('${(windowManager.volume * 100).toInt()}%', style: const TextStyle(fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          Text(
            'System Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.contentCardDark : AppColors.contentCardLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? const Color(0x22FFFFFF) : const Color(0x15000000),
              ),
            ),
            child: Column(
              children: [
                _buildInfoRow('Developer', AppStrings.name, isDark),
                const SizedBox(height: 8),
                _buildInfoRow('Framework', 'Flutter 3.35 (Web CanvasKit/WASM)', isDark),
                const SizedBox(height: 8),
                _buildInfoRow('Architecture', 'Modular Clean Architecture', isDark),
                const SizedBox(height: 8),
                _buildInfoRow('Inspired by', 'https://portfolio.dctech.dev/', isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
      ],
    );
  }
}
