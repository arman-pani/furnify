import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:furnify/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<UserModel> getUserFromPrefs() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  debugPrint(
      "user info: ${prefs.getString('firstName')}, ${prefs.getString('lastName')}, ${prefs.getString('phoneNumber')}, ${prefs.getString('userId')}, ${prefs.getString('createdAt')}");
  final userInfo = UserModel(
    id: prefs.getString('userId')!,
    firstName: prefs.getString('firstName')!,
    lastName: prefs.getString('lastName')!,
    phoneNumber: prefs.getString('phoneNumber')!,
    profileImage: base64Decode(prefs.getString('profileImage')!),
    createdAt: DateTime.parse(prefs.getString('createdAt')!),
  );
  debugPrint('User info: $userInfo');

  return userInfo;
}

Future<void> saveUserToPrefs(UserModel userInfo) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('firstName', userInfo.firstName);
  await prefs.setString('lastName', userInfo.lastName);
  await prefs.setString('phoneNumber', userInfo.phoneNumber);
  await prefs.setString('profileImage', base64Encode(userInfo.profileImage));
  await prefs.setString('userId', userInfo.id);
  await prefs.setString('createdAt', userInfo.createdAt.toString());
}
