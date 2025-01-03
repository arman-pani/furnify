import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furnify/app_router.dart';
import 'package:furnify/models/user_model.dart';
import 'package:furnify/services/common_methods.dart';
import 'package:furnify/utils/show_snackbar.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  FirebaseAuthMethods(
    this._auth,
    this._firestore,
  );

  Future<void> saveUserProfile({
    required String firstName,
    required String lastName,
    required Uint8List profileImage,
    required String phoneNumber,
    required BuildContext context,
  }) async {
    try {
      if (firstName.isEmpty) {
        throw Exception("First name cannot be empty.");
      }
      if (lastName.isEmpty) {
        throw Exception("Last name cannot be empty.");
      }
      if (phoneNumber.isEmpty) {
        throw Exception("Phone number cannot be empty.");
      }

      final phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
      if (!phoneRegex.hasMatch(phoneNumber.trim())) {
        throw Exception(
            "Invalid phone number format. Use +<CountryCode><Number>.");
      }

      final user = _auth.currentUser;

      if (user == null) {
        throw Exception("No authenticated user found. Please log in again.");
      }

      final createdAt = DateTime.now();

      // Save user profile to Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'createdAt': createdAt,
        'profileImage': profileImage,
      });

      final userInfo = UserModel(
        id: user.uid,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        createdAt: createdAt,
        profileImage: profileImage,
      );

      await saveUserToPrefs(userInfo);

      showSnackBar(
        context: context,
        text: "Profile saved successfully!",
      );
    } catch (error) {
      showSnackBar(
        context: context,
        text: error.toString(),
      );
    }
  }

  // SIGN UP WITH EMAIL AND PASSWORD
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    try {
      if (password == confirmPassword) {
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        return showSnackBar(
          context: context,
          text: "Password and confirm password do not match.",
        );
      }

      Navigator.of(context).push(AppRouter.setupProfilePage(null));
    } on FirebaseAuthException catch (error) {
      String message;
      if (error.code == 'email-already-in-use') {
        message = 'This email is already in use. Please try a different email.';
      } else if (error.code == 'invalid-email') {
        message = 'The email address is invalid. Please enter a valid email.';
      } else if (error.code == 'weak-password') {
        message =
            'The password is too weak. Please choose a stronger password.';
      } else {
        message = 'An error occurred. Please try again later.';
      }
      showSnackBar(
        context: context,
        text: message,
      );
    }
  }

  // LOGIN WITH EMAIL AND PASSWORD
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final userCredentials = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint("User Credentials : $userCredentials");

      final userDoc = await _firestore
          .collection('users')
          .doc(userCredentials.user!.uid)
          .get();

      final userInfo = UserModel.fromMap(userDoc.data()!);

      await saveUserToPrefs(userInfo);

      debugPrint(userInfo.toString());

      Navigator.of(context).push(AppRouter.indexPage());
    } on FirebaseAuthException catch (error) {
      String message;
      if (error.code == 'user-not-found') {
        message = 'User not found';
      } else if (error.code == 'wrong-password') {
        message = 'Wrong password';
      } else {
        message = 'An error occured. Please try again later';
      }
      showSnackBar(
        context: context,
        text: message,
      );
    }
  }

  // EMAIL VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (error) {
      showSnackBar(context: context, text: error.message!);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      debugPrint("Google Sign-In triggered. User: ${googleUser?.email}");

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      debugPrint(
          "Authentication details retrieved: Access Token - ${googleAuth?.accessToken != null}, ID Token - ${googleAuth?.idToken != null}");

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        debugPrint("Firebase Auth credential created.");

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        debugPrint(
            "Firebase Auth sign-in successful. User ID: ${userCredential.user?.uid}");

        // if you want to do specific task like storing information in firestore
        // only for new users using google sign in (since there are no two options
        // for google sign in and google sign up, only one as of now),
        // do the following:

        if (userCredential.user != null) {
          if (userCredential.additionalUserInfo!.isNewUser) {
            debugPrint("New user detected. Navigating to setup profile page.");
            Navigator.of(context).push(AppRouter.setupProfilePage(null));
          } else {
            debugPrint("Existing user detected. Navigating to index page.");
            Navigator.of(context).push(AppRouter.indexPage());
          }
        }
      }
    } on FirebaseAuthException catch (error) {
      showSnackBar(context: context, text: error.message!);
    }
  }

  Future<void> sendPasswordResetLink(BuildContext context, String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      Navigator.of(context).pop();
    } on FirebaseAuthException catch (error) {
      String message;
      if (error.code == 'user-not-found') {
        message = 'There is no user with this email address.';
      } else if (error.code == 'invalid-email') {
        message = 'The email address is invalid. Please enter a valid email.';
      } else {
        message = error.message!;
      }
      showSnackBar(context: context, text: message);
    }
  }
}
