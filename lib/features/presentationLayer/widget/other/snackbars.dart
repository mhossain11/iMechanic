/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */

import 'package:flutter/material.dart';

import '../../../../config/colors/colors.dart';

class SnackBars {
  static double? headerFontSize;
  static closeSnackBar(context){

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
  static showSnackBar(
      {required BuildContext context,
      required String content,
      required bool success,
      bool actionShow = false,
      dynamic routeAction,
      int durationSec = 2}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          success
              ? const Icon(
                  Icons.done_all,
                  color: green,
                )
              : const Icon(
                  Icons.error_outline_sharp,
                  color: red,
                ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
              child: Text(
            content,
            style: TextStyle(fontSize: headerFontSize! * .8),
          )),
        ],
      ),
      duration: Duration(seconds: durationSec),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ));
  }
}
