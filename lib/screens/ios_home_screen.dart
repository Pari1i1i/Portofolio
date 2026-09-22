import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/utils/url_helper.dart';
import '../data/models/window_model.dart';
import '../state/window_manager.dart';
import '../widgets/windows/window_content_view.dart';

class IOSHomeScreen extends StatefulWidget {
  final WindowManager windowManager;

  const IOSHomeScreen({super.key, required this.windowManager});

  @override
  State<IOSHomeScreen> createState() => _IOSHomeScreenState();
}

class _IOSHomeScreenState extends State<IOSHomeScreen> {
  late final List<_IOSApp> _apps;

  @override
  void initState() {
    super.initState();
    final wm = widget.windowManager;
    _apps = [
      _IOSApp(
        label: 'About Me',
        icon: Icons.person_rounded,
        baseColor: const Color(0xFF5856D6),
        windowType: WindowType.about,
        onTap: () => wm.openWindow(WindowType.about),
      ),
      _IOSApp(
        label: 'App Store',
        icon: Icons.shopping_bag_rounded,
        baseColor: const Color(0xFF0A84FF),
        windowType: WindowType.projects,
        onTap: () => wm.openWindow(WindowType.projects),
      ),
      _IOSApp(
        label: 'Achievement',
        icon: Icons.emoji_events_rounded,
        baseColor: const Color(0xFFFF2D55),
        windowType: WindowType.achievements,
        onTap: () => wm.openWindow(WindowType.achievements),
      ),
      _IOSApp(
        label: 'Terminal',
        icon: Icons.terminal_rounded,
        baseColor: const Color(0xFF1C1C1E),
        windowType: WindowType.terminal,
        onTap: () => wm.openWindow(WindowType.terminal),
      ),
      _IOSApp(
        label: 'Mail',
        icon: Icons.mail_rounded,
        baseColor: const Color(0xFF0A84FF),
        onTap: () => UrlHelper.openEmail(AppStrings.email),
      ),
      _IOSApp(
        label: 'GitHub',
        icon: FontAwesomeIcons.github,
        baseColor: const Color(0xFF24292E),
        onTap: () => UrlHelper.openUrl(AppStrings.githubUrl),
      ),
      _IOSApp(
        label: 'LinkedIn',
        icon: FontAwesomeIcons.linkedin,
        baseColor: const Color(0xFF0A66C2),
        onTap: () => UrlHelper.openUrl(AppStrings.linkedinUrl),
      ),
      _IOSApp(
        label: 'Instagram',
        icon: FontAwesomeIcons.instagram,
        baseColor: const Color(0xFFE4405F),
        onTap: () => UrlHelper.openUrl(AppStrings.instagramUrl),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final wm = widget.windowManager;

    return Scaffold(
      body: AnimatedBuilder(
        animation: wm,
        builder: (context, _) {
          final isDark = wm.isDarkMode;

          return Stack(
            fit: StackFit.expand,
            children: [
              _buildBackground(isDark),
              if (wm.activeWindow != null)
                _buildAppPage(wm, isDark)
              else
                _buildHomeScreen(wm, isDark),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBackground(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [Color(0xFF14141C), Color(0xFF2E1065), Color(0xFF0F172A)]
              : const [Color(0xFF7DD3FC), Color(0xFFA78BFA), Color(0xFFFED7AA)],
        ),
      ),
      child: Image.asset(
        widget.windowManager.currentWallpaper,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
      ),
    );
  }

  // ---------------- Home screen ----------------

  Widget _buildHomeScreen(WindowManager wm, bool isDark) {
    return Column(
      children: [
        const _IOSStatusBar(isDark: true),
        const Spacer(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Spacer(),
                _buildAppGrid(),
                const Spacer(),
                _buildIOSDock(isDark),
              ],
            ),
          ),
        ),
        const _HomeIndicator(),
      ],
    );
  }

  Widget _buildAppGrid() {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 22,
      crossAxisSpacing: 14,
      childAspectRatio: 0.7,
      children: _apps.map((app) => _AppIconTile(app: app)).toList(),
    );
  }

  Widget _buildIOSDock(bool isDark) {
    final dockApps = _apps.take(4).toList();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: isDark ? 0.25 : 0.45),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: dockApps.map((app) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: _AppIconTile(app: app, size: 58),
          );
        }).toList(),
      ),
    );
  }

  // ---------------- App page ----------------

  Widget _buildAppPage(WindowManager wm, bool isDark) {
    final type = wm.activeWindow!;
    return Column(
      children: [
        const _IOSStatusBar(isDark: true),
        _buildIOSNavBar(wm, type, isDark),
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(22),
            ),
            child: WindowContentView(type: type, windowManager: wm),
          ),
        ),
        const _HomeIndicator(),
      ],
    );
  }

  Widget _buildIOSNavBar(WindowManager wm, WindowType type, bool isDark) {
    final bg = isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF9F9F9);
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: bg,
        border: Border(
          bottom: BorderSide(
            color: isDark ? const Color(0x22FFFFFF) : const Color(0x14000000),
          ),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              wm.closeWindow(type);
              wm.closeOverlays();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.chevron_left_rounded,
                    size: 26,
                    color: AppColors.accentBlue,
                  ),
                  Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.accentBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            type.icon,
            size: 18,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              type.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded, size: 20),
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            onPressed: () {
              wm.closeWindow(type);
              wm.closeOverlays();
            },
          ),
        ],
      ),
    );
  }
}

class _IOSApp {
  final String label;
  final dynamic icon;
  final Color baseColor;
  final WindowType? windowType;
  final VoidCallback onTap;

  const _IOSApp({
    required this.label,
    required this.icon,
    required this.baseColor,
    this.windowType,
    required this.onTap,
  });
}

class _AppIconTile extends StatelessWidget {
  final _IOSApp app;
  final double? size;

  const _AppIconTile({required this.app, this.size});

  @override
  Widget build(BuildContext context) {
    final iconSize = size == null ? 32.0 : size! * 0.5;
    final icon = app.icon is FaIconData
        ? FaIcon(
            app.icon as FaIconData,
            size: iconSize,
            color: Colors.white,
          )
        : Icon(
            app.icon as IconData,
            size: iconSize,
            color: Colors.white,
          );
    return GestureDetector(
      onTap: app.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size ?? 66,
            height: size ?? 66,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [app.baseColor, app.baseColor.withValues(alpha: 0.7)],
              ),
              borderRadius: BorderRadius.circular(size == null ? 15 : 13),
              boxShadow: [
                BoxShadow(
                  color: app.baseColor.withValues(alpha: 0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(child: icon),
          ),
          const SizedBox(height: 6),
          Text(
            app.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              shadows: [Shadow(color: Colors.black, blurRadius: 3)],
            ),
          ),
        ],
      ),
    );
  }
}

class _IOSStatusBar extends StatelessWidget {
  final bool isDark;

  const _IOSStatusBar({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final color = isDark ? Colors.white : Colors.black;
    final time = DateFormat('H:mm').format(DateTime.now());
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 4,
        bottom: 6,
      ),
      child: Row(
        children: [
          const SizedBox(width: 22),
          Text(
            time,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          const Icon(Icons.signal_cellular_alt, size: 15, color: Colors.white),
          const SizedBox(width: 6),
          const Icon(Icons.wifi_rounded, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Icon(Icons.battery_full_rounded, size: 18, color: Colors.white),
          const SizedBox(width: 22),
        ],
      ),
    );
  }
}

class _HomeIndicator extends StatelessWidget {
  const _HomeIndicator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 6),
      child: Container(
        width: 130,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}