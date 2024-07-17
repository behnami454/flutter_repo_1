import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_news_app/models/news_model.dart';
import 'package:my_news_app/repositories/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc({required this.newsRepository}) : super(NewsInitial()) {
    on<FetchNews>(_onFetchNews);
    on<RefreshNews>(_onRefreshNews);
  }

  void _onFetchNews(FetchNews event, Emitter<NewsState> emit) async {
    try {
      final currentState = state;
      List<News> oldNews = [];
      if (currentState is NewsLoaded && event.page != 1) {
        oldNews = currentState.news;
      }
      if (event.page == 1) {
        emit(NewsLoading());
      }

      final news = await newsRepository.fetchNews(event.page, query: event.query);
      final hasReachedMax = news.isEmpty;

      emit(NewsLoaded(news: oldNews + news, hasReachedMax: hasReachedMax));
    } catch (e) {
      emit(NewsError(message: e.toString()));
    }
  }

  void _onRefreshNews(RefreshNews event, Emitter<NewsState> emit) async {
    try {
      emit(NewsInitial());
      final news = await newsRepository.fetchNews(1, query: event.query);
      emit(NewsLoaded(news: news, hasReachedMax: news.isEmpty));
    } catch (e) {
      emit(NewsError(message: e.toString()));
    }
  }
}
