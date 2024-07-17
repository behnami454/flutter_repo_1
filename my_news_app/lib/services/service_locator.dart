import 'package:get_it/get_it.dart';
import 'package:my_news_app/blocs/blogs_bloc/blogs_bloc.dart';
import 'package:my_news_app/repositories/blogs_repository.dart';
import 'package:my_news_app/repositories/news_repository.dart';

import 'package:my_news_app/blocs/news_bloc/news_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<NewsRepository>(() => NewsRepository());
  getIt.registerFactory<NewsBloc>(() => NewsBloc(newsRepository: getIt<NewsRepository>()));

  getIt.registerLazySingleton<BlogRepository>(() => BlogRepository());
  getIt.registerFactory<BlogBloc>(() => BlogBloc(blogRepository: getIt<BlogRepository>()));
}
