import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_edge_training_board/components/general/buttons.dart';
import 'package:the_edge_training_board/components/general/input_field.dart';
import 'package:the_edge_training_board/services/firebase_auth_service.dart';

class CreateAccountForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, TextEditingController> controllers;

  CreateAccountForm({@required this.formKey, @required this.controllers});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputField(
            text: 'Full Name',
            controller: controllers['name'],
            type: InputType.Text,
          ),
          InputField(
            text: 'Email',
            controller: controllers['email'],
            type: InputType.Email,
          ),
          InputField(
            text: 'Password',
            controller: controllers['password'],
            type: InputType.Password,
          ),
          SizedBox(height: 24.0),
          PrimaryButton(
              title: 'CREATE ACCOUNT',
              onPressed: () async {
                if (formKey.currentState.validate()) {
                  try {
                    await context.read<FirebaseAuthService>()
                        .createAccountWithEmailAndPassword(
                        controllers['email'].text, controllers['password'].text,
                        controllers['name'].text);
                  } catch (e) {
                    Scaffold
                        .of(context)
                        .showSnackBar(
                        SnackBar(
                            backgroundColor: Colors.black,
                            content: Padding(
                              padding: const EdgeInsets.only(top: 12.0, bottom: 18.0),
                              child: Text('Sorry, an error has occurred.', style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white)),
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