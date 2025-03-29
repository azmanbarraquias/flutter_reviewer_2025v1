import 'package:flutter/foundation.dart'; // For kIsWeb
import 'dart:io' show Platform; // For checking mobile platforms

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function() handler;

  const AdaptiveFlatButton(this.text, this.handler, {super.key});

  @override
  Widget build(BuildContext context) {
    bool isIOS = !kIsWeb && Platform.isIOS; // Only check Platform.isIOS if not on Web
    // bool isAndroid = !kIsWeb && Platform.isAndroid; // Only check Platform.isAndroid if not on Web

    return isIOS
        ? CupertinoButton(
          onPressed: handler,
          child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
        )
        : TextButton(
          onPressed: handler,
          child: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
  }
}
