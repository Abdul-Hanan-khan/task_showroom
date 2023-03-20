import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task_showroom/controller/dashboard_provider.dart';
import 'package:task_showroom/controller/login_provider.dart';
import 'package:task_showroom/landing_screen.dart';
import 'package:task_showroom/view/dashboard/dashboard.dart';
import 'controller/signup_provider.dart';
import 'view/auth/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider()),
      ChangeNotifierProvider<SigunUPProvider>(
          create: (context) => SigunUPProvider()),
      ChangeNotifierProvider<DashBoardProvider>(
          create: (context) => DashBoardProvider()),
    ], child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return const GetMaterialApp(
          home: LandingScreen(),
        );
      },
    );
  }
}
