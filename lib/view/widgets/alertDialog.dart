import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AlertDialogWidget extends StatelessWidget {
  String ?title;
  String ?subTitle;
  GestureTapCallback? onPositiveClick;
  GestureTapCallback? onNegativeClick;
  String? positiveText;
  String? negativeText;

  AlertDialogWidget({this.title, this.subTitle, this.onPositiveClick,this.onNegativeClick,this.positiveText,this.negativeText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(subTitle!,
        style: TextStyle(
        ),
      ),
      actions: [
        TextButton(
          child: Text(
              negativeText??'Ok',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold)
          ),
          onPressed: onNegativeClick,
        ),
        TextButton(
            child: Text(
             positiveText?? 'Yes',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: onPositiveClick
        ),
      ],
    );
  }
}