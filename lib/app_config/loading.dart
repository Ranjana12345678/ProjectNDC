import 'dart:ui';

import 'package:flutter/material.dart';

class Loading {
  showLoadingDialog(BuildContext context) {
    return showDialog<void>(
        barrierColor: Colors.transparent,
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: SimpleDialog(
                      backgroundColor: Colors.white,
                      children: <Widget>[
                        Center(
                          child: Column(children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Please Wait....",
                              style: TextStyle(color: Colors.blueAccent),
                            )
                          ]),
                        )
                      ]))
          );
        });
  }
}
