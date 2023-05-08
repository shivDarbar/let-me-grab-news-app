import 'package:flutter/material.dart';
import 'package:let_me_grab_news_app/providers/news_provider.dart';
import 'package:let_me_grab_news_app/screens/news_detail_screen.dart';
import 'package:provider/provider.dart';

import '../providers/firebase_provider.dart';
import 'login_screen.dart';

class NewsListScreen extends StatelessWidget {
  final String category;
  const NewsListScreen(this.category, {super.key});
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    final firebaseProvider = Provider.of<FirebaseProvider>(context);

    final mediaQuery = MediaQuery.of(context);
    var newsList = newsProvider.newsList;
    var isSearching = newsProvider.isSearching;
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Are you sure you want to Logout?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            firebaseProvider.signOut().then(
                              (value) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text('Yes')),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.logout_rounded,
            ),
          ),
        ],
      ),
      body: newsProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: newsProvider.searchController,
                    onChanged: (value) {
                      newsProvider.searchNews(value);
                    },
                    onSubmitted: (value) {
                      newsProvider.searchNews(value);
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          newsProvider.searchController.clear();
                          newsProvider.toggleIsSearching(false);
                        },
                      ),
                      hintText: 'Search News',
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(15),
                      hintStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.builder(
                    itemCount: isSearching
                        ? newsProvider.searchList.length
                        : newsList.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetailScreen(
                              news: isSearching
                                  ? newsProvider.searchList[index]
                                  : newsList[index],
                            ),
                          ),
                        );
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: SizedBox(
                          height: mediaQuery.size.shortestSide * 0.14,
                          width: mediaQuery.size.shortestSide * 0.12,
                          child: Image.network(
                            isSearching
                                ? newsProvider.searchList[index].imageUrl
                                : newsList[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      isThreeLine: true,
                      title: Text(
                        isSearching
                            ? newsProvider.searchList[index].title
                            : newsList[index].title,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        isSearching
                            ? newsProvider.searchList[index].content
                            : newsList[index].content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
