import 'package:flutter/material.dart';
import 'package:let_me_grab_news_app/screens/category_screen.dart';
import 'package:provider/provider.dart';

import '../providers/firebase_provider.dart';
import '../widgets/my_text_field.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseProvider = Provider.of<FirebaseProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Email",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            MyTextField(
              showBorder: false,
              hintText: "hello@gmail.com",
              controller: firebaseProvider.emailController,
              obscureText: false,
              onChanged: (value) {
                firebaseProvider.getEmail();
              },
              onSubmitted: (value) {
                firebaseProvider.getEmail();
                String? snackBarText = firebaseProvider.validateEmail(value!);
                if (snackBarText != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        snackBarText,
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                checkBoxWidget(
                  firebaseProvider,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            MyTextField(
              showBorder: false,
              hintText: "*************",
              controller: firebaseProvider.passwordController,
              obscureText: firebaseProvider.showPassWord ? false : true,
              onChanged: (value) {
                firebaseProvider.getPassword();
              },
              onSubmitted: (value) {
                firebaseProvider.getPassword();
                var snackBarText = firebaseProvider.validatePassword(value!);
                if (snackBarText != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        snackBarText,
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: mediaQuery.size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    firebaseProvider
                        .registerUserWithFirebase(
                      context,
                    )
                        .then((value) {
                      if (value) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CategoryScreen(),
                          ),
                        );
                      }
                    });
                  },
                  child: const Text(
                    'Register',
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?",
                    style: TextStyle(
                      fontSize: 15,
                    )),
                TextButton(
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  checkBoxWidget(FirebaseProvider firebaseProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: firebaseProvider.showPassWord,
          onChanged: (_) {
            firebaseProvider.toggleShowPassWord();
          },
        ),
        const Text('Show Password'),
      ],
    );
  }
}
