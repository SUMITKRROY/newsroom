import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<FetchNewsEvent>((event, emit) async {
      try {
        var request = http.Request('GET', Uri.parse('https://newsapi.org/v2/top-headlines?country=in&apiKey=5fa2471179aa41d3ab630158977248e0'));

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          final List<Map<String, dynamic>> articles = List.from(json.decode(await response.stream.bytesToString())['articles']);
          emit(LoadedNewsState(articles));
        } else {
          emit(ErrorNewsState(response as String));
        }
      } catch (e) {
        emit(ErrorNewsState('Failed to load news: $e'));
      }
    });
  }
}
