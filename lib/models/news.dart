import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  String title;
  String author;
  String description;
  String urlToImage;
  DateTime publishedAt;
  String content;
  String articleUrl;

  News({
    required this.title,
    required this.author,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.articleUrl,
  });

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}