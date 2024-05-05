import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future showRoundedCupertinoDialog({
  required BuildContext ctx,
  required String title,
  required String content,
}) {
  return showCupertinoDialog(
    context: ctx,
    builder: (context) => CupertinoAlertDialog(
      title: Text(
        title,
        // style: ,
        textAlign: TextAlign.center,
      ),
      content: Text(
        content,
        // style: AppTheme.body1,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'OK',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

CupertinoAlertDialog showCupertinoAlert(
    {required String title, required String message}) {
  return CupertinoAlertDialog(
    title: Text(
      title,
      //style: AppTheme.title,
      textAlign: TextAlign.center,
    ),
    content: Text(
      message,
      //style: AppTheme.body1,
      textAlign: TextAlign.center,
    ),
    actions: <Widget>[
      CupertinoDialogAction(
        onPressed: () => Get.back(),
        child: Text(
          'OK',
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}

Future showRoundedCupertinoDialogWithAction({
  required BuildContext ctx,
  required String title,
  required String content,
  required List<Widget> actions,
}) {
  return showCupertinoDialog(
    context: ctx,
    builder: (context) => Theme(
      data: ThemeData.light(),
      child: CupertinoAlertDialog(
        title: Text(
          title,
          // style: AppTheme.title,
          textAlign: TextAlign.center,
        ),
        content: Text(
          content,
          // style: AppTheme.body1,
          textAlign: TextAlign.center,
        ),
        actions: actions,
      ),
    ),
  );
}
