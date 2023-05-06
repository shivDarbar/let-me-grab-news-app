import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:let_me_grab_news_app/models/news_category.dart';

import '../models/news.dart';

class NewsProvider with ChangeNotifier {
  final List<News> _newsList = [];
  List<News> get newsList {
    return [..._newsList];
  }

  final List<NewsCategory> _categoryList = [
    NewsCategory(name: 'All', icon: FontAwesomeIcons.earthAsia),
    NewsCategory(name: 'Business', icon: FontAwesomeIcons.moneyBillTrendUp),
    NewsCategory(name: 'Politics', icon: FontAwesomeIcons.landmark),
    NewsCategory(name: 'Sports', icon: FontAwesomeIcons.trophy),
    NewsCategory(name: 'Technology', icon: FontAwesomeIcons.microchip),
    NewsCategory(name: 'Science', icon: FontAwesomeIcons.atom),
  ];

  // ['All', 'Sports', 'Business', 'Science'];
  List<NewsCategory> get categoryList {
    return [..._categoryList];
  }

  getNewsList(String category) async {
    var url = 'https://inshorts.deta.dev/news?category=$category';
    var response = await http.get(Uri.parse(url));
    var dataList = json.decode(response.body)['data'];
    dataList.forEach((data) {
      _newsList.add(
        News(
          title: data['title'],
          imageUrl: data['imageUrl'],
          content: data['content'],
          author: data['author'],
          date: data['date'],
          time: data['time'],
        ),
      );
    });
  }
}
