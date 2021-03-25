import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_edge_training_board/router/route_names.dart';
import 'package:the_edge_training_board/router/router.dart';
import 'package:the_edge_training_board/services/firebase_auth_service.dart';

class PageTemplate extends StatefulWidget {
  @override
  _PageTemplateState createState() => _PageTemplateState();
}

class _PageTemplateState extends State<PageTemplate> {
  int _selectedIndex = 0;
  User _user;

  @override
  void initState() {
    _user = context.read<FirebaseAuthService>().currentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String url = ModalRoute.of(context).settings.name;
    if (url == '/') _selectedIndex = 0;
    else if (url == '/add_route') _selectedIndex = 1;
    else if (url == '/my_routes') _selectedIndex = 2;
    else if (url == '/settings') _selectedIndex = 3;
    return Scaffold(
      body: Container(child: Center(child: Text(_user.uid + ' ' + _selectedIndex.toString()),),),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        currentIndex: _selectedIndex,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Route'),
          BottomNavigationBarItem(icon: Icon(Icons.subject), label: 'My Routes'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Fluro.router.navigateTo(
                  context,
                  HomeRoute,
                  transition: TransitionType.fadeIn,
                  transitionDuration: Duration(milliseconds: 150));
              break;
            case 1:
              Fluro.router.navigateTo(
                  context,
                  AddRouteRoute,
                  transition: TransitionType.fadeIn,
                  transitionDuration: Duration(milliseconds: 150));
              break;
            case 2:
              Fluro.router.navigateTo(
                  context,
                  MyRoutesRoute,
                  transition: TransitionType.fadeIn,
                  transitionDuration: Duration(milliseconds: 150));
              break;
            case 3:
              Fluro.router.navigateTo(
                  context,
                  SettingsRoute,
                  transition: TransitionType.fadeIn,
                  transitionDuration: Duration(milliseconds: 150));
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
