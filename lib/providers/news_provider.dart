// ignore_for_file: avoid_function_literals_in_foreach_calls

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

  final List<News> _searchList = [];
  List<News> get searchList {
    return [..._searchList];
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  TextEditingController searchController = TextEditingController();

  final List<NewsCategory> _categoryList = [
    NewsCategory(name: 'All', icon: FontAwesomeIcons.newspaper),
    NewsCategory(name: 'World', icon: FontAwesomeIcons.earthAsia),
    NewsCategory(name: 'Business', icon: FontAwesomeIcons.moneyBillTrendUp),
    NewsCategory(name: 'Politics', icon: FontAwesomeIcons.landmark),
    NewsCategory(name: 'Sports', icon: FontAwesomeIcons.trophy),
    NewsCategory(name: 'Technology', icon: FontAwesomeIcons.microchip),
    NewsCategory(name: 'Science', icon: FontAwesomeIcons.atom),
  ];

  List<NewsCategory> get categoryList {
    return [..._categoryList];
  }

  toggleIsSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  toggleIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  searchNews(String value) {
    _searchList.clear();
    toggleIsSearching(true);
    _newsList.forEach((news) {
      if (news.title.toLowerCase().contains(value.toLowerCase())) {
        _searchList.add(news);
      }
    });
    notifyListeners();
  }

  getNewsList(String category) async {
    toggleIsLoading(true);
    _newsList.clear();
    var url = 'https://inshorts.deta.dev/news?category=$category';
    var response = await http.get(Uri.parse(url));
    var dataList = json.decode(response.body)['data'];
    dataList.forEach(
      (data) {
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
      },
    );
    toggleIsLoading(false);
    notifyListeners();
  }
}
