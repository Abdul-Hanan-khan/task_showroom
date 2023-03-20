import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task_showroom/controller/dashboard_provider.dart';
import 'package:task_showroom/controller/login_provider.dart';
import 'package:task_showroom/core/utils/app_color.dart';
import 'package:task_showroom/core/utils/image_constant.dart';
import 'package:task_showroom/model/cars_model.dart';
import 'package:task_showroom/view/auth/login/login_screen.dart';
import 'package:task_showroom/view/dashboard/add_new_car.dart';
import 'package:task_showroom/view/dashboard/car_details_screen.dart';
import 'package:task_showroom/view/widgets/alertDialog.dart';
import 'package:task_showroom/view/widgets/app_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    // var loginProvider = Provider.of<LoginProvider>(context);
    DashBoardProvider dashboardProvider =
        Provider.of<DashBoardProvider>(context, listen: false);
    dashboardProvider.getCarsInSystem();

    return Scaffold(
      appBar: appBar(
        text: "All Cars",
        leadingPressed: () {
          showDialog(
            barrierColor: const Color.fromRGBO(0, 0, 0, 0.76),
            context: context,
            builder: (BuildContext context) {
              return AlertDialogWidget(
                  title: "Alert",
                  subTitle: "Are Your Sure Logout",
                  positiveText: "Yes",
                  negativeText: "No",
                  onNegativeClick: () {
                    Get.back();
                  },
                  onPositiveClick: () {
                    Get.off(LoginScreen());
                    loginProvider.deleteUserInfo();
                    // Get.back();
                  });
            },
          );

          // Get.off(LoginScreen());
        },
        showLeading: true,
        actionIcon: true,
        showAction: true,
        actionPressed: () {
          // print("somethings");
          Get.to(AddNewCar(
            type: "new",
          ));
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10.sp),
          child: Column(
            children: [
              Center(
                child: Consumer<DashBoardProvider>(
                  builder: (context, dProvider, child) {
                    return dProvider.getCarsProcessing
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                width: Get.width,
                                height: 80.h,
                                child: ListView.separated(
                                  itemCount: dProvider.categories.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        dProvider.getFilteredCars(index: index);
                                      },
                                      child: itemCategory(
                                          text: dProvider.categories[index] ==
                                                  "Select one"
                                              ? "All"
                                              : dProvider.categories[index],
                                          index: index),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      width: 10.w,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: dProvider.allCars.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(CarDetailsScreen(
                                          dProvider.allCars[index], index));
                                    },
                                    child: itemAvailableCars(
                                        dProvider.allCars[index], index),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 15.h,
                                  );
                                },
                              ),
                            ],
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemAvailableCars(Car car, int index) {
    DashBoardProvider dashBoardProvider =
        Provider.of<DashBoardProvider>(context, listen: false);
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        width: Get.width,
        height: 50.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(color: AppColors.grey),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 5.0,
                spreadRadius: 2.0,
              ),
            ]),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 45.sp,
                  width: 45.sp,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: Image.asset(
                      "assets/images/car/car_image.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 25.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      car.carName!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      car.category!,
                    )
                  ],
                )
              ],
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                    barrierColor: const Color.fromRGBO(0, 0, 0, 0.76),
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialogWidget(
                          title: "Alert",
                          subTitle: "Are Your Sure to Delete '${car.carName}'",
                          positiveText: "Yes",
                          negativeText: "No",
                          onNegativeClick: () {
                            Get.back();
                          },
                          onPositiveClick: () {
                            dashBoardProvider.deleteCarFromSystem(
                                id: car.id!, index: index);
                            Get.back();
                          });
                    },
                  );
                },
                icon: const Icon(Icons.delete_forever_rounded))
          ],
        ));
  }

  Widget itemCategory({required String text, required int index}) {
    DashBoardProvider provider =
        Provider.of<DashBoardProvider>(context, listen: false);
    return Container(
      width: 110.w,
      child: Card(
        elevation: provider.selectedIndex == index ? 5 : 1,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: provider.selectedIndex == index
                  ? AppColors.appColor
                  : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(5.r)),
        borderOnForeground: true,
        child: Column(
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              child: Image.asset(
                ImageConstant.carCategories[index],
                fit: BoxFit.contain,
              ),
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
