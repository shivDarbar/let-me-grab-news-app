import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:let_me_grab_news_app/providers/news_provider.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Category'),
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
                onTap: () {},
                child: Container(
                  // width: mediaQuery.size.width * 0.5,
                  // height: mediaQuery.size.height * 0.3,
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
          // Container(
          //   width: mediaQuery.size.width * 0.5,
          //   height: mediaQuery.size.height * 0.3,
          //   margin: const EdgeInsets.all(5),
          //   padding: const EdgeInsets.all(5),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(15),
          //     color: Colors.grey[200],
          //   ),
          //   child: Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         FaIcon(
          //           FontAwesomeIcons.earthAsia,
          //           size: mediaQuery.size.width * 0.15,
          //         ),
          //         const SizedBox(
          //           height: 15,
          //         ),
          //         const Text('World'),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
