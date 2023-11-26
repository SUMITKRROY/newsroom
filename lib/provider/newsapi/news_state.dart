part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class LoadingNewsState extends NewsState {}

class LoadedNewsState extends NewsState {
  final List<Map<String, dynamic>> articles;

  LoadedNewsState(this.articles);
}

class ErrorNewsState extends NewsState {
  final String error;

  ErrorNewsState(this.error);
}
