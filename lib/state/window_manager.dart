import 'dart:math';
import 'package:flutter/material.dart';
import '../core/constants/app_assets.dart';
import '../data/models/window_model.dart';

class WindowManager extends ChangeNotifier {
  final Map<WindowType, WindowItem> _windows = {};
  WindowType? _activeWindow;
  int _topZIndex = 1;

  // Global UI states
  bool _isDarkMode = true;
  String _currentWallpaper = AppAssets.wallpaperMacDark;
  bool _isControlCenterOpen = false;
  bool _isSpotlightOpen = false;
  bool _isAppleMenuOpen = false;
  String? _activeFinderFolder; // 'akademik' or 'partisipan' or null

  // System controls
  double _volume = 0.8;
  double _brightness = 0.9;
  bool _wifiEnabled = true;
  bool _bluetoothEnabled = true;

  // Getters
  Map<WindowType, WindowItem> get windows => _windows;
  List<WindowItem> get windowList {
    final list = _windows.values.toList();
    list.sort((a, b) => a.zIndex.compareTo(b.zIndex));
    return list;
  }

  WindowType? get activeWindow => _activeWindow;
  bool get isDarkMode => _isDarkMode;
  String get currentWallpaper => _currentWallpaper;
  bool get isControlCenterOpen => _isControlCenterOpen;
  bool get isSpotlightOpen => _isSpotlightOpen;
  bool get isAppleMenuOpen => _isAppleMenuOpen;
  String? get activeFinderFolder => _activeFinderFolder;

  double get volume => _volume;
  double get brightness => _brightness;
  bool get wifiEnabled => _wifiEnabled;
  bool get bluetoothEnabled => _bluetoothEnabled;

  bool isWindowOpen(WindowType type) => _windows.containsKey(type);
  bool isWindowMinimized(WindowType type) => _windows[type]?.isMinimized ?? false;
  bool isWindowActive(WindowType type) => _activeWindow == type;

  void openWindow(
    WindowType type, {
    Size? screenSize,
    String? subFolder,
  }) {
    closeOverlays();
    _activeFinderFolder = subFolder;

    if (_windows.containsKey(type)) {
      // If already open, restore if minimized and bring to front
      final item = _windows[type]!;
      item.isMinimized = false;
      bringToFront(type);
      notifyListeners();
      return;
    }

    // Calculate default center position
    final sSize = screenSize ?? const Size(1280, 800);
    final defSize = type.defaultSize;

    // Responsive check: if screen is smaller than default window, fit screen
    final width = min(defSize.width, max(320.0, sSize.width - 40));
    final height = min(defSize.height, max(400.0, sSize.height - 140));

    // Stagger new window position slightly
    final offsetMultiplier = (_windows.length % 5) * 24.0;
    final left = max(16.0, ((sSize.width - width) / 2) + offsetMultiplier);
    final top = max(40.0, ((sSize.height - height) / 2) - 20 + offsetMultiplier);

    _topZIndex++;
    final item = WindowItem(
      type: type,
      position: Offset(left, top),
      size: Size(width, height),
      zIndex: _topZIndex,
    );

    _windows[type] = item;
    _activeWindow = type;
    notifyListeners();
  }

  void closeWindow(WindowType type) {
    if (_windows.containsKey(type)) {
      _windows.remove(type);
      if (_activeWindow == type) {
        if (_windows.isNotEmpty) {
          // Set new active window to highest z-index
          final remaining = _windows.values.toList();
          remaining.sort((a, b) => b.zIndex.compareTo(a.zIndex));
          _activeWindow = remaining.first.type;
        } else {
          _activeWindow = null;
        }
      }
      notifyListeners();
    }
  }

  void minimizeWindow(WindowType type) {
    if (_windows.containsKey(type)) {
      _windows[type]!.isMinimized = true;
      if (_activeWindow == type) {
        final activeRemaining = _windows.values
            .where((w) => !w.isMinimized && w.type != type)
            .toList();
        if (activeRemaining.isNotEmpty) {
          activeRemaining.sort((a, b) => b.zIndex.compareTo(a.zIndex));
          _activeWindow = activeRemaining.first.type;
        } else {
          _activeWindow = null;
        }
      }
      notifyListeners();
    }
  }

  void toggleMaximize(WindowType type, {Size? screenSize}) {
    if (_windows.containsKey(type)) {
      final item = _windows[type]!;
      item.isMaximized = !item.isMaximized;
      bringToFront(type);
      notifyListeners();
    }
  }

  void bringToFront(WindowType type) {
    if (_windows.containsKey(type)) {
      _topZIndex++;
      _windows[type]!.zIndex = _topZIndex;
      _activeWindow = type;
      notifyListeners();
    }
  }

  void updatePosition(WindowType type, Offset newPos) {
    if (_windows.containsKey(type)) {
      _windows[type]!.position = newPos;
      notifyListeners();
    }
  }

  void updateSize(WindowType type, Size newSize) {
    if (_windows.containsKey(type)) {
      // Min size constraints
      const minW = 320.0;
      const minH = 260.0;
      _windows[type]!.size = Size(
        max(minW, newSize.width),
        max(minH, newSize.height),
      );
      notifyListeners();
    }
  }

  // System Overlays
  void toggleControlCenter() {
    _isControlCenterOpen = !_isControlCenterOpen;
    if (_isControlCenterOpen) {
      _isSpotlightOpen = false;
      _isAppleMenuOpen = false;
    }
    notifyListeners();
  }

  void toggleSpotlight() {
    _isSpotlightOpen = !_isSpotlightOpen;
    if (_isSpotlightOpen) {
      _isControlCenterOpen = false;
      _isAppleMenuOpen = false;
    }
    notifyListeners();
  }

  void toggleAppleMenu() {
    _isAppleMenuOpen = !_isAppleMenuOpen;
    if (_isAppleMenuOpen) {
      _isControlCenterOpen = false;
      _isSpotlightOpen = false;
    }
    notifyListeners();
  }

  void closeOverlays() {
    if (_isControlCenterOpen || _isSpotlightOpen || _isAppleMenuOpen) {
      _isControlCenterOpen = false;
      _isSpotlightOpen = false;
      _isAppleMenuOpen = false;
      notifyListeners();
    }
  }

  void setWallpaper(String wallpaperPath) {
    _currentWallpaper = wallpaperPath;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setVolume(double val) {
    _volume = val.clamp(0.0, 1.0);
    notifyListeners();
  }

  void setBrightness(double val) {
    _brightness = val.clamp(0.1, 1.0);
    notifyListeners();
  }

  void toggleWifi() {
    _wifiEnabled = !_wifiEnabled;
    notifyListeners();
  }

  void toggleBluetooth() {
    _bluetoothEnabled = !_bluetoothEnabled;
    notifyListeners();
  }

  void setFinderFolder(String? folder) {
    _activeFinderFolder = folder;
    notifyListeners();
  }
}
