import 'package:http/http.dart' as http;
import 'package:News/models/news.dart';
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
          News news = News.fromJson(element);
          allNews.add(news);
        }
      });
    }
  }
}
