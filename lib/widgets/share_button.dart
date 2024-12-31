import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:material_symbols_icons/symbols.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  final String shareText;
  final String imageUrl;
  const ShareButton(
      {super.key, required this.shareText, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    void shareProductDetails() async {
      final url = Uri.parse(imageUrl);
      final response = await http.get(url);
      final bytes = response.bodyBytes;
      debugPrint("HTTP Status Code: ${response.statusCode}");

      final temp = await getTemporaryDirectory();
      final path = '${temp.path}/shared_image.jpg';
      File(path).writeAsBytesSync(bytes);

      await Share.shareXFiles([XFile(path)], text: shareText);
    }

    return GestureDetector(
      onTap: shareProductDetails,
      child: const Icon(
        Symbols.share_rounded,
        size: 25,
        weight: 600,
      ),
    );
  }
}
