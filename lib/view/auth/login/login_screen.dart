import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task_showroom/controller/login_provider.dart';
import 'package:task_showroom/core/utils/app_color.dart';
import 'package:task_showroom/core/utils/app_string.dart';
import 'package:task_showroom/core/utils/constant_sizebox.dart';
import 'package:task_showroom/core/utils/image_constant.dart';

import 'package:task_showroom/view/auth/signup/signup_screen.dart';
import 'package:task_showroom/view/widgets/app_button.dart';
import 'package:task_showroom/view/widgets/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    ImageConstant.authbg,
                  ),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: constraints.copyWith(
                minHeight: constraints.maxHeight,
                maxHeight: double.infinity,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const Spacer(),
                      Consumer<LoginProvider>(
                          builder: (context, provider, child) {
                        return Column(
                          children: [
                            Text(
                              AppString.login,
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            hSizedBox10,
                            Text(
                              AppString.loginDetails,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(.5),
                              ),
                            ),
                            hSizedBox30,
                            AppTextField(
                              controller: provider.userNameController,
                              hintText: AppString.userName,
                              prefixIcon: ImageConstant.userIcon,
                              onChange: (val) {
                                provider.validateUname();
                              },
                              errorMessage: provider.userNameError,
                            ),
                            hSizedBox4,
                            AppTextField(
                              controller: provider.passwordController,
                              obsecureText: provider.passwordObscure,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  provider.toggleObscurePwd();
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(14.sp),
                                  child: Image.asset(
                                    ImageConstant.secure,
                                    height: 20,
                                    width: 20,
                                    color: provider.passwordObscure
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ),
                              hintText: AppString.password,
                              prefixIcon: ImageConstant.password,
                              onChange: (val) {
                                provider.validatePwd();
                              },
                              errorMessage: provider.passwordError,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size(50.w, 0),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    alignment: Alignment.centerLeft),
                                onPressed: () {
                                  // Get.to(ForgotPasswordScreen());
                                },
                                child: Text(
                                  AppString.forgotPassword,
                                  style: const TextStyle(
                                    color: Color(0xff1EB8AC),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Get.height * 0.07),
                            provider.loginProcessing
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : AppButton(
                                    text: AppString.login,
                                    width: Get.width / 2,
                                    onPressed: () {
                                      provider.onLogin(context);
                                    },
                                  )
                          ],
                        );
                      }),
                      const Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppString.dontHaveanAccount,
                            style: TextStyle(
                                color: const Color(0xff8E8E8E),
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.offAll(SignUpScreen());
                            },
                            child: Text(
                              AppString.register,
                              style: TextStyle(
                                  color: AppColors.appColor,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  fontSize: 14.sp),
                            ),
                          )
                        ],
                      ),
                      hSizedBox10,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
