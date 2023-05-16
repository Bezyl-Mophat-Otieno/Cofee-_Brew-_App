import 'package:flutter/material.dart';

import 'package:flutter_1_intellij/components/my_squaretile.dart';
import 'package:flutter_1_intellij/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progress_indicators/progress_indicators.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _usernameFillError = "";
  String _passwordFillError = "";
  String _cPasswordFillError = "";
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    void showEmailError() {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title:  Text('Error'),
            content:  Text('No user found for that email'),
          );
        },
      );
    }

    void showPasswordError() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('No user found for that email'),
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
        //check if the fields are all filled
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

        if (confirmPasswordController.text.isEmpty) {
          setState(() {
            _cPasswordFillError = "Kindly fill in the Confirm Password field";
          });
        } else {
          setState(() {
            _cPasswordFillError = "";
          });
        }
        Navigator.pop(context);
        showPasswordError();

        //check if the password matches the confirm password field
        if (passwordController.text == confirmPasswordController.text) {
          //sign in the user
          FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
        } else {
          Navigator.pop(context);
          showPasswordError();
        }

        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.pop(context);
          showEmailError();
        } else if (e.code == 'wrong-password') {}
        Navigator.pop(context);
        showPasswordError();
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
              //Confirm password field
              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Text(
                      _cPasswordFillError,
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
                  child: Text('Sign-Up'),
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
                  Text('Already have an account ?'),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Login Now',
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
