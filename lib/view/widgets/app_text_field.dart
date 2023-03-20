import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:task_showroom/core/utils/app_color.dart';
import 'package:task_showroom/core/utils/constant_sizebox.dart';


class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? prefixIcon;
  final bool? icon;
  final String? keyValue;
  final String? hintText;
  final String? initialValue;
  final Widget? suffixIcon;
  final String? Function(String?)? validate;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmitted;
  final bool obsecureText;
  final bool border;
  final bool shadow;
  final bool devider;
  final TextInputType? keyboardType;
  final int maxLines;
  final Color? color;
  final Color? bgcolor;
  final List<TextInputFormatter>? inputFormatters;
  final String errorMessage;
  final bool readonly;
  final Function()? ontap;
  final double? radius;
  final TextInputType? fieldInputType;
  final Color? iconColor;

  const AppTextField({
    Key? key,
    this.controller,
    this.prefixIcon,
    this.icon = true,
    this.keyValue = "1",
    this.hintText,
    this.initialValue,
    this.suffixIcon,
    this.validate,
    this.onChange,
    this.onFieldSubmitted,
    this.obsecureText = false,
    this.border = true,
    this.shadow = false,
    this.devider = true,
    this.keyboardType ,
    this.maxLines = 1,
    this.color,
    this.inputFormatters,
    required this.errorMessage,
    this.readonly = false,
    this.ontap,
    this.radius,
    this.fieldInputType,
    this.iconColor,
    this.bgcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(radius ?? 50),
            boxShadow: shadow
                ? [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ]
                : [],
          ),
          child: TextFormField(
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            initialValue: initialValue,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15.0,
            ),
            onTap: ontap,
            readOnly: readonly,
            controller: controller,
            keyboardType: keyboardType??TextInputType.text,
            onChanged: onChange,
            inputFormatters: inputFormatters,
            cursorColor: AppColors.appColor,
            obscureText: obsecureText,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              isCollapsed: true,
              contentPadding: const EdgeInsets.all(15),
              // fillColor: bgcolor ??
              //     (Get.isDarkMode ? Colors.transparent : Colors.white),
              filled: true,
              prefix: prefixIcon != null ? null : wSizedBox20,
              prefixIcon: prefixIcon != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 10),
                          child: Image.asset(
                            prefixIcon!,
                            height: 25,
                            width: 25,
                            color: iconColor ?? AppColors.appIconColor,
                          ),
                        ),
                      ],
                    )
                  : null,
              suffixIcon: suffixIcon,
              hintStyle: const TextStyle(
                fontSize: 15.0,
                color: Colors.grey,
              ),
              focusedErrorBorder: border == true
                  ? OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.teal, width: 2),
                      borderRadius: BorderRadius.circular(radius ?? 50),
                    )
                  : InputBorder.none,
              focusedBorder: border == true
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.appColor.withOpacity(.5), width: 2),
                      borderRadius: BorderRadius.circular(radius ?? 50),
                    )
                  : InputBorder.none,
              enabledBorder: border == true
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: shadow
                            ? Colors.transparent
                            : const Color(0xff8D8D8D).withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(radius ?? 50),
                    )
                  : InputBorder.none,
              isDense: false,
            ),
          ),
        ),
        errorMessage == ""?Container(): Container(
          padding: const EdgeInsets.only(
              left: 10, right: 10, top: 5, bottom: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            errorMessage,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        )
      ],
    );
  }
}
