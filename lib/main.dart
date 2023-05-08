import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:let_me_grab_news_app/providers/firebase_provider.dart';
import 'package:let_me_grab_news_app/providers/news_provider.dart';
import 'package:let_me_grab_news_app/screens/category_screen.dart';
import 'package:let_me_grab_news_app/screens/login_screen.dart';
import 'package:provider/provider.dart';

import 'helpers/user_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await UserPreferences.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isExistingUser = false;
  @override
  void initState() {
    isExistingUser = UserPreferences.getUserLogin();
    super.initState();
  }

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
        title: 'News App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            centerTitle: true,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.black,
              ),
            ),
          ),
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            bodyText1: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ),
        home: isExistingUser ? const CategoryScreen() : const LoginScreen(),
      ),
    );
  }
}
