import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task_showroom/controller/dashboard_provider.dart';
import 'package:task_showroom/controller/login_provider.dart';
import 'package:task_showroom/core/utils/app_color.dart';
import 'package:task_showroom/core/utils/app_string.dart';
import 'package:task_showroom/core/utils/image_constant.dart';
import 'package:task_showroom/view/dashboard/dashboard.dart';
import 'package:task_showroom/view/widgets/app_bar.dart';
import 'package:task_showroom/view/widgets/app_button.dart';
import 'package:task_showroom/view/widgets/app_text_field.dart';

class AddNewCar extends StatefulWidget {
  String type = "";
  int? index = -1;

  AddNewCar({required this.type, this.index});

  @override
  State<AddNewCar> createState() => _AddNewCarState();
}

class _AddNewCarState extends State<AddNewCar> {
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  String dropdownvalue = 'Item 1';

  @override
  Widget build(BuildContext context) {
    // List of items in our dropdown menu
    LoginProvider loginProvider = Provider.of<LoginProvider>(context);

    int _value = 42;
    return Scaffold(
      appBar: appBar(
          text: widget.type == "new"
              ? AppString.addCar
              : AppString.updateCDetails,
          showLeading: true,
          leadingPressed: () {
            Get.back();
          }),
      body: SingleChildScrollView(
        child: Consumer<DashBoardProvider>(
          builder: (BuildContext context, dProvider, Widget? child) {
            return Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),

                    /// field for model

                    Text(AppString.enterVehicleName),
                    SizedBox(
                      height: 5.h,
                    ),
                    AppTextField(
                      controller: dProvider.carNameController,
                      hintText: AppString.carNameHint,
                      prefixIcon: ImageConstant.userIcon,
                      onChange: (val) {
                        dProvider.validateCarName();
                      },
                      errorMessage: dProvider.carNameError,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(AppString.enterVehicleModel),
                    SizedBox(
                      height: 5.h,
                    ),
                    AppTextField(
                      controller: dProvider.modelController,
                      hintText: AppString.hintModel,
                      prefixIcon: ImageConstant.userIcon,
                      onChange: (val) {
                        dProvider.validateModel();
                      },
                      errorMessage: dProvider.modelError,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(AppString.selectColor),
                    SizedBox(
                      height: 5.h,
                    ),
                    DropDownColors(
                        initialValue: dProvider.colorDropDownValue,
                        itemsList: dProvider.colors),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(AppString.selectManufacturer),
                    SizedBox(
                      height: 5.h,
                    ),
                    DropDownManufacturer(
                      initialValue: dProvider.manufacturerDropDownValue,
                      itemsList: dProvider.manufacturer,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(AppString.selectCategory),
                    SizedBox(
                      height: 5.h,
                    ),
                    DropDownCategory(
                      initialValue: dProvider.categoryDropDownValue,
                      itemsList: dProvider.categories,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),

                    /// field for registration
                    Text(AppString.enterRegistration),
                    SizedBox(
                      height: 5.h,
                    ),
                    AppTextField(
                      controller: dProvider.registrationController,
                      hintText: AppString.hintRegistration,
                      prefixIcon: ImageConstant.userIcon,
                      onChange: (val) {
                        dProvider.validateRegistration();
                      },
                      errorMessage: dProvider.registrationError,
                    ),

                    SizedBox(
                      height: 15.h,
                    ),
                    Text(AppString.enterOwnerName),
                    SizedBox(
                      height: 5.h,
                    ),
                    AppTextField(
                      controller: dProvider.ownerController,
                      hintText: AppString.ownerName,
                      prefixIcon: ImageConstant.userIcon,
                      onChange: (val) {
                        dProvider.validateRegistration();
                      },
                      errorMessage: dProvider.ownerError,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),

                    dProvider.uploadProcessing || dProvider.updateProcessing
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Center(
                            child: AppButton(
                              text: widget.type == "new"
                                  ? AppString.upload
                                  : AppString.update,
                              width: Get.width / 2,
                              onPressed: () {
                                if (widget.type == "new") {
                                  dProvider.uploadCarToSystem(
                                      context: context,
                                      uploadedBy:
                                          "${loginProvider.user.firstName!} ${loginProvider.user.lastName!}",
                                      uploaderId: loginProvider.user.userId!);
                                } else {
                                  // print("readyToUpdate");
                                  dProvider.updateCurrentCar(
                                      id: dProvider.allCars[widget.index!].id!,
                                      uploadedBy:
                                          " ${loginProvider.user.firstName} ${loginProvider.user.lastName}");
                                  // dProvider.updateCurrentCar(widget.index!);
                                }
                              },
                            ),
                          ),

                    SizedBox(
                      height: 20.h,
                    )
                  ],
                ));
          },
        ),
      ),
    );
  }

  Widget DropDownColors({
    required String initialValue,
    required List<String> itemsList,
  }) {
    DashBoardProvider dProvider = Provider.of<DashBoardProvider>(context);
    return Column(
      children: [
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          height: 50.h,
          decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.1),
              border: Border.all(
                color: AppColors.appColor,
              ),
              borderRadius: BorderRadius.circular(50.r)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: initialValue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: itemsList.map((items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                dProvider.updateColorDropDownValue(newValue: newValue!);
              },
            ),
          ),
        ),
        dProvider.applyValidation &&
                dProvider.colorDropDownValue == "Select one"
            ? Container(
                width: Get.width,
                margin: EdgeInsets.only(top: 5.h),
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Text(
                  AppString.selectColor,
                  style: TextStyle(color: AppColors.red),
                ),
              )
            : Container()
      ],
    );
  }

  Widget DropDownManufacturer({
    required String initialValue,
    required List<String> itemsList,
  }) {
    DashBoardProvider dProvider = Provider.of<DashBoardProvider>(context);
    return Column(
      children: [
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          height: 50.h,
          decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.1),
              border: Border.all(
                color: AppColors.appColor,
              ),
              borderRadius: BorderRadius.circular(50.r)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              // Initial Value
              value: initialValue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: itemsList.map((items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                dProvider.updateManufacturerDropDownValue(newValue: newValue!);
              },
            ),
          ),
        ),
        dProvider.applyValidation &&
                dProvider.manufacturerDropDownValue == "Select one"
            ? Container(
                width: Get.width,
                margin: EdgeInsets.only(top: 5.h),
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Text(
                  AppString.selectManufacturer,
                  style: TextStyle(color: AppColors.red),
                ),
              )
            : Container()
      ],
    );
  }

  Widget DropDownCategory({
    required String initialValue,
    required List<String> itemsList,
  }) {
    DashBoardProvider dProvider = Provider.of<DashBoardProvider>(context);
    return Column(
      children: [
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          height: 50.h,
          decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.1),
              border: Border.all(
                color: AppColors.appColor,
              ),
              borderRadius: BorderRadius.circular(50.r)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              // Initial Value
              value: initialValue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: itemsList.map((items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                dProvider.updateCategoryDropDownValue(newValue: newValue!);
              },
            ),
          ),
        ),
        dProvider.applyValidation &&
                dProvider.categoryDropDownValue == "Select one"
            ? Container(
                width: Get.width,
                margin: EdgeInsets.only(top: 5.h),
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Text(
                  AppString.selectCategory,
                  style: TextStyle(color: AppColors.red),
                ),
              )
            : Container()
      ],
    );
  }
}
