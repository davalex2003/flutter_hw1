import 'package:flutter/material.dart';
import '../providers/news_provider.dart';
import '../models/news.dart';
import 'news_description.dart';
import 'package:hw1/providers/themes_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _isDark = false;
  List<News> news = [];
  bool _loading = true;
  ThemeMode _currentThemeMode = ThemeMode.light;

  void getNews() async {
    NewsProvider provider = NewsProvider();
    await provider.getNews();
    news = provider.allNews;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _currentThemeMode == ThemeMode.light ? lightTheme : darkTheme,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: () {
                final newMode = !_isDark;
                setState(() {
                  _isDark = newMode;
                  _currentThemeMode = _currentThemeMode == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
                });
              },
              icon: Icon(
                _isDark ? Icons.sunny : Icons.nightlight_round,
              ),
            ),
          ],
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("Davidenko", style: (TextStyle(color: Colors.red))),
              Text("News", style: (TextStyle(color: Colors.amberAccent)))
            ],
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: _loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              )
            : ListView.builder(
                itemCount: news.length * 2 - 1,
                itemBuilder: (context, index) {
                  if (index.isOdd) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(),
                    );
                  } else {
                    final newsIndex = index ~/ 2;
                    News currentNews = news[newsIndex];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(currentNews.urlToImage),
                        radius: 30,
                      ),
                      title: Text(
                        currentNews.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      subtitle: Text(
                        currentNews.author,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDescriptionPage(
                              news: currentNews,
                              currentThemeMode: _currentThemeMode,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
      ),
    );
  }
}
