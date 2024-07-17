class Blog {
  final String id;
  final String title;
  final String content;
  final String imageUrl;

  Blog({required this.id, required this.title, required this.content, required this.imageUrl});

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      content: json['summary'] ?? '',
      imageUrl: json['imageUrl'] ?? 'https://via.placeholder.com/150',
    );
  }
}
