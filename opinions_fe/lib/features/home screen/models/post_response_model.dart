class PostResponseModel {
  const PostResponseModel({
    required this.title,
    required this.context,
    required this.genre,
    required this.dateTime,
  });

  final String title;
  final String context;
  final String genre;
  final String dateTime;

  factory PostResponseModel.fromJson(Map<String, dynamic> json) {
    return PostResponseModel(
      title: json['title'],
      context: json['context'],
      genre: json['genre'],
      dateTime: json['created_at'],
    );
  }
}
