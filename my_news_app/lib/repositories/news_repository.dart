import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_news_app/models/news_model.dart';

class NewsRepository {
  final String apiUrl = 'https://api.spaceflightnewsapi.net/v4/articles';

  Future<List<News>> fetchNews(int page, {String query = ''}) async {
    final response = await http.get(Uri.parse('$apiUrl?_limit=10&_start=${(page - 1) * 10}&title_contains=$query'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['results'];
      return jsonResponse.map((news) => News.fromJson(news)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
