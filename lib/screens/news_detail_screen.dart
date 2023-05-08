import 'package:flutter/material.dart';

import '../models/news.dart';

class NewsDetailScreen extends StatelessWidget {
  final News news;

  const NewsDetailScreen({super.key, required this.news});
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              width: mediaQuery.size.width,
              height: mediaQuery.size.height * 0.4,
              child: Image.network(
                news.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: mediaQuery.size.width * 0.05,
                vertical: mediaQuery.size.height * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      news.title,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  Text(
                    news.content,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Author: ${news.author}',
                  ),
                  Text(
                    '${news.date} ${news.time}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
