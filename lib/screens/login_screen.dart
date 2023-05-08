import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/firebase_provider.dart';
import '../widgets/my_text_field.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseProvider = Provider.of<FirebaseProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              showBorder: false,
              hintText: "abc@letmegrab.com",
              controller: firebaseProvider.emailController,
              obscureText: false,
              onChanged: (value) {
                firebaseProvider.getEmail();
              },
              onSubmitted: (value) {
                firebaseProvider.getEmail();
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
              },
            ),
            SizedBox(
              height: mediaQuery.size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    firebaseProvider.signUserIn(context);
                  },
                  child: const Text(
                    'Login',
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?",
                    style: TextStyle(
                      fontSize: 15,
                    )),
                TextButton(
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen())),
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
