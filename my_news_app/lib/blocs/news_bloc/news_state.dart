part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<News> news;
  final bool hasReachedMax;

  const NewsLoaded({required this.news, required this.hasReachedMax});

  NewsLoaded copyWith({
    List<News>? news,
    bool? hasReachedMax,
  }) {
    return NewsLoaded(
      news: news ?? this.news,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [news, hasReachedMax];
}

class NewsError extends NewsState {
  final String message;

  const NewsError({required this.message});

  @override
  List<Object> get props => [message];
}
