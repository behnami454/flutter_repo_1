import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_news_app/models/blogs_model.dart';

class BlogRepository {
  final String apiUrl = 'https://api.spaceflightnewsapi.net/v4/blogs';

  Future<List<Blog>> fetchBlogs(int page, {String query = ''}) async {
    final response = await http.get(Uri.parse('$apiUrl?_limit=10&_start=${(page - 1) * 10}&title_contains=$query'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['results'];
      return jsonResponse.map((blog) => Blog.fromJson(blog)).toList();
    } else {
      throw Exception('Failed to load blogs');
    }
  }
}
