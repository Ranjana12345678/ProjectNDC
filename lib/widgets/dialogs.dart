import 'dart:ui';

import 'package:flutter/material.dart';

enum DilogAction {yes , no}

class Dialogs {
  static Future<DilogAction> yesNoDialog(BuildContext context,String title,String body) async {
    final action = await showDialog(
      barrierColor: Colors.transparent,
        barrierDismissible: false,
        context: context,
        builder: (context){
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: AlertDialog(
              title: Text(title),
              content: Text(body),
              actions: [
                TextButton(onPressed: (){
                  Navigator.of(context).pop(DilogAction.no);
                }, child: const Text("No")),
                TextButton(onPressed: (){
                  Navigator.of(context).pop(DilogAction.yes);
                }, child: const Text("Yes")),
              ],
              backgroundColor: Colors.white.withOpacity(0.9),
              elevation: 1,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          );
        });
    return (action != null) ? action :DilogAction.no;
  }

}