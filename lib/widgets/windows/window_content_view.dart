import 'package:flutter/material.dart';
import '../../data/models/window_model.dart';
import '../../state/window_manager.dart';
import 'about_window.dart';
import 'achievements_window.dart';
import 'projects_window.dart';
import 'terminal_window.dart';

class WindowContentView extends StatelessWidget {
  final WindowType type;
  final WindowManager windowManager;

  const WindowContentView({
    super.key,
    required this.type,
    required this.windowManager,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case WindowType.about:
        return AboutWindow(windowManager: windowManager);
      case WindowType.projects:
        return ProjectsWindow(windowManager: windowManager);
      case WindowType.achievements:
        return AchievementsWindow(windowManager: windowManager);
      case WindowType.terminal:
        return TerminalWindow(windowManager: windowManager);
    }
  }
}