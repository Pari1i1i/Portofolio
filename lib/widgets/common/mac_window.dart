import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/window_model.dart';
import '../../state/window_manager.dart';
import 'traffic_lights.dart';

class MacWindow extends StatelessWidget {
  final WindowItem item;
  final WindowManager windowManager;
  final Widget content;
  final Widget? customHeader;
  final Widget? customSidebar;
  final Size screenSize;

  const MacWindow({
    super.key,
    required this.item,
    required this.windowManager,
    required this.content,
    this.customHeader,
    this.customSidebar,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    if (item.isMinimized) {
      return const SizedBox.shrink();
    }

    final isActive = windowManager.isWindowActive(item.type);
    final isDark = windowManager.isDarkMode;

    // Calculate dimensions
    double left = item.position.dx;
    double top = item.position.dy;
    double width = item.size.width;
    double height = item.size.height;

    if (item.isMaximized) {
      left = 0;
      top = 28.0; // below top menu bar
      width = screenSize.width;
      height = screenSize.height - 28.0 - 74.0; // above dock
    }

    final winBg = isDark
        ? AppColors.windowBgDark.withValues(alpha: 0.88)
        : AppColors.windowBgLight.withValues(alpha: 0.92);

    final headerBg = isDark
        ? AppColors.windowHeaderDark.withValues(alpha: 0.82)
        : AppColors.windowHeaderLight.withValues(alpha: 0.88);

    final borderColor = isDark
        ? (isActive ? const Color(0x55FFFFFF) : const Color(0x22FFFFFF))
        : (isActive ? const Color(0x33000000) : const Color(0x15000000));

    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: GestureDetector(
        onTapDown: (_) => windowManager.bringToFront(item.type),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(item.isMaximized ? 0 : 12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isActive ? 0.45 : 0.25),
                blurRadius: isActive ? 32 : 18,
                offset: const Offset(0, 12),
                spreadRadius: isActive ? 2 : 0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(item.isMaximized ? 0 : 12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: winBg,
                  borderRadius: BorderRadius.circular(item.isMaximized ? 0 : 12),
                  border: Border.all(color: borderColor, width: 0.8),
                ),
                child: Column(
                  children: [
                    // Header Bar / Title Bar
                    GestureDetector(
                      onPanUpdate: item.isMaximized
                          ? null
                          : (details) {
                              final newLeft = (item.position.dx + details.delta.dx)
                                  .clamp(0.0, screenSize.width - 100);
                              final newTop = (item.position.dy + details.delta.dy)
                                  .clamp(28.0, screenSize.height - 100);
                              windowManager.updatePosition(
                                item.type,
                                Offset(newLeft, newTop),
                              );
                            },
                      onDoubleTap: () => windowManager.toggleMaximize(
                        item.type,
                        screenSize: screenSize,
                      ),
                      child: Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: headerBg,
                          border: Border(
                            bottom: BorderSide(
                              color: isDark ? const Color(0x26FFFFFF) : const Color(0x18000000),
                              width: 0.8,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            // Traffic Lights
                            TrafficLights(
                              isMaximized: item.isMaximized,
                              onClose: () => windowManager.closeWindow(item.type),
                              onMinimize: () => windowManager.minimizeWindow(item.type),
                              onMaximize: () => windowManager.toggleMaximize(
                                item.type,
                                screenSize: screenSize,
                              ),
                            ),
                            const SizedBox(width: 14),
                            // App Icon & Title
                            Icon(
                              item.type.icon,
                              size: 16,
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item.type.title,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                  ? (isActive ? AppColors.textPrimaryDark : AppColors.textSecondaryDark)
                                  : (isActive ? AppColors.textPrimaryLight : AppColors.textSecondaryLight),
                              ),
                            ),
                            const Spacer(),
                            if (customHeader != null) customHeader!,
                          ],
                        ),
                      ),
                    ),

                    // Window Body
                    Expanded(
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              if (customSidebar != null) customSidebar!,
                              Expanded(child: content),
                            ],
                          ),

                          // Resize Handle (Bottom Right corner)
                          if (!item.isMaximized)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: GestureDetector(
                                onPanUpdate: (details) {
                                  final newWidth = item.size.width + details.delta.dx;
                                  final newHeight = item.size.height + details.delta.dy;
                                  windowManager.updateSize(
                                    item.type,
                                    Size(newWidth, newHeight),
                                  );
                                },
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.resizeDownRight,
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                    alignment: Alignment.bottomRight,
                                    padding: const EdgeInsets.only(right: 3, bottom: 3),
                                    child: Icon(
                                      Icons.south_east_rounded,
                                      size: 10,
                                      color: isDark
                                          ? Colors.white.withValues(alpha: 0.3)
                                          : Colors.black.withValues(alpha: 0.3),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
