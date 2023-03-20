import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}
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

class _MyRegisterState extends State<MyRegister> {
  final _formKey = GlobalKey<FormState>();
  String? _username;
  String? _password;
  String? _email;
  String? _repassword;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Assets/image/register.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 35 , top: 70),
          child: const Text(
            "Create\nAccount",
            style: TextStyle(color: Colors.white , fontSize: 33,decoration: TextDecoration.none),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent, // Set the background color to transparent
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.29,right: 35,left: 35),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Username',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter your username' : null,
                      onSaved: (value) {
                        _username = value;
                      },
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter your Email' : null,
                      onSaved: (value) {
                        _email = value;
                      },
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText:'Password',
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
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _repasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white)
                        ),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please Re-enter your password' : null,
                      onSaved: (value) {
                        _repassword = value;
                      },
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xff4c505b),
                            child: TextButton(
                              onPressed: () {Navigator.pushNamed(context, 'login');}, child: Text('Go',style: TextStyle(color: Colors.white , fontSize: 20) ,),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 70,),
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
                        TextButton(onPressed: (){ Navigator.pushNamed(context, 'login');}, child: Text('Sign In',style: TextStyle(decoration: TextDecoration.underline , fontSize: 18,color: Colors.lightBlue),)),
                       // TextButton(onPressed: (){}, child: Text('Forgot Password',style: TextStyle(decoration: TextDecoration.underline , fontSize: 18,color: Color(0xff4c505b)),)),
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
