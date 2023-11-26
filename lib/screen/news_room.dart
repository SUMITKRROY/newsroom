import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../provider/newsapi/news_bloc.dart';
import 'login.dart';


class NewsRoom extends StatefulWidget {
  const NewsRoom({Key? key}) : super(key: key);

  @override
  State<NewsRoom> createState() => _NewsRoomState();
}

class _NewsRoomState extends State<NewsRoom> {
  Future<void> _logout() async {
    // Clear token from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');

    // Navigate back to login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('News Room'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: _logout,
            ),
          ],
        ),
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsInitial) {
              BlocProvider.of<NewsBloc>(context).add(FetchNewsEvent());
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadingNewsState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedNewsState) {
              final articles = state.articles;
              // Display your articles in the UI
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // You can adjust the number of columns here

                ),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return _buildGridItem(articles[index]);
                },
              );
            } else if (state is ErrorNewsState) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
  Widget _buildGridItem(Map<String, dynamic> article) {
    String imageUrl = article['urlToImage'] ?? 'https://cnopt.tn/wp-content/uploads/2023/06/default-image.jpg';

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () async {
              _launchURL(article['url']);
            },
            child: Container(
              height: 250.0, // You can adjust the image height as needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            article['title'] ?? 'No Title',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                article['author'] ?? 'Unknown Author',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                article['publishedAt'] ?? 'Unknown Date',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }


  // Add this function to launch the URL
  Future<void> _launchURL(String url) async {
    try {
      String encodedUrl = Uri.encodeFull(url);
      await launch(encodedUrl);
    } catch (e) {
      print('Error launching URL: $e');
      // Handle the error, for example, show a snackbar or log the error
    }
  }

}
