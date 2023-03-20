import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task_showroom/controller/signup_provider.dart';
import 'package:task_showroom/core/utils/app_color.dart';
import 'package:task_showroom/core/utils/app_string.dart';
import 'package:task_showroom/core/utils/constant_sizebox.dart';
import 'package:task_showroom/core/utils/image_constant.dart';
import 'package:task_showroom/view/auth/login/login_screen.dart';
import 'package:task_showroom/view/widgets/app_button.dart';
import 'package:task_showroom/view/widgets/app_text_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

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
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: Get.height * 0.14),
                      Consumer<SigunUPProvider>(
                          builder: (context, provider, child) {
                        return Column(
                          children: [
                            Text(
                              AppString.signup,
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            hSizedBox10,
                            Text(
                              AppString.signupDetails,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            hSizedBox30,
                            AppTextField(
                              controller: provider.firstNameController,
                              hintText: AppString.firstName,
                              prefixIcon: ImageConstant.userIcon,
                              onChange: (val) {
                                provider.validateFirstName();
                              },
                              errorMessage: provider.firstNameError,
                            ),
                            AppTextField(
                              controller: provider.lastNameController,
                              hintText: AppString.lastName,
                              prefixIcon: ImageConstant.userIcon,
                              onChange: (val) {
                                provider.validateLastName();
                              },
                              errorMessage: provider.lastNameError,
                            ),
                            hSizedBox4,
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
                              controller: provider.phoneController,
                              hintText: AppString.phNo,
                              keyboardType: TextInputType.phone,
                              prefixIcon: ImageConstant.call,
                              onChange: (val) {
                                provider.validatePhoneNo();
                              },
                              errorMessage: provider.phoneNoError,
                            ),
                            AppTextField(
                              controller: provider.emailController,
                              hintText: AppString.email,
                              prefixIcon: ImageConstant.email,
                              onChange: (val) {
                                provider.validateEmail();
                              },
                              errorMessage: provider.emailNameError,
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
                                  padding: const EdgeInsets.all(14),
                                  child: Image.asset(
                                    ImageConstant.secure,
                                    height: 20,
                                    width: 20,
                                    color: provider.passwordObscure
                                        ? AppColors.red
                                        : Colors.green,
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
                            SizedBox(height: Get.height * 0.07),
                            provider.processing
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : AppButton(
                                    text: AppString.signup,
                                    width: Get.width / 2,
                                    onPressed: () {
                                      provider.onSignUp(context);
                                    },
                                  ),
                            hSizedBox10,
                            Text(
                              AppString.or,
                              style: const TextStyle(
                                color: Color(0xff8E8E8E),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            hSizedBox10,
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  socialLoginButton(
                                      image: ImageConstant.google,
                                      onTap: () {}),
                                  socialLoginButton(
                                      image: ImageConstant.facebook,
                                      onTap: () {}),
                                  socialLoginButton(
                                      image: ImageConstant.apple, onTap: () {}),
                                ])
                          ],
                        );
                      }),
                      hSizedBox24,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppString.alreadyHaveanAccount,
                            style: const TextStyle(
                                color: Color(0xff8E8E8E),
                                fontWeight: FontWeight.w400,
                                fontSize: 13),
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.to(LoginScreen());
                              },
                              child: Text(
                                AppString.login,
                                style: TextStyle(
                                    color: AppColors.appColor,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    fontSize: 14.sp),
                              )),
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

  socialLoginButton({image, onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(6),
        height: 40.h,
        width: 70.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: const Color(0xffD4D4D4)),
        ),
        child: Image.asset(image),
      ),
    );
  }
}
