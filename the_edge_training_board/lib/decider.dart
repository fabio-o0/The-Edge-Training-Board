import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_edge_training_board/home_page.dart';
import 'package:the_edge_training_board/login_page.dart';

class Decider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (_, user, __) {
        if (user == null) {
          return LoginPage();
        } else {
          return HomePage();
        }
      },
    );
  }
}