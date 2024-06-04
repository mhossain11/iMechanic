/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */

import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../config/colors/colors.dart';




class AnimatedDialogs {
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double? headerFontSize;
  static loginDialog(
    BuildContext context, {
    required VoidCallback onSignUp,
    required VoidCallback onCancel,
    required String texts,
  }) {
    return showGeneralDialog(
      context: context,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              title: const Text(
                "Dear User",
                style: TextStyle(color: green),
              ),
              contentPadding: EdgeInsets.all(0),
              content: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: screenHeight * .2,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Please Sign up before ordering chickens"),
                    ),
                    Expanded(child: Container()),
                    Row(
                      children: [
                        Expanded(
                            flex: 50,
                            child: InkWell(
                              onTap: onCancel,
                              child: Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: red,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10))),
                                alignment: Alignment.center,
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          headerFontSize! * 1),
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 50,
                            child: InkWell(
                              onTap: onSignUp,
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10))),
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: green,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          headerFontSize! * 1),
                                ),
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              )),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: anim,
          child: child,
        );
        // return SlideTransition(
        //   position: Tween(begin: Offset(-1, 0), end: Offset(0, 0)).animate(anim1),
        //   child: child,
        // );
      },
    );
  }

  static Future showLoginDialog(BuildContext context) {
    return showWidgetDialog(context, title: 'Login', dismissible: false,
        onTap: () {
      Navigator.pop(context);
    //  Navigator.push(context, SlideRightRoute(page: LoginScreen()));
    },
        actions: true,
        widget: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Session expired, Please Login now',
              textAlign: TextAlign.center,
            )
          ],
        ));
  }

  static Future showWidgetDialog(BuildContext context,
      {required Widget widget,
      required Function onTap,
      required String title,
      bool actions = true,
      bool dismissible = false}) {
    return showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (BuildContext ctx) {
          return AlertDialog(
              title: Text(
                title ?? "Failed!",
                textAlign: TextAlign.center,
              ),
              actions: (actions)
                  ? <Widget>[
                      TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              textStyle: const TextStyle(color: Colors.white)),
                          onPressed:(){Navigator.pop(context);},
                          child: const Text("Ok"),),
                    ]
                  : null,
              content: widget);
        });
  }

  static approvalDialog(
    BuildContext contexts, {
    required String texts,
  }) {
    return showGeneralDialog(
      context: contexts,
      barrierLabel: MaterialLocalizations.of(contexts).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              title: const Text(
                "Success",
                style: TextStyle(color: green),
              ),
              contentPadding: const EdgeInsets.all(0),
              content: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: screenHeight * .2,
                child: Column(
                  children: [
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(texts),
                    ),
                    Expanded(child: Container()),
                    Row(
                      children: [
                        Expanded(
                            flex: 50,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: red,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10))),
                                alignment: Alignment.center,
                                child: Text(
                                  'Close',
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          headerFontSize! * 1),
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 50,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                // Navigator.push(context,
                                //     SlideRightRoute(page: OrderListScreen()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10))),
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  'My Orders',
                                  style: TextStyle(
                                      color: green,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          headerFontSize! * 1),
                                ),
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              )),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: anim,
          child: child,
        );
        // return SlideTransition(
        //   position: Tween(begin: Offset(-1, 0), end: Offset(0, 0)).animate(anim1),
        //   child: child,
        // );
      },
    );
  }

  static confirmDialog(
    BuildContext context, {
    required VoidCallback onNo,
    required VoidCallback onYes,
    required String noText,
    required String yesText,
    required String title,
    required String subtitle,
  }) {
    return showGeneralDialog(
      context: context,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              title: Text(
                title.toString(),
                style: const TextStyle(color: green),
              ),
              contentPadding: const EdgeInsets.all(0),
              content: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: screenHeight * .2,
                child: Column(
                  children: [
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(subtitle),
                    ),
                    Expanded(child: Container()),
                    Row(
                      children: [
                        Expanded(
                            flex: 50,
                            child: InkWell(
                              onTap: onNo,
                              child: Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: red,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10))),
                                alignment: Alignment.center,
                                child: Text(
                                  noText,
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          headerFontSize! * 1),
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 50,
                            child: InkWell(
                              onTap: onYes,
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10))),
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  yesText,
                                  style: TextStyle(
                                      color: green,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          headerFontSize! * 1),
                                ),
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              )),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: anim,
          child: child,
        );
        // return SlideTransition(
        //   position: Tween(begin: Offset(-1, 0), end: Offset(0, 0)).animate(anim1),
        //   child: child,
        // );
      },
    );
  }

  static deleteDialog(
    BuildContext context, {
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
    required String texts,
  }) {
    return showGeneralDialog(
      context: context,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: Text(texts ?? "Are you sure you wish to delete this item?"),
          actions: <Widget>[
            TextButton(onPressed: onConfirm, child: const Text("DELETE")),
            TextButton(
              onPressed: () => onCancel(),
              child: const Text("CANCEL"),
            ),
          ],
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: anim,
          child: child,
        );
        // return SlideTransition(
        //   position: Tween(begin: Offset(-1, 0), end: Offset(0, 0)).animate(anim1),
        //   child: child,
        // );
      },
    );
  }

  static locationPermissionDialog(
    BuildContext context, {
    required VoidCallback onConfirm,
    required String texts,
  }) {
    return showGeneralDialog(
      context: context,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return AlertDialog(
          title: const Text("Permission"),
          content: Text(texts ?? "Location permission is needed"),
          actions: <Widget>[
            TextButton(onPressed: onConfirm, child: const Text("Ok"))
          ],
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: anim,
          child: child,
        );
        // return SlideTransition(
        //   position: Tween(begin: Offset(-1, 0), end: Offset(0, 0)).animate(anim1),
        //   child: child,
        // );
      },
    );
  }

  static locationPermissionDeniedDialog(
    BuildContext context, {
    required VoidCallback onConfirm,
    required String texts,
  }) {
    return showGeneralDialog(
      context: context,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return AlertDialog(
          title: const Text("Permission"),
          content: Text(texts ??
              "Location permission is denied, please go to app settings and give permission"),
          actions: <Widget>[
            TextButton(
                onPressed: onConfirm, child: const Text("Open App Settings"))
          ],
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: anim,
          child: child,
        );
        // return SlideTransition(
        //   position: Tween(begin: Offset(-1, 0), end: Offset(0, 0)).animate(anim1),
        //   child: child,
        // );
      },
    );
  }

  static removeItemDialog(
    BuildContext context, {
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) {
    return showGeneralDialog(
      context: context,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure you wish to remove this item?"),
          actions: <Widget>[
            TextButton(
                onPressed: () => onConfirm(), child: const Text("REMOVE")),
            TextButton(
              onPressed: () => onCancel(),
              child: const Text("CANCEL"),
            ),
          ],
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: anim,
          child: child,
        );
        // return SlideTransition(
        //   position: Tween(begin: Offset(-1, 0), end: Offset(0, 0)).animate(anim1),
        //   child: child,
        // );
      },
    );
  }

  static clearAllDialog(
    BuildContext context, {
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) {
    return showGeneralDialog(
      context: context,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure to clear all item in cart?"),
          actions: <Widget>[
            TextButton(
                onPressed: () => onConfirm(), child: const Text("CLEAR")),
            TextButton(
              onPressed: () => onCancel(),
              child: const Text("CANCEL"),
            ),
          ],
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: anim,
          child: child,
        );
        // return SlideTransition(
        //   position: Tween(begin: Offset(-1, 0), end: Offset(0, 0)).animate(anim1),
        //   child: child,
        // );
      },
    );
  }

  static successDialog(BuildContext context,
      {required VoidCallback onResponse,
      required String title,
      required String subtitle,
      String buttonText = "Okay"}) {
    return showGeneralDialog(
      context: context,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 100),
      barrierDismissible: true,
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: AlertDialog(
            backgroundColor: white,
            title: Text(
              title,
              style: TextStyle(color: black),
            ),
            content: Text(
              subtitle,
              style: TextStyle(color: colorSubtitle),
            ),
            actions: <Widget>[
              TextButton(
                  style: TextButton.styleFrom(backgroundColor: colorTheme),
                  onPressed: () => onResponse(),
                  child: Text(
                    buttonText,
                    style: TextStyle(color: white),
                  )),
            ],
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: anim,
          child: child,
        );
        // return SlideTransition(
        //   position: Tween(begin: Offset(-1, 0), end: Offset(0, 0)).animate(anim1),
        //   child: child,
        // );
      },
    );
  }
}
