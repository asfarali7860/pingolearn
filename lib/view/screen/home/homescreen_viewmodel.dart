import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pingolearn/data/remote/news/news_model.dart';

class HomeScreenViewModel extends ChangeNotifier {
  List<Article> articleList = [];
  NewsResponseModel newsResponseModel = const NewsResponseModel();
  final Dio dio = Dio();
  bool isLoading = false;

  Future<void> fetchNewsData(String code) async {
    isLoading = true;
    notifyListeners();
    try {
      Response response = await dio.get(
        "https://newsapi.org/v2/top-headlines?country=$code&pageSize=100&apiKey=7c51cd1cd9624a8f97fbd2612b7ee5a0",
      );
      newsResponseModel = NewsResponseModel.fromJson(response.data);
      log(newsResponseModel.toString());
      articleList = newsResponseModel.articles ?? [];
    } catch (error, stacktrace) {
      log("Exception occurred: $error stackTrace: $stacktrace");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}