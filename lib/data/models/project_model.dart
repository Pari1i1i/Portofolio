class ProjectModel {
  final String id;
  final String title;
  final String category;
  final String subtitle;
  final String description;
  final String role;
  final int accentColor;
  final double rating;
  final List<String> techStack;
  final String githubUrl;
  final String? demoUrl;
  final String imagePath;
  final String? logoPath;
  final List<String> screenshots;
  final List<String> keyFeatures;
  final bool isFeatured;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.category,
    required this.subtitle,
    required this.description,
    this.role = 'Software Engineer',
    this.accentColor = 0xFF0A84FF,
    this.rating = 4.8,
    required this.techStack,
    required this.githubUrl,
    this.demoUrl,
    required this.imagePath,
    this.logoPath,
    this.screenshots = const [],
    required this.keyFeatures,
    this.isFeatured = true,
  });
}
