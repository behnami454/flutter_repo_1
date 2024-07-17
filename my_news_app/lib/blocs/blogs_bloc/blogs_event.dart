part of 'blogs_bloc.dart';

abstract class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object> get props => [];
}

class FetchBlogs extends BlogEvent {
  final int page;
  final String query;

  const FetchBlogs({required this.page, this.query = ''});

  @override
  List<Object> get props => [page, query];
}

class RefreshBlogs extends BlogEvent {
  final String query;

  const RefreshBlogs({this.query = ''});

  @override
  List<Object> get props => [query];
}
