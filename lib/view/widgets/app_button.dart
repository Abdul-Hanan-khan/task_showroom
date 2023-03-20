import 'package:flutter/material.dart';
import 'package:task_showroom/core/utils/app_color.dart';


class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;

  final double? height;
  final double? width;
  final Color? color;
  final Color? textColor;
  final Color? iconColor;
  final bool? border;
  final double? fs;
  final double? radius;

  const AppButton({
    Key? key,
    this.onPressed,
    this.text,
    this.height,
    this.width,
    this.color,
    this.border = false,
    this.textColor,
    this.iconColor,
    this.fs,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: AppColors.appColor,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        elevation: 0,
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 50),
          color: color ?? Colors.black,
          border: border == true ? Border.all(color: AppColors.appColor) : null,
        ),
        child: SizedBox(
          height: height ?? 45,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text!,
                style: TextStyle(
                  fontSize: fs ?? 16,
                  color: textColor ?? Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
