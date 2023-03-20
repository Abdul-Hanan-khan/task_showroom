import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_showroom/core/utils/app_color.dart';
import 'package:task_showroom/core/utils/constant_sizebox.dart';
import 'package:task_showroom/core/utils/image_constant.dart';

AppBar appBar({
  Function()? actionPressed,
  Function()? leadingPressed,
  String? text,
  bool? back,
  Color? backgroundColor,
  String? action,
  bool? actionIcon,
  Widget? actionWidget,
  bool? search,
  bool?showLeading,
  bool?showAction
}) =>
    AppBar(
      backgroundColor: backgroundColor ?? AppColors.secondaryColor,
      elevation: 0,
      leading:showLeading??false? Row(
        children: [
          Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              constraints: const BoxConstraints(),
              icon: Image.asset(
                back == true ? ImageConstant.back : ImageConstant.menu,
                color: backgroundColor == AppColors.appColor
                    ? Colors.white
                    : Colors.black,
                height: back == true ? 18 : 20,
              ),
              onPressed: leadingPressed ??
                  () {
                    Get.back();
                  },
            ),
          ),
        ],
      ):Container(),
      centerTitle: true,
      title: Text(
        text!,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: backgroundColor == AppColors.appColor
              ? Colors.white
              : Colors.black,
        ),
      ),
      actions: <Widget>[
      showAction??false?  Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: actionPressed,
              child: Icon(
                Icons.add,
                size: 26.0,
                color: AppColors.appColor,
              ),
            )
        ):Container(),
        // search == true
        //     ? IconButton(
        //         icon: Image.asset(
        //           ImageConstant.search,
        //           height: 20,
        //         ),
        //         onPressed: () {
        //           // Get.toNamed(AppRoutes.searchScreen);
        //         },
        //       )
        //     : const SizedBox(),
        // if (actionIcon??false)
        //   IconButton(
        //     icon: Image.asset(
        //       action ?? ImageConstant.notification,
        //       color: backgroundColor == AppColors.appColor
        //           ? Colors.white
        //           : Colors.black,
        //       height: 20,
        //     ),
        //     onPressed: actionPressed ??
        //         () {
        //           // Get.toNamed(AppRoutes.notificationScreen);
        //         },
        //   ),
        wSizedBox14,
      ],
    );
