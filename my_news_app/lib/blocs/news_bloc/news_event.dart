part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class FetchNews extends NewsEvent {
  final int page;
  final String query;

  const FetchNews({required this.page, this.query = ''});

  @override
  List<Object> get props => [page, query];
}

class RefreshNews extends NewsEvent {
  final String query;

  const RefreshNews({this.query = ''});

  @override
  List<Object> get props => [query];
}
