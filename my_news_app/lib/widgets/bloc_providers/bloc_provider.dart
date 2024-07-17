import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/blocs/blogs_bloc/blogs_bloc.dart';
import 'package:my_news_app/blocs/news_bloc/news_bloc.dart';

import 'package:my_news_app/services/service_locator.dart';
import 'package:my_news_app/widgets/ui/navigation_bar.dart';

class BlocProviderPage extends StatelessWidget {
  const BlocProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (context) => getIt<NewsBloc>()..add(const FetchNews(page: 1)),
        ),
        BlocProvider<BlogBloc>(
          create: (context) => getIt<BlogBloc>()..add(const FetchBlogs(page: 1)),
        ),
      ],
      child: const NavigationBars(),
    );
  }
}
