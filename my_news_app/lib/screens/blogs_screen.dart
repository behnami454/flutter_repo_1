import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/blocs/blogs_bloc/blogs_bloc.dart';
import 'package:my_news_app/screens/blogs_details_screen.dart';

class BlogsPage extends StatefulWidget {
  const BlogsPage({Key? key}) : super(key: key);

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  int _currentPage = 1;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchBlogs();
  }

  void _fetchBlogs({bool refresh = false}) {
    if (refresh) {
      context.read<BlogBloc>().add(RefreshBlogs(query: _query));
    } else {
      context.read<BlogBloc>().add(FetchBlogs(page: _currentPage, query: _query));
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - _scrollThreshold) {
      final state = context.read<BlogBloc>().state;
      if (state is BlogLoaded && !state.hasReachedMax) {
        _currentPage++;
        _fetchBlogs();
      }
    }
  }

  Future<void> _onRefresh() async {
    _currentPage = 1;
    _fetchBlogs(refresh: true);
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
        title: const Text('Блоги'),
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
                _fetchBlogs(refresh: true);
              },
              decoration: const InputDecoration(
                hintText: 'Поиск...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<BlogBloc, BlogState>(
              builder: (context, state) {
                if (state is BlogInitial || (state is BlogLoading && _currentPage == 1)) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BlogLoaded) {
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: state.blogs.length + (state.hasReachedMax ? 0 : 1),
                      itemBuilder: (context, index) {
                        if (index >= state.blogs.length) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final blog = state.blogs[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          elevation: 4,
                          child: ListTile(
                            leading: _buildImage(blog.imageUrl),
                            title: Text(
                              blog.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              blog.content,
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
                                  builder: (context) => BlogDetailsPage(
                                    blog: blog,
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
                                builder: (context) => BlogDetailsPage(
                                  blog: blog,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is BlogError) {
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
