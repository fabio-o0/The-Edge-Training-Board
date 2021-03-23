import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Hello ${user.uid}!'),
    );
  }
}
