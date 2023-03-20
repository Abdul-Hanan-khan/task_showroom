import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_showroom/view/auth/login/login_screen.dart';
import 'package:task_showroom/view/dashboard/dashboard.dart';

class SigunUPProvider extends ChangeNotifier {
  String firstNameError = "";

  String lastNameError = "";

  String emailNameError = "";

  String phoneNoError = "";

  String userNameError = "";

  String passwordError = "";

  bool passwordObscure = true;
  bool processing = false;

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  void toggleObscurePwd() {
    passwordObscure = !passwordObscure;
    notifyListeners();
  }

  validateUname() {
    if (userNameController.text.trim().isEmpty) {
      userNameError = "Please Enter Username";
    } else {
      userNameError = "";
    }
    notifyListeners();
  }

  validateFirstName() {
    if (firstNameController.text.trim().isEmpty) {
      firstNameError = "Please Enter FirstName";
    } else {
      firstNameError = "";
    }
    notifyListeners();
  }

  validateLastName() {
    if (lastNameController.text.trim().isEmpty) {
      lastNameError = "Please Enter LastName";
    } else {
      lastNameError = "";
    }
    notifyListeners();
  }

  validatePhoneNo() {
    if (phoneController.text.trim().isEmpty) {
      phoneNoError = "Please Enter Phone Number";
    } else {
      phoneNoError = "";
    }
    notifyListeners();
  }

  validateEmail() {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text.trim());
    if (emailController.text.trim().isEmpty) {
      emailNameError = "Please Enter Email";
    } else if (!emailValid) {
      emailNameError = "Invalid Email";
    } else {
      emailNameError = "";
    }
    notifyListeners();
  }

  validatePwd() {
    if (passwordController.text.trim().isEmpty) {
      passwordError = "Please Enter Password";
    } else if (passwordController.text.trim().length < 8) {
      passwordError = "Password Should not be Less then 8 Characters";
    } else {
      passwordError = "";
    }
    notifyListeners();
  }

  void onSignUp(BuildContext context) {
    notifyListeners();

    validateFirstName();
    validateLastName();
    validateUname();
    validatePhoneNo();
    validateEmail();
    validatePwd();

    if (firstNameError == "" &&
        lastNameError == "" &&
        emailNameError == "" &&
        phoneNoError == "" &&
        userNameError == "" &&
        passwordError == "") {
      print(" sign up validated");
      performSignUp(context);
    } else {
      print(" sign up not validated");
    }
    notifyListeners();
  }

  performSignUp(BuildContext context) async {
    processing = true;
    notifyListeners();
    var firebase = FirebaseFirestore.instance.collection("users");
    String id = firebase.doc().id;

    await firebase
        .where("email", isEqualTo: emailController.text.trim())
        .get()
        .then((value) {
      if (value.docs.length > 0) {
        processing = false;
        notifyListeners();
        showDialog(
            barrierColor: Colors.red[100],
            context: context,
            builder: (context) {
              return Container(
                decoration:
                BoxDecoration(border: Border.all(color: Colors.amber[300]!)),
                child: AlertDialog(
                  title: const Text(
                    "Error !",
                    style: TextStyle(color: Colors.red),
                  ),
                  content: const Text("Account exists already"),
                  backgroundColor: Colors.grey[300],
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("ok"))
                  ],
                ),
              );
            });
      } else {
        firebase.doc(id).set({
          'user_id': id,
          'first_name': firstNameController.text.trim(),
          'last_name': lastNameController.text.trim(),
          'user_name': userNameController.text.trim(),
          'phone_no': phoneController.text.trim(),
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        }).whenComplete(() {

          var value= firebase.doc(id).get().then((value) {});
          processing = false;
          notifyListeners();
          Get.offAll(LoginScreen());
        });
      }
    });
  }
}
