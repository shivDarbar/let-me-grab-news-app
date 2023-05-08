import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:let_me_grab_news_app/providers/firebase_provider.dart';
import 'package:let_me_grab_news_app/providers/news_provider.dart';
import 'package:let_me_grab_news_app/screens/login_screen.dart';
import 'package:let_me_grab_news_app/screens/news_list_screen.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final newsProvider = Provider.of<NewsProvider>(context);
    final firebaseProvider = Provider.of<FirebaseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Category'),
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
                        child: const Text('Yes'),
                      ),
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
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: newsProvider.categoryList.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  newsProvider.getNewsList(
                    newsProvider.categoryList[index].name.toLowerCase(),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsListScreen(
                        newsProvider.categoryList[index].name,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[200],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          newsProvider.categoryList[index].icon,
                          size: mediaQuery.size.width * 0.15,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(newsProvider.categoryList[index].name),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
