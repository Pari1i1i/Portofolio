import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../state/window_manager.dart';

class ControlCenterPanel extends StatelessWidget {
  final WindowManager windowManager;

  const ControlCenterPanel({super.key, required this.windowManager});

  @override
  Widget build(BuildContext context) {
    final isDark = windowManager.isDarkMode;

    return Positioned(
      top: 32,
      right: 12,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            width: 320,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xDD1E1E24) : const Color(0xEEF2F2F6),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? const Color(0x33FFFFFF) : const Color(0x18000000),
                width: 0.8,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Toggles Grid (Wi-Fi, Bluetooth, Dark Mode)
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0x33FFFFFF) : const Color(0x15000000),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            _buildToggleRow(
                              icon: Icons.wifi_rounded,
                              title: 'Wi-Fi',
                              subtitle: windowManager.wifiEnabled ? 'Connected' : 'Off',
                              isActive: windowManager.wifiEnabled,
                              onTap: () => windowManager.toggleWifi(),
                              isDark: isDark,
                            ),
                            const SizedBox(height: 10),
                            _buildToggleRow(
                              icon: Icons.bluetooth_rounded,
                              title: 'Bluetooth',
                              subtitle: windowManager.bluetoothEnabled ? 'On' : 'Off',
                              isActive: windowManager.bluetoothEnabled,
                              onTap: () => windowManager.toggleBluetooth(),
                              isDark: isDark,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () => windowManager.toggleTheme(),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 110,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0x33FFFFFF) : const Color(0x15000000),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                                size: 28,
                                color: AppColors.accentBlue,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                isDark ? 'Dark Mode' : 'Light Mode',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                              Text(
                                isDark ? 'On' : 'Off',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Display Brightness Slider
                _buildSliderCard(
                  icon: Icons.brightness_medium_rounded,
                  title: 'Display',
                  value: windowManager.brightness,
                  onChanged: (v) => windowManager.setBrightness(v),
                  isDark: isDark,
                ),
                const SizedBox(height: 10),

                // Sound Volume Slider
                _buildSliderCard(
                  icon: Icons.volume_up_rounded,
                  title: 'Sound',
                  value: windowManager.volume,
                  onChanged: (v) => windowManager.setVolume(v),
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isActive,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: isActive ? AppColors.accentBlue : Colors.grey.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 15, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 9.5,
                    color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderCard({
    required IconData icon,
    required String title,
    required double value,
    required ValueChanged<double> onChanged,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0x33FFFFFF) : const Color(0x15000000),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
          Row(
            children: [
              Icon(icon, size: 16, color: isDark ? Colors.white70 : Colors.black54),
              Expanded(
                child: Slider(
                  value: value,
                  activeColor: AppColors.accentBlue,
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
