import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[600],
        title: const Text(
          "Coffee  Brewer",
          style: TextStyle(
              fontFamily: "ubuntu", fontWeight: FontWeight.w200, fontSize: 30),
        ),
        actions: [
          IconButton(
            onPressed: signOut,
            tooltip: "Sign Out",
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Container(
        color: Colors.brown[100],
        child: Center(
            child: Text(
          "You have successfully logged in as ${user?.email}",
        )),
      ),
    );
  }
}
