import 'package:flutter/material.dart';
import 'package:my_news_app/models/blogs_model.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogDetailsPage extends StatelessWidget {
  final Blog blog;

  const BlogDetailsPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Подробности блога'),
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
                    image: blog.imageUrl.startsWith('assets/')
                        ? AssetImage(blog.imageUrl) as ImageProvider
                        : NetworkImage(blog.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(blog.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(blog.content, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _launchURL(blog.id),
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
    final Uri uri = Uri.parse('https://blog-source.com/$id');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
