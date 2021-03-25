import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_e/components/rounded_button.dart';
import 'package:chat_e/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/1.jpg'),
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Chat-e',
                        textStyle: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.white70),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Hero(
                    tag: 'signin',
                    child: RoundedButton(
                      title: 'Sign In',
                      color: kSecondaryColor,
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Hero(
                    tag: 'signup',
                    child: RoundedButton(
                      title: 'Sign Up',
                      color: kPrimaryColor,
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
