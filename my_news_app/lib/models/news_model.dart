class News {
  final String id;
  final String title;
  final String content;
  final String imageUrl;

  News({required this.id, required this.title, required this.content, required this.imageUrl});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      content: json['summary'] ?? '',
      imageUrl: json['image_url'] ?? 'https://via.placeholder.com/150',
    );
  }
}
