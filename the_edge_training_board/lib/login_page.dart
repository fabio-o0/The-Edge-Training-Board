import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:the_edge_training_board/components/login_page/create_account_form.dart';
import 'package:the_edge_training_board/components/login_page/login_form.dart';

class LoginPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> createAccountKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {
    'name' : TextEditingController(),
    'email' : TextEditingController(),
    'password' : TextEditingController()
  };

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<String> _currentView = ['Have an account?', 'Need an account?'];
  int _viewKey = 0;

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
                key: widget.scaffoldKey,
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
                          child: SingleChildScrollView(
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
                                AnimatedCrossFade(
                                  duration: const Duration(milliseconds: 150),
                                  firstChild: LoginForm(formKey: widget.loginKey, controllers: widget.controllers),
                                  secondChild: CreateAccountForm(formKey: widget.createAccountKey, controllers: widget.controllers),
                                  crossFadeState: _viewKey == 1 ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                                ),
                                SizedBox(height: 18.0),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        _viewKey = _viewKey == 0 ? 1 : 0;
                                      });
                                    },
                                    child: Text(_currentView[_viewKey == 1 ? 0 : 1], style: Theme.of(context).textTheme.headline5, textAlign: TextAlign.center,)
                                ),
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