import 'package:chatty/components/rounded_button.dart';
import 'package:chatty/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatty/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "registration_screen";

  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your email'),
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password'),
                    style: TextStyle(color: Colors.black),
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(Colors.blueAccent, 'Register', () async {
                    setState(() {
                      loading = true;
                    });
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        loading = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
