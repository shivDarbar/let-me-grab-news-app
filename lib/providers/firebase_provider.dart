import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:let_me_grab_news_app/helpers/user_preferences.dart';

import '../screens/category_screen.dart';

class FirebaseProvider with ChangeNotifier {
  String? _email;
  String? get email => _email;
  String? _password;
  String? get password => _password;

  bool _showPassWord = false;
  bool get showPassWord => _showPassWord;

  User? currentUser;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  toggleShowPassWord() {
    _showPassWord = !_showPassWord;
    notifyListeners();
  }

  getEmail() {
    _email = emailController.text;
  }

  getPassword() {
    _password = passwordController.text;
  }

  mySnackBar({
    required BuildContext context,
    required String text,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  String? validateEmail(String value) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (value.isEmpty) {
      return 'Please enter Email Address';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter a valid Email Address.';
      } else {
        return null;
      }
    }
  }

  String? validatePassword(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter a valid password';
      } else {
        return null;
      }
    }
  }

  Future<bool> registerUserWithFirebase(BuildContext context) async {
    if (_email!.isNotEmpty && _password!.isNotEmpty) {
      try {
        User? user;
        FirebaseAuth auth = FirebaseAuth.instance;
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );
        user = userCredential.user;
        await user!.updateProfile();
        await user.reload();
        user = auth.currentUser;
        UserPreferences.setuserLogin(true);

        return true;
      } catch (error) {
        if (error is FirebaseAuthException) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                error.toString(),
              ),
            ),
          );
        }
      }
    }
    return false;
  }

  void signUserIn(BuildContext context) async {
    if (_email!.isNotEmpty && _password!.isNotEmpty) {
      try {
        var login = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then(
          (value) {
            UserPreferences.setuserLogin(true);

            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const CategoryScreen()));
          },
        );
        print(login);
      } on FirebaseAuthException catch (e) {
        showErrorMessage(message: e.code, context: context);
      }
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    UserPreferences.setuserLogin(false);
  }

  void showErrorMessage({
    required String message,
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      },
    );
  }
}
