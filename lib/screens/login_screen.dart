import 'package:chatty/components/rounded_button.dart';
import 'package:chatty/constants.dart';
import 'package:chatty/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quickalert/quickalert.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
  }

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
                  RoundedButton(Colors.lightBlueAccent, 'Login', () async {
                    try {
                      setState(() {
                        loading = true;
                      });
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                    } catch (error) {
                      var parts = error.toString().split(']');
                      QuickAlert.show(
                          context: context,
                          animType: QuickAlertAnimType.slideInDown,
                          type: QuickAlertType.error,
                          text: parts[1].trim() + "\nPlease try again",
                          confirmBtnText: "Okay",
                          onConfirmBtnTap: () {
                            while (Navigator.canPop(context)) {
                              // Navigator.canPop return true if can pop
                              Navigator.pop(context);
                            }
                          });
                    } finally {
                      setState(() {
                        loading = false;
                      });
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
