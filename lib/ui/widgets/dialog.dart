import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../core/providers/userProvider.dart';

class CustomDialog {
  static Future<String> error({
    BuildContext context,
    Function onAction,
    Icon icon,
    @required String message,
    @required String buttonText,
    String button2Text,
    Function button2Action,
  }) async {
    String response = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              title: Center(child: Image.asset('assets/gifs/2vDi.gif')),
              content: Text(
                message,
                textAlign: TextAlign.center,
              ),
              actions: [
                SizedBox(
                  width: 100,
                  height: 48,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onAction();
                      },
                      child: Text(buttonText)),
                ),
                SizedBox(
                  width: 100,
                  height: 48,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        button2Action();
                      },
                      child: Text(button2Text)),
                ),
              ],
            ));
    return response;
  }
}
