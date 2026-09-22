enum AchievementCategory {
  akademik,
  partisipan,
}

extension AchievementCategoryExtension on AchievementCategory {
  String get displayName {
    switch (this) {
      case AchievementCategory.akademik:
        return 'Akademik';
      case AchievementCategory.partisipan:
        return 'Partisipan';
    }
  }

  String get folderName {
    switch (this) {
      case AchievementCategory.akademik:
        return 'akademik';
      case AchievementCategory.partisipan:
        return 'partisipan';
    }
  }
}

class AchievementModel {
  final String id;
  final String title;
  final AchievementCategory category;
  final String organizer;
  final String year;
  final String badgeText;
  final String description;
  final String certificatePath;
  final List<String> skills;

  const AchievementModel({
    required this.id,
    required this.title,
    required this.category,
    required this.organizer,
    required this.year,
    required this.badgeText,
    required this.description,
    required this.certificatePath,
    this.skills = const [],
  });
}
