import 'package:flutter/material.dart';
import '../models/news.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hw1/providers/themes_provider.dart';

class NewsDescriptionPage extends StatelessWidget {
  final News news;

  final ThemeMode currentThemeMode;

  const NewsDescriptionPage(
      {super.key, required this.news, required this.currentThemeMode});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: currentThemeMode == ThemeMode.light ? lightTheme : darkTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("Davidenko", style: (TextStyle(color: Colors.red))),
              Text("News", style: (TextStyle(color: Colors.amberAccent)))
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                news.title.split('|')[0],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  news.author,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  news.publishedAt.toString().split('.')[0],
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(height: 16),
              Image.network(
                news.urlToImage,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(
                news.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  _launchURL(news.articleUrl);
                },
                child: const Text(
                  "Перейти к новости",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(newsUrl) async {
    final Uri url = Uri.parse(newsUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
