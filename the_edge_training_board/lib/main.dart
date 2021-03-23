import 'package:flutter/material.dart';
import 'package:the_edge_training_board/style.dart';

void main() {
  runApp(EdgeRock());
}

class EdgeRock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Edge Training App',
      debugShowCheckedModeBanner: false,
      theme: Style.theme,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('hi'),),
      body: Container(),
    );
  }
}
