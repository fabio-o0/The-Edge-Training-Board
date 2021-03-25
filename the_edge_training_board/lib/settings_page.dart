import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:the_edge_training_board/components/general/buttons.dart';
import 'package:the_edge_training_board/components/page_template.dart';
import 'package:the_edge_training_board/login_page.dart';
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
    return Consumer<User>(
      builder: (_, user, __) {
        if (user == null) {
          return LoginPage();
        } else {
          return PageTemplate(
              content: Center(
                child: PrimaryButton(
                    title: 'SIGN OUT',
                    onPressed: () async {
                      try {
                        await context.read<FirebaseAuthService>().signOut();
                      } catch (e) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.grey[800],
                                content: Padding(
                                  padding: const EdgeInsets.only(top: 12.0, bottom: 18.0),
                                  child: Text('Sorry, an error has occurred.', style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white)),
                                )
                            )
                        );
                      }
                    }
                ),
              )
          );
        }
      },
    );
  }
}
