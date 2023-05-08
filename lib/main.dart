import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:test1/firebase_options.dart';
import 'package:test1/login/authentication_repository.dart';
import 'package:test1/login/login.dart';
import 'package:test1/login/register.dart';
import 'package:flutter/widgets.dart';
import 'package:test1/providers/chats_provider.dart';
import 'package:test1/providers/models_provider.dart';
import 'package:test1/screens/chat_screen.dart';
import 'package:test1/scroll.dart';
import 'package:test1/settings.dart';

import 'constants/constants.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
        ChangeNotifierProvider(create: (_) => UserName()),
      ],
      child: GetMaterialApp(
        title: 'Flutter ChatBOT',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        ),
        home: LoginPage(),
      ),
    );
  }
}


