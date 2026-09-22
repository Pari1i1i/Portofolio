import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/url_helper.dart';
import '../../data/models/project_model.dart';
import '../../data/portfolio_data.dart';
import '../../state/window_manager.dart';
import '../common/image_placeholder.dart';

class ProjectsWindow extends StatefulWidget {
  final WindowManager windowManager;

  const ProjectsWindow({super.key, required this.windowManager});

  @override
  State<ProjectsWindow> createState() => _ProjectsWindowState();
}

class _ProjectsWindowState extends State<ProjectsWindow> {
  String _searchQuery = '';
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final isDark = widget.windowManager.isDarkMode;

    final categories = ['All', 'Web Platform', 'Mobile Application', 'Mobile & IoT', 'E-Commerce', 'Real Estate', 'Food & Beverage'];

    final filteredProjects = PortfolioData.projects.where((p) {
      final matchesSearch = p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.techStack.any((t) => t.toLowerCase().contains(_searchQuery.toLowerCase()));

      final matchesCategory = _selectedCategory == 'All' || p.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Column(
      children: [
        // Finder-like Toolbar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E22) : const Color(0xFFEAEAEE),
            border: Border(
              bottom: BorderSide(
                color: isDark ? const Color(0x22FFFFFF) : const Color(0x15000000),
                width: 0.8,
              ),
            ),
          ),
          child: Row(
            children: [
              // Path breadcrumb
              Icon(
                Icons.folder_open_rounded,
                size: 16,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
              const SizedBox(width: 8),
              Text(
                'Showcase / Projects',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.accentBlue.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${PortfolioData.projects.length} Items',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentBlue,
                  ),
                ),
              ),
              const Spacer(),
              // Search field
              SizedBox(
                width: 220,
                height: 32,
                child: TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  style: const TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    hintText: 'Search projects...',
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      size: 16,
                      color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    filled: true,
                    fillColor: isDark ? const Color(0xFF28282C) : const Color(0xFFFFFFFF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Category Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: categories.map((cat) {
              final isSelected = _selectedCategory == cat;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(cat, style: const TextStyle(fontSize: 11)),
                  selected: isSelected,
                  selectedColor: AppColors.accentBlue,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  backgroundColor: isDark ? const Color(0xFF28282C) : const Color(0xFFE5E5EA),
                  onSelected: (_) => setState(() => _selectedCategory = cat),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                ),
              );
            }).toList(),
          ),
        ),

        // Projects Grid
        Expanded(
          child: filteredProjects.isEmpty
              ? Center(
                  child: Text(
                    'No projects match your filter',
                    style: TextStyle(
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                  ),
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth > 780 ? 2 : 1;
                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: crossAxisCount == 1 ? 1.45 : 1.15,
                      ),
                      itemCount: filteredProjects.length,
                      itemBuilder: (context, index) {
                        return _buildProjectCard(filteredProjects[index], isDark);
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildProjectCard(ProjectModel project, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.contentCardDark : AppColors.contentCardLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? const Color(0x22FFFFFF) : const Color(0x18000000),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Image Banner
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  SafeAssetImage(
                    assetPath: project.imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    fallbackTitle: project.title,
                    fallbackIcon: Icons.code_rounded,
                  ),
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.6),
                        ],
                      ),
                    ),
                  ),
                  // Category tag
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.65),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white24, width: 0.6),
                      ),
                      child: Text(
                        project.category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  // Title on image
                  Positioned(
                    left: 12,
                    bottom: 8,
                    right: 12,
                    child: Text(
                      project.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Project Details
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accentBlue,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    project.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.5,
                      height: 1.4,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Tech tags
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: project.techStack.take(3).map((tech) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0x33FFFFFF) : const Color(0x15000000),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tech,
                          style: TextStyle(
                            fontSize: 10,
                            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const Spacer(),
                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () => _showProjectDetailModal(context, project, isDark),
                        icon: const Icon(Icons.info_outline_rounded, size: 14),
                        label: const Text('Detail', style: TextStyle(fontSize: 11)),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => UrlHelper.openUrl(project.githubUrl),
                        icon: const FaIcon(FontAwesomeIcons.github, size: 12),
                        label: const Text('GitHub', style: TextStyle(fontSize: 11)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showProjectDetailModal(BuildContext context, ProjectModel project, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: isDark ? AppColors.windowBgDark : AppColors.windowBgLight,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 600,
            constraints: const BoxConstraints(maxHeight: 700),
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        project.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        icon: const Icon(Icons.close_rounded),
                        iconSize: 20,
                      ),
                    ],
                  ),
                  Text(
                    project.subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accentBlue,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SafeAssetImage(
                      assetPath: project.imagePath,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      fallbackTitle: project.title,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tentang Proyek',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    project.description,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Fitur Utama',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...project.keyFeatures.map((f) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.check_circle_rounded, size: 16, color: AppColors.accentGreen),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                f,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 16),
                  Text(
                    'Teknologi',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: project.techStack.map((tech) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.accentBlue.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.accentBlue.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          tech,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.accentBlue,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => UrlHelper.openUrl(project.githubUrl),
                        icon: const FaIcon(FontAwesomeIcons.github, size: 16),
                        label: const Text('Buka Repository GitHub'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
