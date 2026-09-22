import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/url_helper.dart';
import '../../data/models/window_model.dart';
import '../../state/window_manager.dart';
import '../widgets/common/mac_window.dart';
import '../widgets/desktop/apple_menu_dialog.dart';
import '../widgets/desktop/control_center_panel.dart';
import '../widgets/desktop/desktop_icon.dart';
import '../widgets/desktop/mac_dock.dart';
import '../widgets/desktop/spotlight_dialog.dart';
import '../widgets/desktop/top_menu_bar.dart';
import '../widgets/windows/window_content_view.dart';

class DesktopScreen extends StatefulWidget {
  final WindowManager windowManager;

  const DesktopScreen({super.key, required this.windowManager});

  @override
  State<DesktopScreen> createState() => _DesktopScreenState();
}

class _DesktopScreenState extends State<DesktopScreen> {
  @override
  void initState() {
    super.initState();
    // Auto-open About Me window on launch after layout completes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final size = MediaQuery.of(context).size;
        widget.windowManager.openWindow(WindowType.about, screenSize: size);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final wm = widget.windowManager;
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 700;

    return AnimatedBuilder(
      animation: wm,
      builder: (context, _) {
        return Scaffold(
          body: GestureDetector(
            onTap: () => wm.closeOverlays(),
            behavior: HitTestBehavior.translucent,
            child: Stack(
              children: [
                // 1. Wallpaper Layer
                _buildWallpaper(wm),

                // 2. Desktop Shortcut Icons Layer
                Positioned(
                  top: 48,
                  left: 20,
                  child: _buildDesktopIcons(wm),
                ),

                // 3. Open Windows Layer
                ...wm.windowList.map((win) {
                  return MacWindow(
                    key: ValueKey(win.type),
                    item: win,
                    windowManager: wm,
                    screenSize: screenSize,
                    content: WindowContentView(type: win.type, windowManager: wm),
                  );
                }),

                // 4. Top Menu Bar (macOS Status Header)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: TopMenuBar(windowManager: wm),
                ),

                // 5. Dock at Bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: MacDock(windowManager: wm),
                ),

                // 6. Overlays (Apple Menu, Control Center, Spotlight)
                if (wm.isAppleMenuOpen) AppleMenuDialog(windowManager: wm),
                if (wm.isControlCenterOpen) ControlCenterPanel(windowManager: wm),
                if (wm.isSpotlightOpen) SpotlightDialog(windowManager: wm),

                // Mobile Helper Banner
                if (isMobile && wm.windows.isEmpty)
                  Positioned(
                    top: 100,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.65),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white24, width: 0.8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.touch_app_rounded, color: Colors.white70, size: 20),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Tap any app on the dock below to explore projects & achievements!',
                              style: TextStyle(color: Colors.white, fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWallpaper(WindowManager wm) {
    // Elegant procedural gradient background with fallback
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: wm.currentWallpaper == AppAssets.wallpaperSonoma
              ? [const Color(0xFF1E3A8A), const Color(0xFF3B0764), const Color(0xFF0F172A)]
              : (wm.currentWallpaper == AppAssets.wallpaperSequoia
                  ? [const Color(0xFF064E3B), const Color(0xFF0F172A), const Color(0xFF1E1B4B)]
                  : [const Color(0xFF0F172A), const Color(0xFF1E1B4B), const Color(0xFF111827)]),
        ),
      ),
      child: Image.asset(
        wm.currentWallpaper,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // If asset wallpaper not found, the gradient container already renders flawlessly!
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDesktopIcons(WindowManager wm) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 700;

    if (isMobile) return const SizedBox.shrink();

    final screenHeight = screenSize.height;
    const double reservedForDock = 88;

    final icons = <Widget>[
      // About Me shortcut
      DesktopIcon(
        title: 'About Me',
        icon: Icons.person_pin_rounded,
        iconColor: const Color(0xFF5856D6),
        onOpen: () => wm.openWindow(WindowType.about, screenSize: screenSize),
      ),
      const SizedBox(height: 10),

      // Contact / Email shortcut (Direct email launch)
      DesktopIcon(
        title: 'Contact',
        icon: Icons.mail_rounded,
        iconColor: const Color(0xFF0A84FF),
        onOpen: () => UrlHelper.openEmail(AppStrings.email),
      ),
      const SizedBox(height: 10),

      // Projects Showcase
      DesktopIcon(
        title: 'Projects',
        icon: Icons.folder_special_rounded,
        iconColor: const Color(0xFFFF9500),
        badgeText: '6',
        onOpen: () => wm.openWindow(WindowType.projects, screenSize: screenSize),
      ),
      const SizedBox(height: 10),

      // Achievement Folder (Replaces Packages)
      DesktopIcon(
        title: 'Achievement',
        icon: Icons.emoji_events_rounded,
        iconColor: const Color(0xFFFF2D55),
        badgeText: '9',
        isFolder: true,
        onOpen: () => wm.openWindow(WindowType.achievements, screenSize: screenSize),
      ),
      const SizedBox(height: 10),

      // Terminal shortcut
      DesktopIcon(
        title: 'Terminal',
        icon: Icons.terminal_rounded,
        iconColor: const Color(0xFF1C1C1E),
        onOpen: () => wm.openWindow(WindowType.terminal, screenSize: screenSize),
      ),
      const SizedBox(height: 10),

      // GitHub Profile (Direct Link)
      DesktopIcon(
        title: 'GitHub',
        customIcon: const FaIcon(FontAwesomeIcons.github, size: 26, color: Colors.white),
        iconColor: const Color(0xFF24292E),
        onOpen: () => UrlHelper.openUrl(AppStrings.githubUrl),
      ),
      const SizedBox(height: 10),

      // LinkedIn Profile (Direct Link)
      DesktopIcon(
        title: 'LinkedIn',
        customIcon: const FaIcon(FontAwesomeIcons.linkedin, size: 26, color: Colors.white),
        iconColor: const Color(0xFF0A66C2),
        onOpen: () => UrlHelper.openUrl(AppStrings.linkedinUrl),
      ),
      const SizedBox(height: 10),

      // Instagram Profile (Direct Link)
      DesktopIcon(
        title: 'Instagram',
        customIcon: const FaIcon(FontAwesomeIcons.instagram, size: 26, color: Colors.white),
        iconColor: const Color(0xFFE4405F),
        onOpen: () => UrlHelper.openUrl(AppStrings.instagramUrl),
      ),
    ];

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: screenHeight - 48 - reservedForDock,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: icons,
        ),
      ),
    );
  }
}
