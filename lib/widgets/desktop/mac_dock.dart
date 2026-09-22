import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/url_helper.dart';
import '../../data/models/window_model.dart';
import '../../state/window_manager.dart';

class MacDockItem {
  final String label;
  final IconData? icon;
  final Widget? customIcon;
  final Color baseColor;
  final VoidCallback onTap;
  final WindowType? windowType;
  final bool isExternal;

  const MacDockItem({
    required this.label,
    this.icon,
    this.customIcon,
    this.baseColor = AppColors.accentBlue,
    required this.onTap,
    this.windowType,
    this.isExternal = false,
  });
}

class MacDock extends StatefulWidget {
  final WindowManager windowManager;

  const MacDock({super.key, required this.windowManager});

  @override
  State<MacDock> createState() => _MacDockState();
}

class _MacDockState extends State<MacDock> {
  double? _hoveredIndex;

  late final List<MacDockItem> _dockItems;

  @override
  void initState() {
    super.initState();
    _initDockItems();
  }

  void _initDockItems() {
    final wm = widget.windowManager;

    _dockItems = [
      MacDockItem(
        label: 'Finder',
        icon: Icons.face_rounded,
        baseColor: const Color(0xFF007AFF),
        windowType: WindowType.about,
        onTap: () => wm.openWindow(WindowType.about),
      ),
      MacDockItem(
        label: 'About Me',
        icon: Icons.person_pin_rounded,
        baseColor: const Color(0xFF5856D6),
        windowType: WindowType.about,
        onTap: () => wm.openWindow(WindowType.about),
      ),
      MacDockItem(
        label: 'Projects',
        icon: Icons.folder_special_rounded,
        baseColor: const Color(0xFFFF9500),
        windowType: WindowType.projects,
        onTap: () => wm.openWindow(WindowType.projects),
      ),
      MacDockItem(
        label: 'Achievement',
        icon: Icons.emoji_events_rounded,
        baseColor: const Color(0xFFFF2D55),
        windowType: WindowType.achievements,
        onTap: () => wm.openWindow(WindowType.achievements),
      ),
      MacDockItem(
        label: 'Terminal',
        icon: Icons.terminal_rounded,
        baseColor: const Color(0xFF1C1C1E),
        windowType: WindowType.terminal,
        onTap: () => wm.openWindow(WindowType.terminal),
      ),
      // Direct action & Social icons
      MacDockItem(
        label: 'Contact (Email)',
        icon: Icons.mail_rounded,
        baseColor: const Color(0xFF0A84FF),
        isExternal: true,
        onTap: () => UrlHelper.openEmail(AppStrings.email),
      ),
      MacDockItem(
        label: 'GitHub',
        customIcon: const FaIcon(FontAwesomeIcons.github, size: 24, color: Colors.white),
        baseColor: const Color(0xFF24292E),
        isExternal: true,
        onTap: () => UrlHelper.openUrl(AppStrings.githubUrl),
      ),
      MacDockItem(
        label: 'LinkedIn',
        customIcon: const FaIcon(FontAwesomeIcons.linkedin, size: 24, color: Colors.white),
        baseColor: const Color(0xFF0A66C2),
        isExternal: true,
        onTap: () => UrlHelper.openUrl(AppStrings.linkedinUrl),
      ),
      MacDockItem(
        label: 'Instagram',
        customIcon: const FaIcon(FontAwesomeIcons.instagram, size: 24, color: Colors.white),
        baseColor: const Color(0xFFE4405F),
        isExternal: true,
        onTap: () => UrlHelper.openUrl(AppStrings.instagramUrl),
      ),
      MacDockItem(
        label: 'Trash',
        icon: Icons.delete_outline_rounded,
        baseColor: const Color(0xFF636366),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Trash is empty!'),
              duration: Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      ),
    ];
  }

  double _getScale(int index) {
    if (_hoveredIndex == null) return 1.0;
    final distance = (index - _hoveredIndex!).abs();
    if (distance > 2.5) return 1.0;
    // Gaussian-like falloff
    return 1.0 + 0.35 * exp(-0.6 * distance * distance);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.windowManager.isDarkMode;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 700;

    final baseIconSize = isMobile ? 38.0 : 48.0;

    return Center(
      child: MouseRegion(
        onExit: (_) => setState(() => _hoveredIndex = null),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? const Color(0x661C1C1E) : const Color(0x66FFFFFF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? const Color(0x33FFFFFF) : const Color(0x22000000),
              width: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (int i = 0; i < _dockItems.length; i++) ...[
                      if (i == 5) ...[
                        // Divider before social / direct action items
                        Container(
                          width: 1,
                          height: baseIconSize * 0.75,
                          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                          color: isDark ? const Color(0x33FFFFFF) : const Color(0x22000000),
                        ),
                      ],
                      _buildDockButton(i, _dockItems[i], baseIconSize),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDockButton(int index, MacDockItem item, double baseSize) {
    final scale = _getScale(index);
    final size = baseSize * scale;
    final isOpen = item.windowType != null && widget.windowManager.isWindowOpen(item.windowType!);
    final isHovered = _hoveredIndex != null && (_hoveredIndex! - index).abs() < 0.5;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index.toDouble()),
      child: GestureDetector(
        onTap: item.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Tooltip above icon
              if (isHovered)
                Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.white24, width: 0.6),
                  ),
                  child: Text(
                    item.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              else
                const SizedBox(height: 23),

              // Dock Icon Container
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeOut,
                width: size,
                height: size,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      item.baseColor,
                      item.baseColor.withValues(alpha: 0.75),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(size * 0.22),
                  boxShadow: [
                    BoxShadow(
                      color: item.baseColor.withValues(alpha: 0.4),
                      blurRadius: 10 * scale,
                      offset: Offset(0, 4 * scale),
                    ),
                  ],
                ),
                child: Center(
                  child: item.customIcon ??
                      Icon(
                        item.icon,
                        size: size * 0.55,
                        color: Colors.white,
                      ),
                ),
              ),

              const SizedBox(height: 4),

              // Active App Running Indicator Dot
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: isOpen ? Colors.white : Colors.transparent,
                  shape: BoxShape.circle,
                  boxShadow: isOpen
                      ? [const BoxShadow(color: Colors.white, blurRadius: 4)]
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
