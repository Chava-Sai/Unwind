import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:test1/login/verify_email.dart';
import 'package:test1/screens/chat_screen.dart';
import 'package:test1/scroll.dart';

import 'failure.dart';
import 'login.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginPage());
    } else {
      if (user.emailVerified) {
        Get.offAll(() => ScrollPage());
      }
      // else {
      //   Get.offAll(() => EmailVerificationScreen());
      // }
    }
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final user = _auth.currentUser;
      if (user != null) {
        await user.sendEmailVerification();
        Get.snackbar('Verify your email',
            'A verification email has been sent to ${user.email}. Please check your inbox and follow the instructions to verify your email.',
            duration: Duration(seconds: 20),
            snackPosition: SnackPosition.BOTTOM,

        );
        Get.offAll(() => EmailVerificationScreen());
      }
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPassFailure.code(e.code);
      print('FireBase Auth Exception - ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPassFailure();
      print(' Exception - ${ex.message}');
      throw ex;
    }
  }

  Future<void> loginWithEmailAndPassword(String email , String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){
    } catch (_){}
  }

  Future<void> logout() async => _auth.signOut();
}


