import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_showroom/controller/login_provider.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider = Provider.of<LoginProvider>(context,listen: false);
    loginProvider.getUserInfo(context);
    return Scaffold(
      body: Center(child: CircularProgressIndicator(),),
    );
  }
}
