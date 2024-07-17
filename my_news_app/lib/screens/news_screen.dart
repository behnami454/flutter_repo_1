import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/blocs/news_bloc/news_bloc.dart';
import 'package:my_news_app/screens/news_details_screen.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  int _currentPage = 1;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchNews();
  }

  void _fetchNews({bool refresh = false}) {
    if (refresh) {
      context.read<NewsBloc>().add(RefreshNews(query: _query));
    } else {
      context.read<NewsBloc>().add(FetchNews(page: _currentPage, query: _query));
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - _scrollThreshold) {
      final state = context.read<NewsBloc>().state;
      if (state is NewsLoaded && !state.hasReachedMax) {
        _currentPage++;
        _fetchNews();
      }
    }
  }

  Future<void> _onRefresh() async {
    _currentPage = 1;
    _fetchNews(refresh: true);
  }

  Widget _buildImage(String imageUrl) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 1),
        image: DecorationImage(
          image: imageUrl.startsWith('assets/')
              ? AssetImage(imageUrl) as ImageProvider
              : NetworkImage(imageUrl),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новости'),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _query = value;
                  _currentPage = 1;
                });
                _fetchNews(refresh: true);
              },
              decoration: const InputDecoration(
                hintText: 'Поиск...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsInitial || (state is NewsLoading && _currentPage == 1)) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NewsLoaded) {
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: state.news.length + (state.hasReachedMax ? 0 : 1),
                      itemBuilder: (context, index) {
                        if (index >= state.news.length) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final news = state.news[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          elevation: 4,
                          child: ListTile(
                            leading: _buildImage(news.imageUrl),
                            title: Text(
                              news.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              news.content,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsDetailsPage(
                                    news: news,
                                  ),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blueGrey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: const Text('Подробности'),
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetailsPage(
                                  news: news,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is NewsError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, color: Colors.red, size: 64),
                        const SizedBox(height: 16),
                        const Text(
                          'ошибка',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _onRefresh,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text('Повторить попытку'),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
