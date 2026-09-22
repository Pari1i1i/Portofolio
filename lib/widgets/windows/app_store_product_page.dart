import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/url_helper.dart';
import '../../data/models/project_model.dart';
import '../../data/portfolio_data.dart';
import '../../state/window_manager.dart';
import '../common/image_placeholder.dart';

class AppStoreProductPage extends StatelessWidget {
  final ProjectModel project;
  final WindowManager windowManager;

  const AppStoreProductPage({
    super.key,
    required this.project,
    required this.windowManager,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = windowManager.isDarkMode;
    final bg = isDark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
    final titleColor = isDark ? Colors.white : AppColors.textPrimaryLight;
    final subColor =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final accent = Color(project.accentColor);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_rounded, size: 30),
          color: AppColors.accentBlue,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'App Store',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 4, 18, 40),
        children: [
          // ---- Header (icon + title + rating + CTA) ----
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AppIconSquare(project: project, size: 96),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      project.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13, color: subColor),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          project.category,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.accentBlue,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.circle, size: 4, color: Colors.grey),
                        const SizedBox(width: 8),
                        _Stars(rating: project.rating),
                        const SizedBox(width: 4),
                        Text(
                          project.rating.toStringAsFixed(1),
                          style: TextStyle(fontSize: 12, color: subColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // CTA buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => UrlHelper.openUrl(project.githubUrl),
                  icon: const FaIcon(FontAwesomeIcons.github, size: 16),
                  label: const Text(
                    'Open GitHub',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentBlue,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey,
                    minimumSize: const Size.fromHeight(42),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => UrlHelper.openEmail(
                    'fachriachmad575@gmail.com?subject=${project.title}',
                  ),
                  icon: const Icon(Icons.mail_outline_rounded, size: 16),
                  label: const Text(
                    'Contact',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.accentBlue,
                    side: BorderSide(color: AppColors.accentBlue, width: 1.2),
                    minimumSize: const Size.fromHeight(42),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // ---- Section Title ----
          _sectionTitle('Screenshots', titleColor),
          const SizedBox(height: 10),
          _ScreenshotsRow(project: project, isDark: isDark),
          const SizedBox(height: 28),

          _sectionTitle('Deskripsi', titleColor),
          const SizedBox(height: 8),
          Text(
            project.description,
            style: TextStyle(fontSize: 13.5, height: 1.55, color: subColor),
          ),
          const SizedBox(height: 28),

          // ---- My Role ----
          _sectionTitle('Peran Saya', titleColor),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: isDark ? 0.18 : 0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: accent.withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.engineering_rounded, color: accent, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.role,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: titleColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Saya membangun dan merancang seluruh produk ini.',
                        style: TextStyle(fontSize: 12, color: subColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // ---- Key Features ----
          _sectionTitle('Fitur Utama', titleColor),
          const SizedBox(height: 10),
          ...project.keyFeatures.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    size: 18,
                    color: AppColors.accentGreen,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      f,
                      style: TextStyle(fontSize: 13, height: 1.4, color: subColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),

          // ---- Information ----
          _sectionTitle('Informasi', titleColor),
          const SizedBox(height: 4),
          _infoRow('Kategori', project.category, titleColor, subColor),
          _divider(isDark),
          _infoRow('Role', project.role, titleColor, subColor),
          _divider(isDark),
          _infoRow(
            'Rating',
            '${project.rating.toStringAsFixed(1)} ★',
            titleColor,
            subColor,
          ),
          _divider(isDark),
          _infoRow(
            'Platform',
            project.category.contains('Mobile') ? 'iOS · Android' : 'Web',
            titleColor,
            subColor,
          ),
          _divider(isDark),
          _infoRow('Repository', project.githubUrl, titleColor, subColor),
          const SizedBox(height: 16),

          // Tech chips
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.techStack.map(
              (t) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFE9E9EB),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  t,
                  style: TextStyle(fontSize: 11, color: subColor),
                ),
              ),
            ).toList(),
          ),
          const SizedBox(height: 28),

          // ---- More projects ----
          _sectionTitle('Proyek Lainnya', titleColor),
          const SizedBox(height: 10),
          SizedBox(
            height: 110,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: PortfolioData.projects.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final p = PortfolioData.projects[index];
                if (p.id == project.id) return const SizedBox.shrink();
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => AppStoreProductPage(
                          project: p,
                          windowManager: windowManager,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _AppIconSquare(project: p, size: 64),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: 64,
                        child: Text(
                          p.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10, color: subColor),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  Widget _divider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 0.5,
      color: isDark ? const Color(0x33FFFFFF) : const Color(0x22000000),
    );
  }

  Widget _infoRow(String label, String value, Color titleColor, Color subColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: subColor),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: titleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppIconSquare extends StatelessWidget {
  final ProjectModel project;
  final double size;

  const _AppIconSquare({required this.project, required this.size});

  @override
  Widget build(BuildContext context) {
    final accent = Color(project.accentColor);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size * 0.22),
        border: Border.all(color: const Color(0x22000000), width: 0.5),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: (project.logoPath == null || project.logoPath!.isEmpty)
            ? Text(
                project.title.isEmpty ? 'P' : project.title[0].toUpperCase(),
                style: TextStyle(
                  fontSize: size * 0.45,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              )
            : SafeAssetImage(
                assetPath: project.logoPath!,
                width: size * 0.88,
                height: size * 0.88,
                fit: BoxFit.contain,
                fallbackTitle: project.title,
                fallbackIcon: Icons.apps_rounded,
              ),
      ),
    );
  }
}

class _Stars extends StatelessWidget {
  final double rating;

  const _Stars({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final filled = rating >= i + 0.75;
        final half = rating >= i + 0.25 && !filled;
        return Icon(
          filled
              ? Icons.star_rounded
              : (half ? Icons.star_half_rounded : Icons.star_outline_rounded),
          size: 13,
          color: const Color(0xFFFF9F0A),
        );
      }),
    );
  }
}

class _ScreenshotsRow extends StatelessWidget {
  final ProjectModel project;
  final bool isDark;

  const _ScreenshotsRow({required this.project, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final shots = project.screenshots.isEmpty
        ? [project.imagePath]
        : project.screenshots;
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: shots.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final label = index == 0 ? 'Tampilan Utama' : 'Tampilan ${index + 1}';
          final assetPath = shots[index];
          return GestureDetector(
            onTap: () => _openScreenshotViewer(context, assetPath, label),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 128,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isDark ? const Color(0x33FFFFFF) : const Color(0x22000000),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    SafeAssetImage(
                      assetPath: assetPath,
                      fit: BoxFit.cover,
                      fallbackTitle: project.title,
                      fallbackIcon: Icons.screenshot_rounded,
                    ),
                    // iPhone notch pill
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 6),
                        width: 44,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                        ),
                        child: Text(
                          label,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _openScreenshotViewer(BuildContext context, String assetPath, String label) {
    final size = MediaQuery.of(context).size;
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: size.width - 16,
                height: size.height - 60,
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 4,
                  child: Center(
                    child: SafeAssetImage(
                      assetPath: assetPath,
                      fit: BoxFit.contain,
                      fallbackTitle: label,
                      fallbackIcon: Icons.screenshot_rounded,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: Material(
                color: Colors.black54,
                shape: const CircleBorder(),
                child: IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white),
                  onPressed: () => Navigator.of(dialogContext).pop(),
                ),
              ),
            ),
            Positioned(
              top: 18,
              left: 18,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}