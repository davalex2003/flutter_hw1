import 'package:flutter/material.dart';
import 'package:News/l10n/locale_provider.dart';
import 'package:provider/provider.dart';
import '../l10n/all_locales.dart';
import '../providers/news_provider.dart';
import '../models/news.dart';
import 'news_description.dart';
import 'package:News/providers/themes_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: InkResponse(
                child: Text(Provider.of<LocaleProvider>(context, listen: false)
                    .locale
                    .languageCode
                    .toUpperCase()),
                onTap: () {
                  if (Provider.of<LocaleProvider>(context, listen: false)
                          .locale
                          .languageCode
                          .toUpperCase() ==
                      "EN") {
                    Provider.of<LocaleProvider>(context, listen: false)
                        .setLocale(AllLocale.all[0]);
                  } else {
                    Provider.of<LocaleProvider>(context, listen: false)
                        .setLocale(AllLocale.all[1]);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
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
            ),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(AppLocalizations.of(context)!.title_1,
                  style: (const TextStyle(color: Colors.red))),
              Text(AppLocalizations.of(context)!.title_2,
                  style: (const TextStyle(color: Colors.amberAccent)))
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
