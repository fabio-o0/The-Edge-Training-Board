import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:the_edge_training_board/components/general/buttons.dart';
import 'package:the_edge_training_board/components/general/input_field.dart';
import 'package:the_edge_training_board/login_page.dart';
import 'package:the_edge_training_board/router/route_names.dart';
import 'package:the_edge_training_board/router/router.dart';
import 'package:the_edge_training_board/services/firebase_auth_service.dart';
import 'package:the_edge_training_board/style.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((v) => null);
  Fluro.setupRouter();
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
      initialRoute: HomeRoute,
      onGenerateRoute: Fluro.router.generator,
    );
  }
}