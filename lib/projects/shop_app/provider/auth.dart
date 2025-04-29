import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reviewer_2025v1/utils/xprint.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? tokenUserID;
  String? uid;
  Timer? _signOutTimer;
  String? expiredDate;

  bool get isAuth {
    return tokenUserID != null;
  }

  String? get token {
    return tokenUserID;
  }

  String? get userID {
    return uid;
  }

  Future<void> signUp({
    required String email,
    required String password,
    ctx,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      tokenUserID = await userCredential.user?.getIdToken();
      uid = userCredential.user?.uid;

      DateTime? expiryTime = await getTokenExpiryTime();
      final now = DateTime.now();
      final duration = expiryTime?.difference(now);

      startAutoSignOutTimer(duration!, ctx);

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': tokenUserID,
        'uid': uid,
        'expiryTime': expiryTime?.toIso8601String(),
      });

      prefs.setString('userData', userData);
    } on FirebaseAuthException catch (e) {
      showToast(e.message ?? 'SignUp Error');
      rethrow;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData = json.decode(prefs.getString('userData')!) as Map<String, dynamic>;



    final expiryTime = DateTime.parse(
      extractedUserData['expiryTime'] as String,
    );
    if (expiryTime.isBefore(DateTime.now())) {
      return false;
    }
    tokenUserID = extractedUserData['token'] as String;
    uid = extractedUserData['uid'] as String;
    expiredDate = extractedUserData['expiryTime'] as String;
    notifyListeners();
    xPrint('tryAutoLogin');
    return true;
  }

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext ctx,
  }) async {
    try {
      final fa = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      tokenUserID = await FirebaseAuth.instance.currentUser?.getIdToken();
      uid = FirebaseAuth.instance.currentUser?.uid;

      DateTime? expiryTime = await getTokenExpiryTime();
      final now = DateTime.now();
      final duration = expiryTime?.difference(now);

      startAutoSignOutTimer(duration!, ctx);

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': tokenUserID,
        'uid': uid,
        'expiryTime': expiryTime?.toIso8601String(),
      });

      prefs.setString('userData', userData);
    } on FirebaseAuthException catch (e) {
      showToast('SignIn Error: ${e.message}');
      rethrow;
    }
  }

  Future<void> signOut(ctx) async {
    tokenUserID = null;
    uid = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();

    notifyListeners();

    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(ctx).popUntil((route) => route.isFirst);
    } catch (error) {
      rethrow;
    }
  }

  Future<DateTime?> getTokenExpiryTime() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        String? token = await user.getIdToken();
        final parts = token?.split('.');
        if (parts?.length != 3) return null;

        final payloadMap = json.decode(
          utf8.decode(base64Url.decode(base64Url.normalize(parts![1]))),
        );

        final exp = payloadMap['exp'];
        if (exp == null) return null;

        return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      } catch (e) {
        return null;
      }
    }

    return null;
  }

  void startAutoSignOutTimer(Duration duration, BuildContext ctx) {
    _signOutTimer?.cancel();
    _signOutTimer = Timer(duration, () {
      signOut(ctx);
    });
  }

  void showToast(message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
