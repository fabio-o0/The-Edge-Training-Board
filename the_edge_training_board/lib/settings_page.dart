import 'dart:html' as html;
import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
              content: Column(
                children: [
                  user.photoURL == null ?
                    Container(
                      width: 125,
                      height: 125,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('blank_profile.png'),
                        fit: BoxFit.fill
                        ),
                      ),
                    ) :
                    Container(
                      width: 125,
                      height: 125,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(user.photoURL),
                          fit: BoxFit.fill
                        ),
                      ),
                    ),
                  PrimaryButton(
                      title: 'change image',
                      onPressed: () async {
                        // showModalBottomSheet(
                        //     context: context,
                        //     builder: (BuildContext bc) {
                        //       return SafeArea(
                        //         child: Container(
                        //           child: Column(
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: <Widget>[
                        //               ListTile(
                        //                 title: Text('Choose From', style: Theme.of(context).textTheme.headline5,),
                        //               ),
                        //               ListTile(
                        //                 leading: Icon(Icons.photo_camera),
                        //                 title: Text('Camera', style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 14.00)),
                        //                 onTap: () async {
                        //                   final perm = await html.window.navigator.permissions.query({"name": "camera"});
                        //                   if (perm.state == "denied") {
                        //                     Scaffold.of(context).showSnackBar(SnackBar(
                        //                       content: Text("Oops! Camera access denied!"),
                        //                       backgroundColor: Colors.orangeAccent,
                        //                     ));
                        //                     return;
                        //                   }
                        //                   final stream = await html.window.navigator.getUserMedia(video: true);
                        //                   Navigator.of(context).pop();
                        //                 },
                        //               ),
                        //               ListTile(
                        //                   leading: Icon(Icons.photo_library),
                        //                   title: Text('Photo Library', style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 14.00)),
                        //                   onTap: () async {
                        //                     FilePickerResult result = await FilePicker.platform.pickFiles();
                        //
                        //                     if(result != null) {
                        //                       File file = File(result.files.single.path);
                        //                     } else {
                        //                       // User canceled the picker
                        //                     }
                        //                     Navigator.of(context).pop();
                        //                   }),
                        //               SizedBox(height: 8.0,)
                        //             ],
                        //           ),
                        //         ),
                        //       );
                        //     }
                        // ); Camera support not yet implemented in Flutter Web
                        FilePickerResult result = await FilePicker.platform.pickFiles();

                        if(result != null) {
                          File file = File(result.files.single.path);

                        } else {
                          // User canceled the picker
                        }
                      }
                  ),
                  PrimaryButton(
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
                ],
              )
          );
        }
      },
    );
  }
}
