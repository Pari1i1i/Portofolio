import 'package:flutter/material.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'screens/desktop_screen.dart';
import 'screens/ios_home_screen.dart';
import 'state/window_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  final WindowManager _windowManager = WindowManager();

  @override
  void dispose() {
    _windowManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _windowManager,
      builder: (context, child) {
        return MaterialApp(
          title: AppStrings.appTitle,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _windowManager.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: _ResponsiveShell(windowManager: _windowManager),
        );
      },
    );
  }
}

class _ResponsiveShell extends StatelessWidget {
  final WindowManager windowManager;

  const _ResponsiveShell({required this.windowManager});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;
        return isMobile
            ? IOSHomeScreen(windowManager: windowManager)
            : DesktopScreen(windowManager: windowManager);
      },
    );
  }
}
