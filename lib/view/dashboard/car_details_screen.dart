import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task_showroom/controller/dashboard_provider.dart';
import 'package:task_showroom/core/utils/app_color.dart';
import 'package:task_showroom/core/utils/app_string.dart';
import 'package:task_showroom/model/cars_model.dart';
import 'package:task_showroom/view/dashboard/add_new_car.dart';
import 'package:task_showroom/view/widgets/app_bar.dart';

class CarDetailsScreen extends StatelessWidget {
  Car car = Car();
  int index;

  CarDetailsScreen(this.car, this.index);

  @override
  Widget build(BuildContext context) {
    DashBoardProvider dProvider =
        Provider.of<DashBoardProvider>(context, listen: false);
    return Scaffold(
      // appBar: appBar(text: "Car Details",showLeading: true,showAction: true,action:  ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width,
              ),
              Stack(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: 15.sp,
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        width: Get.width * 0.65,
                        height: Get.height * 0.3,
                        child: Image.asset(
                          "assets/images/car/carimage.png",
                          fit: BoxFit.contain,
                        )),
                  ),
                  Positioned(
                      top: 35.h,
                      left: 25.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            car.carName!,
                            style: TextStyle(
                                color: AppColors.appColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.sp),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            car.model!,
                            style: TextStyle(
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ))
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.w, right: 20.w),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppString.overview,
                      style: TextStyle(
                          fontSize: 33.sp,
                          color: AppColors.appColor,
                          fontWeight: FontWeight.w300),
                    ),
                    GestureDetector(
                      onTap: () {
                        dProvider.initializeCurrentCarSettings(index);
                        Get.off(AddNewCar(
                          type: "update",
                          index: index,
                        ));
                      },
                      child: Container(
                        width: 35.sp,
                        height: 30,
                        decoration: BoxDecoration(
                          // color: Colors.grey,
                          border: Border.all(color: AppColors.grey),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.edit,
                            color: AppColors.grey,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 35.w),
                child: Column(
                  children: [
                    carTile(title: "Owner Name", subtitle: car.owner!),
                    carTile(title: "Category", subtitle: car.category!),
                    carTile(title: "Make", subtitle: car.make!),
                    carTile(title: "Registration", subtitle: car.registration!),
                    carTile(title: "Model", subtitle: car.model!),
                    carTile(title: "Color", subtitle: car.color!),
                    carTile(title: "Uploaded By", subtitle: car.uploadedBy!),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget carTile({required String title, required String subtitle}) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: EdgeInsets.all(15.sp),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: AppColors.grey),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        )
      ],
    );
  }
}
