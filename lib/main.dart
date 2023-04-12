import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test1/chat/basicchat.dart';
import 'package:test1/login/login.dart';
import 'package:test1/login/register.dart';
import 'package:flutter/widgets.dart';
import 'package:test1/scroll.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }


  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'scroll',
      routes: {
        'login' : (context) => LoginPage(),
        'register' : (context) => MyRegister(),
        'chat' : (context) => ChatApp(),
        'scroll' : (context) => MyLiquidSwipe(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
