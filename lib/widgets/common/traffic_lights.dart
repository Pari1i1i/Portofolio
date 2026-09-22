import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class TrafficLights extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback onMinimize;
  final VoidCallback onMaximize;
  final bool isMaximized;

  const TrafficLights({
    super.key,
    required this.onClose,
    required this.onMinimize,
    required this.onMaximize,
    this.isMaximized = false,
  });

  @override
  State<TrafficLights> createState() => _TrafficLightsState();
}

class _TrafficLightsState extends State<TrafficLights> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close button (Red)
          _buildDot(
            color: AppColors.macRed,
            borderColor: AppColors.macRedBorder,
            icon: Icons.close_rounded,
            iconSize: 8,
            onTap: widget.onClose,
          ),
          const SizedBox(width: 8),
          // Minimize button (Yellow)
          _buildDot(
            color: AppColors.macYellow,
            borderColor: AppColors.macYellowBorder,
            icon: Icons.remove_rounded,
            iconSize: 9,
            onTap: widget.onMinimize,
          ),
          const SizedBox(width: 8),
          // Maximize button (Green)
          _buildDot(
            color: AppColors.macGreen,
            borderColor: AppColors.macGreenBorder,
            icon: widget.isMaximized ? Icons.close_fullscreen_rounded : Icons.open_in_full_rounded,
            iconSize: 7,
            onTap: widget.onMaximize,
          ),
        ],
      ),
    );
  }

  Widget _buildDot({
    required Color color,
    required Color borderColor,
    required IconData icon,
    required double iconSize,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        width: 12.5,
        height: 12.5,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: 0.8),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: _isHovered ? 0.85 : 0.0,
            child: Icon(
              icon,
              size: iconSize,
              color: const Color(0xFF330000),
            ),
          ),
        ),
      ),
    );
  }
}
