import 'package:chat_e/constants.dart';
import 'package:chat_e/screens/chat_screen.dart';
import 'package:chat_e/screens/home.dart';
import 'package:chat_e/screens/login.dart';
import 'package:chat_e/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(primaryColor: kPrimaryColor),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/chat_screen': (context) => ChatScreen(),
      },
    );
  }
}
