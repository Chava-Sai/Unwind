import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:test1/login/signup_controller.dart';
import 'login.dart';


class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

Future<void> _loginWithGoogle() async {
  GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  print(userCredential.user?.displayName);
}

class _MyRegisterState extends State<MyRegister> {
  final _formKey = GlobalKey<FormState>();
  String? _fullname;
  String? _email;
  String? _phonenumber;
  String? _password;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formkey = GlobalKey<FormState>();

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: controller.username,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline_rounded),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Username',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black12)
                        ),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter your UserName' : null,
                      onSaved: (value) {
                        _fullname = value;
                      },
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      controller: controller.email,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail_outline),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black12)
                        ),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter your Email' : null,
                      onSaved: (value) {
                        _email = value;
                      },
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      controller: controller.phone,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        label: Text('Phone Number'),
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black12)
                        ),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter your PhoneNumber' : null,
                      onSaved: (value) {
                        _phonenumber = value;
                      },
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      controller: controller.password,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_open),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black12)
                        ),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter your Password' : null,
                      onSaved: (value) {
                        _password = value;
                      },
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xff4c505b),
                        child: IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                                if(_formKey.currentState!.validate() ){
                                     SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
                                 }
                            }
                        ),
                      ),
                    ),
                    SizedBox(height: 90),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 28,
                                  color: Colors.black),
                            )
                        ),
                      ],
                    )
                  ],

                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}