part of 'blogs_bloc.dart';

abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<Blog> blogs;
  final bool hasReachedMax;

  const BlogLoaded({required this.blogs, required this.hasReachedMax});

  BlogLoaded copyWith({
    List<Blog>? blogs,
    bool? hasReachedMax,
  }) {
    return BlogLoaded(
      blogs: blogs ?? this.blogs,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [blogs, hasReachedMax];
}

class BlogError extends BlogState {
  final String message;

  const BlogError({required this.message});

  @override
  List<Object> get props => [message];
}
