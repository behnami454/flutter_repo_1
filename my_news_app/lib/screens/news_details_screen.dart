import 'package:flutter/material.dart';
import 'package:my_news_app/models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsPage extends StatelessWidget {
  final News news;

  const NewsDetailsPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Подробности новостей'),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: news.imageUrl.startsWith('assets/')
                        ? AssetImage(news.imageUrl) as ImageProvider
                        : NetworkImage(news.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(news.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(news.content, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _launchURL(news.id),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blueGrey, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Читать далее'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String id) async {
    final Uri uri = Uri.parse('https://news-source.com/$id');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
