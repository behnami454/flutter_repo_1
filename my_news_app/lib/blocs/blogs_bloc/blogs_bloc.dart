import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_news_app/models/blogs_model.dart';
import 'package:my_news_app/repositories/blogs_repository.dart';

part 'blogs_event.dart';
part 'blogs_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogRepository blogRepository;

  BlogBloc({required this.blogRepository}) : super(BlogInitial()) {
    on<FetchBlogs>(_onFetchBlogs);
    on<RefreshBlogs>(_onRefreshBlogs);
  }

  void _onFetchBlogs(FetchBlogs event, Emitter<BlogState> emit) async {
    try {
      final currentState = state;
      List<Blog> oldBlogs = [];
      if (currentState is BlogLoaded && event.page != 1) {
        oldBlogs = currentState.blogs;
      }
      if (event.page == 1) {
        emit(BlogLoading());
      }

      final blogs = await blogRepository.fetchBlogs(event.page, query: event.query);
      final hasReachedMax = blogs.isEmpty;

      emit(BlogLoaded(blogs: oldBlogs + blogs, hasReachedMax: hasReachedMax));
    } catch (e) {
      emit(BlogError(message: e.toString()));
    }
  }

  void _onRefreshBlogs(RefreshBlogs event, Emitter<BlogState> emit) async {
    try {
      emit(BlogInitial());
      final blogs = await blogRepository.fetchBlogs(1, query: event.query);
      emit(BlogLoaded(blogs: blogs, hasReachedMax: blogs.isEmpty));
    } catch (e) {
      emit(BlogError(message: e.toString()));
    }
  }
}
