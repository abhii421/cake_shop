import 'package:capstone_1/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:capstone_1/main.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){

            if(snapshot.hasData) {
              return const homepage();
            }
            else {
              return const MyHomePage(title: 'title');
            }

          }
      ),
    );
  }
}
