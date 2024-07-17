import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('О'),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Об этом приложении',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Это новостное приложение, которое предоставляет последние новости и блоги. Будьте в курсе текущих событий и читайте полезные статьи из разных категорий.',
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
            const SizedBox(height: 30),
            const Text(
              'Разработчик',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.blue),
              title: const Text('Автор'),
              subtitle: const Text('Разработчик Flutter'),
              onTap: () => _launchURL('https://github.com/author'),
              trailing: const Icon(Icons.open_in_new, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ресурсы',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.code, color: Colors.blue),
              title: const Text('Репозиторий GitHub'),
              subtitle: const Text('Посмотреть исходный код на GitHub'),
              onTap: () => _launchURL('https://github.com/repository'),
              trailing: const Icon(Icons.open_in_new, color: Colors.blue),
            ),
            const Spacer(),
            const Center(
              child: Text(
                'Благодарим вас за использование нашего приложения!',
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
