import 'package:flutter/material.dart';
import 'package:my_news_app/screens/about_screen.dart';
import 'package:my_news_app/screens/blogs_screen.dart';
import 'package:my_news_app/screens/news_screen.dart';

class NavigationBars extends StatefulWidget {
  const NavigationBars({Key? key}) : super(key: key);

  @override
  State<NavigationBars> createState() => _NavigationBarsState();
}

class _NavigationBarsState extends State<NavigationBars> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const NewsPage(),
    const BlogsPage(),
    const AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Новости',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Блоги',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'О',
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
