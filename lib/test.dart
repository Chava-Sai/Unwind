import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:page_transition/page_transition.dart';
import 'package:test1/login/register.dart';
import 'package:test1/login/signup_controller.dart';
import 'package:test1/screens/chat_screen.dart';
import 'package:test1/scroll.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();



  Future<void> _loginWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      // TODO: Handle the signed-in user
    } catch (e) {
      // TODO: Handle the sign-in error
      print('Error signing in with Google: $e');
    }
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(SignUpController());
    final _formkey = GlobalKey<FormState>();
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Assets/image/login.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width*0.05,
            top: MediaQuery.of(context).size.width*0.45,
          ),
          child: const Text(
            "Welcome\nBack",
            style: TextStyle(
              fontFamily: 'OoohBaby',
              color: Colors.white,
              fontSize: 33,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent, // Set the background color to transparent
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.45,right: 35,left: 35),
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.email,
                      decoration: InputDecoration(
                        labelText: 'email',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter your username' : null,
                      onSaved: (value) {
                        _email = value;
                      },
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: controller.password,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter your password' : null,
                      onSaved: (value) {
                        _password = value;
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: _loginWithGoogle,
                              child: Image.asset(
                                'Assets/image/google.png',
                                width: 48.0,
                                height: 48.0,
                              ),
                            ),
                            SizedBox(width: 15,),
                            GestureDetector(
                              onTap: (){},
                              child: Image.asset(
                                'Assets/image/facebook.png',
                                width: 40.0,
                                height: 40.0,
                              ),
                            ),
                            SizedBox(width: 20,),
                            GestureDetector(
                              onTap: (){},
                              child: Image.asset(
                                'Assets/image/apple.png',
                                width: 40.0,
                                height: 40.0,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xff4c505b),
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.arrow_forward),
                              onPressed: () {
                                Future<void> _login() async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    try {
                                      UserCredential userCredential =
                                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                                        email: _email!,
                                        password: _password!,
                                      );
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: ChatScreen(),
                                          duration: Duration(milliseconds: 500),
                                        ),
                                      );
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'user-not-found') {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              // Dialog box
                                              title: Text('Login Failed'),
                                              content: Text('No user found with the provided email.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else if (e.code == 'wrong-password') {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Login Failed'),
                                              content: Text('The password is incorrect.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    }
                                  }
                                }

                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 100,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: (){
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 1000),
                              pageBuilder: (context, animation, secondaryAnimation) => MyRegister(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                // Create a fade transition animation
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        }, child: Text('Sign Up',style: TextStyle(decoration: TextDecoration.underline , fontSize: 18,color: Color(0xff4c505b)),)),
                        TextButton(onPressed: (){}, child: Text('Forgot Password',style: TextStyle(decoration: TextDecoration.underline , fontSize: 18,color: Color(0xff4c505b)),)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),)
      ],
    );
  }
}