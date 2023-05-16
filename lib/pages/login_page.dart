import 'package:flutter/material.dart';

import 'package:flutter_1_intellij/components/my_squaretile.dart';
import 'package:flutter_1_intellij/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _usernameFillError = "";
  String _passwordFillError = "";
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
//display  Error messages to the user .
    void userAuthErrorMessage(message) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(message),
          );
        },
      );
    }

    void signUserIn() {
      //show the loading circle
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: JumpingDotsProgressIndicator(
              fontSize: 100.0,
              color: Colors.blue,
            ),
          );
        },
      );
      try {
        if (emailController.text.isEmpty) {
          setState(() {
            _usernameFillError = "Kindly fill in the User Name field";
          });
        } else {
          setState(() {
            _usernameFillError = "";
          });
        }

        if (passwordController.text.isEmpty) {
          setState(() {
            _passwordFillError = "Kindly fill in the Password field";
          });
        } else {
          setState(() {
            _passwordFillError = "";
          });
        }

        //sign in the user
        FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.pop(context);
          userAuthErrorMessage(e.code);
        } else if (e.code == 'wrong-password') {
          Navigator.pop(context);
          userAuthErrorMessage(e.code);
        }
      }

      // pop the circle
    }

    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              const Icon(
                Icons.lock,
                size: 50,
                color: Colors.brown,
              ),
              const SizedBox(
                height: 50,
              ),

              const SizedBox(
                height: 50,
              ),
              // email address
              MyTextField(
                controller: emailController,
                hintText: 'Username',
                obscureText: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Text(
                      _usernameFillError,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              //password field
              MyTextField(
                controller: passwordController,
                hintText: 'Enter Password',
                obscureText: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Text(
                      _passwordFillError,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forgot password ?'),
                  ],
                ),
              ),
              SizedBox(
                width: 370,
                height: 70,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[600], // background
                    foregroundColor: Colors.white,
                    // foreground
                  ),
                  onPressed: signUserIn,
                  child: Text('Sign-In'),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Divider(
                thickness: 1,
                color: Colors.brown[500],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'OR Continue With',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                thickness: 1,
                color: Colors.brown[500],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(
                    imagePath: 'assets/images/apple.png',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SquareTile(
                    imagePath: 'assets/images/google.png',
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a Member ?'),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Register Now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.brown,
                      ),
                    ),
                  )
                ],
              )
            ]),
          ),
        )),
      ),
    );
  }
}
