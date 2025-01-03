import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:furnify/models/billing_model.dart';

double calculateGrandTotal(List<BillingModel> billingItems) {
  double total = 0.0;

  for (var item in billingItems) {
    total += item.amount;
  }

  return total;
}

Future<String> getImageUrl(String imageName) async {
  final ref = FirebaseStorage.instance.ref().child(imageName);
  var url = await ref.getDownloadURL();
  debugPrint("$imageName : $url");
  return url;
}

Future<List<String>> getMultipleImageUrls(List<String> imageNames) async {
  List<String> imageUrls = [];
  for (var name in imageNames) {
    var url = await getImageUrl(name);
    imageUrls.add(url);
  }
  return imageUrls;
}
