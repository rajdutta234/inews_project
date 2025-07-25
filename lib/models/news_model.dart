class NewsModel {
  final String title;
  final String image;
  final String description;
  final String time;
  final String location;
  final String summary;
  final String? category;
  final DateTime? dateTime;
  final String? aiSummary;

  NewsModel({
    required this.title,
    required this.image,
    required this.description,
    required this.time,
    required this.location,
    required this.summary,
    this.category,
    this.dateTime,
    this.aiSummary,
  });
}
