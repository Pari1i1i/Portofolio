class ProjectModel {
  final String id;
  final String title;
  final String category;
  final String subtitle;
  final String description;
  final List<String> techStack;
  final String githubUrl;
  final String? demoUrl;
  final String imagePath;
  final List<String> keyFeatures;
  final bool isFeatured;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.category,
    required this.subtitle,
    required this.description,
    required this.techStack,
    required this.githubUrl,
    this.demoUrl,
    required this.imagePath,
    required this.keyFeatures,
    this.isFeatured = true,
  });
}
