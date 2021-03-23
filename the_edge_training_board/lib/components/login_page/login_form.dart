import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_edge_training_board/components/general/buttons.dart';
import 'package:the_edge_training_board/components/general/input_field.dart';
import 'package:the_edge_training_board/services/firebase_auth_service.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, TextEditingController> controllers;

  const LoginForm({@required this.formKey, @required this.controllers});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputField(
              text: 'Email',
              controller: controllers['email'],
              type: InputType.Email
          ),
          InputField(
              text: 'Password',
              controller: controllers['password'],
              type: InputType.Password
          ),
          SizedBox(height: 24.0,),
          PrimaryButton(
              title: 'LOG IN',
              onPressed: () async {
                if (formKey.currentState.validate()) {
                  try {
                    await context.read<FirebaseAuthService>()
                        .signInWithEmailAndPassword(controllers['email'].text, controllers['password'].text);
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
                    Scaffold.of(context).showSnackBar(
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
    );
  }
}
