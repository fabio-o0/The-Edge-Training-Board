import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_edge_training_board/components/page_template.dart';
import 'package:the_edge_training_board/login_page.dart';
import 'package:the_edge_training_board/router/route_names.dart';
import 'package:the_edge_training_board/router/router.dart';
import 'package:the_edge_training_board/services/firebase_auth_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (_, user, __) {
        if (user == null) {
          return LoginPage();
        } else {
          return PageTemplate(content: Container(),);
        }
      },
    );
  }
}
