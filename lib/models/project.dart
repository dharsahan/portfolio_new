class Project {
  final String title;
  final String description;
  final String image;
  final double progress; // 0.0 to 1.0
  final bool isCompleted;
  final List<String> technologies;

  Project({
    required this.title,
    required this.description,
    required this.image,
    this.progress = 1.0,
    this.isCompleted = true,
    required this.technologies,
  });
}
