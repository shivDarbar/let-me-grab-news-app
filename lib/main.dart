import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:let_me_grab_news_app/providers/firebase_provider.dart';
import 'package:let_me_grab_news_app/providers/news_provider.dart';
import 'package:let_me_grab_news_app/screens/category_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseProvider>(
          create: (context) => FirebaseProvider(),
        ),
        ChangeNotifierProvider<NewsProvider>(
          create: (context) => NewsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CategoryScreen(),
      ),
    );
  }
}
