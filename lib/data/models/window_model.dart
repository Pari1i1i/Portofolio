import 'package:flutter/material.dart';

enum WindowType {
  about,
  projects,
  achievements,
  contact,
  terminal,
  safari,
  settings,
}

extension WindowTypeExtension on WindowType {
  String get title {
    switch (this) {
      case WindowType.about:
        return 'About Me';
      case WindowType.projects:
        return 'Projects';
      case WindowType.achievements:
        return 'Achievement';
      case WindowType.contact:
        return 'Contact';
      case WindowType.terminal:
        return 'Terminal — zsh';
      case WindowType.safari:
        return 'Safari — Fachri Achmad';
      case WindowType.settings:
        return 'System Settings';
    }
  }

  IconData get icon {
    switch (this) {
      case WindowType.about:
        return Icons.person_rounded;
      case WindowType.projects:
        return Icons.folder_special_rounded;
      case WindowType.achievements:
        return Icons.emoji_events_rounded;
      case WindowType.contact:
        return Icons.mail_rounded;
      case WindowType.terminal:
        return Icons.terminal_rounded;
      case WindowType.safari:
        return Icons.explore_rounded;
      case WindowType.settings:
        return Icons.settings_rounded;
    }
  }

  Size get defaultSize {
    switch (this) {
      case WindowType.about:
        return const Size(820, 560);
      case WindowType.projects:
        return const Size(960, 640);
      case WindowType.achievements:
        return const Size(960, 620);
      case WindowType.contact:
        return const Size(780, 540);
      case WindowType.terminal:
        return const Size(740, 480);
      case WindowType.safari:
        return const Size(920, 600);
      case WindowType.settings:
        return const Size(680, 480);
    }
  }
}

class WindowItem {
  final WindowType type;
  Offset position;
  Size size;
  bool isMinimized;
  bool isMaximized;
  int zIndex;

  WindowItem({
    required this.type,
    required this.position,
    required this.size,
    this.isMinimized = false,
    this.isMaximized = false,
    this.zIndex = 0,
  });
}
