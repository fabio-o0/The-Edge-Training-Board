import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:the_edge_training_board/components/page_template.dart';
import 'package:the_edge_training_board/router/route_names.dart';
import 'package:the_edge_training_board/router/router.dart';
import 'package:the_edge_training_board/services/firebase_auth_service.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate();
  }
}
