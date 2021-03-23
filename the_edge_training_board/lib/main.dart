import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:the_edge_training_board/components/general/buttons.dart';
import 'package:the_edge_training_board/components/general/input_field.dart';
import 'package:the_edge_training_board/services/firebase_auth_service.dart';
import 'package:the_edge_training_board/style.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((v) => null);
  runApp(
      MultiProvider(
          providers: [
            Provider(
              create: (_) => FirebaseAuthService(),
            ),
            StreamProvider(
              create: (context) => context.read<FirebaseAuthService>().onAuthStateChanged,
            ),
          ],
          child: EdgeRock()
      )
  );
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {
    'email' : TextEditingController(),
    'password' : TextEditingController()
  };

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) =>
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                key: _scaffoldKey,
                body: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowGlow();
                      return;
                    },
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 400,
                        ),
                        child: Form(
                          key: _loginKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Image.asset('logo.png', height: 250,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: Text('Training Board', style: Theme.of(context).textTheme.headline2, textAlign: TextAlign.center,),
                                ),
                                InputField(
                                    text: 'Email',
                                    controller: _controllers['email'],
                                    type: InputType.Email
                                ),
                                InputField(
                                    text: 'Password',
                                    controller: _controllers['password'],
                                    type: InputType.Password
                                ),
                                SizedBox(height: 24.0,),
                                PrimaryButton(
                                    title: 'LOG IN',
                                    onPressed: () async {
                                      if (_loginKey.currentState.validate()) {
                                        try {
                                          await context.read<FirebaseAuthService>()
                                              .signInWithEmailAndPassword(_controllers['email'].text, _controllers['password'].text);
                                        } catch (e) {
                                          print(e.toString());
                                          String message = '';
                                          if (e.toString() == '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
                                            message = "Sorry, we couldn't find that user.";
                                          } else if (e.toString() == '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
                                            message = "Sorry, that's not the right password.";
                                          } else if (e.toString() == '[firebase_auth/too-many-requests] Too many unsuccessful login attempts. Please try again later.') {
                                            message = 'Too many unsuccessful login attempts. Please try again later.';
                                          } else if (e.toString() == '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
                                            message = "Oops! Looks like you're offline!";
                                          } else {
                                            message = 'Sorry, an error has occurred.';
                                          }
                                          _scaffoldKey.currentState.showSnackBar(
                                              SnackBar(
                                                  backgroundColor: Colors.grey[800],
                                                  content: Padding(
                                                    padding: const EdgeInsets.only(top: 12.0, bottom: 18.0),
                                                    child: Text(message, style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white)),
                                                  )
                                              )
                                          );
                                        }
                                      }
                                    }
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                )
            ),
          ),
    );
  }
}