import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/achievement_model.dart';
import '../../data/portfolio_data.dart';
import '../../state/window_manager.dart';
import '../common/image_placeholder.dart';

class AchievementsWindow extends StatefulWidget {
  final WindowManager windowManager;

  const AchievementsWindow({super.key, required this.windowManager});

  @override
  State<AchievementsWindow> createState() => _AchievementsWindowState();
}

class _AchievementsWindowState extends State<AchievementsWindow> {
  AchievementCategory? _selectedCategory; // null = all
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Check if initial folder requested
    if (widget.windowManager.activeFinderFolder == 'akademik') {
      _selectedCategory = AchievementCategory.akademik;
    } else if (widget.windowManager.activeFinderFolder == 'partisipan') {
      _selectedCategory = AchievementCategory.partisipan;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.windowManager.isDarkMode;

    final filtered = PortfolioData.achievements.where((ach) {
      final matchesCat = _selectedCategory == null || ach.category == _selectedCategory;
      final matchesSearch = ach.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          ach.organizer.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          ach.badgeText.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          ach.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCat && matchesSearch;
    }).toList();

    return Row(
      children: [
        // Left Finder-style Sidebar
        Container(
          width: 200,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF18181A) : const Color(0xFFE4E4E8),
            border: Border(
              right: BorderSide(
                color: isDark ? const Color(0x22FFFFFF) : const Color(0x18000000),
                width: 0.8,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
                child: Text(
                  'CATEGORIES',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                    color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                  ),
                ),
              ),
              _buildSidebarItem(
                title: 'All Achievements',
                icon: Icons.all_inbox_rounded,
                count: PortfolioData.achievements.length,
                isSelected: _selectedCategory == null,
                isDark: isDark,
                onTap: () => setState(() => _selectedCategory = null),
              ),
              _buildSidebarItem(
                title: 'Akademik',
                icon: Icons.school_rounded,
                count: PortfolioData.achievements
                    .where((a) => a.category == AchievementCategory.akademik)
                    .length,
                isSelected: _selectedCategory == AchievementCategory.akademik,
                isDark: isDark,
                onTap: () => setState(() => _selectedCategory = AchievementCategory.akademik),
              ),
              _buildSidebarItem(
                title: 'Partisipan',
                icon: Icons.workspace_premium_rounded,
                count: PortfolioData.achievements
                    .where((a) => a.category == AchievementCategory.partisipan)
                    .length,
                isSelected: _selectedCategory == AchievementCategory.partisipan,
                isDark: isDark,
                onTap: () => setState(() => _selectedCategory = AchievementCategory.partisipan),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Achievement Folder\n(Replaces Packages)',
                  style: TextStyle(
                    fontSize: 10,
                    color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Right Content View
        Expanded(
          child: Column(
            children: [
              // Top Path / Toolbar
              Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    Icon(
                      Icons.folder_shared_rounded,
                      size: 16,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Achievement > ${_selectedCategory?.displayName ?? 'All'}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 180,
                      height: 28,
                      child: TextField(
                        onChanged: (val) => setState(() => _searchQuery = val),
                        style: const TextStyle(fontSize: 11),
                        decoration: InputDecoration(
                          hintText: 'Search certificates...',
                          hintStyle: TextStyle(
                            fontSize: 11,
                            color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                          ),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            size: 14,
                            color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                          ),
                          contentPadding: EdgeInsets.zero,
                          filled: true,
                          fillColor: isDark ? const Color(0xFF28282C) : const Color(0xFFFFFFFF),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Items Grid
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Text(
                          'No achievements found',
                          style: TextStyle(
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                        ),
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          final crossAxisCount = constraints.maxWidth > 700 ? 2 : 1;
                          return GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                              childAspectRatio: crossAxisCount == 1 ? 1.7 : 1.25,
                            ),
                            itemCount: filtered.length,
                            itemBuilder: (context, index) {
                              return _buildAchievementCard(filtered[index], isDark);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSidebarItem({
    required String title,
    required IconData icon,
    required int count,
    required bool isSelected,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.accentBlue.withValues(alpha: 0.18)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected
                    ? AppColors.accentBlue
                    : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? AppColors.accentBlue
                        : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                  ),
                ),
              ),
              Text(
                '$count',
                style: TextStyle(
                  fontSize: 11,
                  color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementCard(AchievementModel item, bool isDark) {
    final isAkademik = item.category == AchievementCategory.akademik;
    final badgeColor = isAkademik ? AppColors.accentBlue : AppColors.accentPurple;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.contentCardDark : AppColors.contentCardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0x22FFFFFF) : const Color(0x18000000),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Certificate Preview Image
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  SafeAssetImage(
                    assetPath: item.certificatePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    fallbackTitle: item.title,
                    fallbackIcon: Icons.workspace_premium_rounded,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.5),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.category.displayName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.year,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Certificate Details
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.badgeText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: badgeColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.organizer,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.35,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () => _showCertificateModal(context, item, isDark),
                      icon: const Icon(Icons.fullscreen_rounded, size: 14),
                      label: const Text('Lihat Sertifikat', style: TextStyle(fontSize: 11)),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCertificateModal(BuildContext context, AchievementModel item, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: isDark ? AppColors.windowBgDark : AppColors.windowBgLight,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 650,
            constraints: const BoxConstraints(maxHeight: 750),
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: (item.category == AchievementCategory.akademik
                                        ? AppColors.accentBlue
                                        : AppColors.accentPurple)
                                    .withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '${item.category.displayName} • ${item.year}',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: item.category == AchievementCategory.akademik
                                      ? AppColors.accentBlue
                                      : AppColors.accentPurple,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        icon: const Icon(Icons.close_rounded),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SafeAssetImage(
                      assetPath: item.certificatePath,
                      height: 320,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      fallbackTitle: item.title,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Penyelenggara: ${item.organizer}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accentBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                  ),
                  if (item.skills.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    Text(
                      'Kompetensi & Keahlian Terkait:',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: item.skills.map((s) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0x28FFFFFF) : const Color(0x15000000),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            s,
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
