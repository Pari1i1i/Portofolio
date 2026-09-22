import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../data/models/window_model.dart';
import '../../state/window_manager.dart';

class TopMenuBar extends StatefulWidget {
  final WindowManager windowManager;

  const TopMenuBar({super.key, required this.windowManager});

  @override
  State<TopMenuBar> createState() => _TopMenuBarState();
}

class _TopMenuBarState extends State<TopMenuBar> {
  late Timer _timer;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          _currentTime = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wm = widget.windowManager;
    final isDark = wm.isDarkMode;
    final activeTitle = wm.activeWindow?.title ?? AppStrings.finder;

    final dateFormat = DateFormat('EEE d MMM');
    final timeFormat = DateFormat('h:mm a');

    final textColor = isDark ? Colors.white : Colors.black87;

    return Container(
      height: 28,
      decoration: BoxDecoration(
        color: isDark ? const Color(0x66000000) : const Color(0x88FFFFFF),
        border: Border(
          bottom: BorderSide(
            color: isDark ? const Color(0x22FFFFFF) : const Color(0x18000000),
            width: 0.8,
          ),
        ),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                // Apple Icon
                InkWell(
                  onTap: () => wm.toggleAppleMenu(),
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    child: Text(
                      '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),

                // Active App Name
                Text(
                  activeTitle.split(' — ')[0],
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(width: 14),

                // Menu items (Desktop view only)
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isDesktop = MediaQuery.of(context).size.width > 700;
                    if (!isDesktop) return const SizedBox.shrink();

                    return Row(
                      children: [
                        _buildMenuText('File', isDark, () => wm.openWindow(WindowType.projects)),
                        _buildMenuText('Edit', isDark, null),
                        _buildMenuText('View', isDark, () => wm.toggleControlCenter()),
                        _buildMenuText('Go', isDark, () => wm.openWindow(WindowType.achievements)),
                        _buildMenuText('Window', isDark, null),
                        _buildMenuText('Help', isDark, () => wm.openWindow(WindowType.terminal)),
                      ],
                    );
                  },
                ),

                const Spacer(),

                // Status Icons
                // Battery
                Row(
                  children: [
                    Text(
                      '100%',
                      style: TextStyle(fontSize: 11, color: textColor),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.battery_charging_full_rounded, size: 16, color: textColor),
                  ],
                ),
                const SizedBox(width: 12),

                // Wi-Fi
                InkWell(
                  onTap: () => wm.toggleWifi(),
                  child: Icon(
                    wm.wifiEnabled ? Icons.wifi_rounded : Icons.wifi_off_rounded,
                    size: 15,
                    color: wm.wifiEnabled ? textColor : Colors.grey,
                  ),
                ),
                const SizedBox(width: 12),

                // Spotlight Search
                InkWell(
                  onTap: () => wm.toggleSpotlight(),
                  child: Icon(Icons.search_rounded, size: 16, color: textColor),
                ),
                const SizedBox(width: 12),

                // Control Center
                InkWell(
                  onTap: () => wm.toggleControlCenter(),
                  child: Icon(Icons.tune_rounded, size: 15, color: textColor),
                ),
                const SizedBox(width: 12),

                // Clock
                Text(
                  '${dateFormat.format(_currentTime)}  ${timeFormat.format(_currentTime)}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuText(String label, bool isDark, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        ),
      ),
    );
  }
}
