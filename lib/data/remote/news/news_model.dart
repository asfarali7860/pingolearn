// ignore_for_file: invalid_annotation_target, depend_on_referenced_packages

import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_model.freezed.dart';
part 'news_model.g.dart';

NewsResponseModel newsResponseModelFromJson(String str) => NewsResponseModel.fromJson(json.decode(str));

String newsResponseModelToJson(NewsResponseModel data) => json.encode(data.toJson());

@freezed
class NewsResponseModel with _$NewsResponseModel {
    const factory NewsResponseModel({
        @JsonKey(name: "status")
        String? status,
        @JsonKey(name: "totalResults")
        int? totalResults,
        @JsonKey(name: "articles")
        List<Article>? articles,
    }) = _NewsResponseModel;

    factory NewsResponseModel.fromJson(Map<String, dynamic> json) => _$NewsResponseModelFromJson(json);
}

@freezed
class Article with _$Article {
    const factory Article({
        @JsonKey(name: "source")
        Source? source,
        @JsonKey(name: "author")
        String? author,
        @JsonKey(name: "title")
        String? title,
        @JsonKey(name: "description")
        String? description,
        @JsonKey(name: "url")
        String? url,
        @JsonKey(name: "urlToImage")
        String? urlToImage,
        @JsonKey(name: "publishedAt")
        String? publishedAt,
        @JsonKey(name: "content")
        String? content,
    }) = _Article;

    factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
}

@freezed
class Source with _$Source {
    const factory Source({
        @JsonKey(name: "id")
        String? id,
        @JsonKey(name: "name")
        String? name,
    }) = _Source;

    factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
}
