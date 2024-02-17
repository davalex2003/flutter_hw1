import 'package:http/http.dart' as http;
import 'package:hw1/models/news.dart';
import 'dart:convert';

class NewsProvider {
  List<News> allNews = [];

  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=844ade3f23cf4a888c5923193b9ee28c";

    var response = await http.get((Uri.parse(url)));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          News news = News(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          allNews.add(news);
        }
      });
    }
  }
}
