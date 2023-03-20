import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:task_showroom/controller/dashboard_provider.dart';
import 'package:task_showroom/model/user_model.dart';
import 'package:task_showroom/view/auth/login/login_screen.dart';
import 'package:task_showroom/view/dashboard/dashboard.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class LoginProvider extends ChangeNotifier {
  String userNameError = "";
  String passwordError = "";

  bool passwordObscure = true;
  bool loginProcessing = false;

  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  User user = User();

  void toggleObscurePwd() {
    passwordObscure = !passwordObscure;
    notifyListeners();
  }

  void onLogin(BuildContext context) {
    notifyListeners();

    validateUname();
    validatePwd();

    if (userNameError == "" && passwordError == "") {
      print(" login validated");
      performLogin(context);
    } else {
      print(" login not validated");
    }
    notifyListeners();
  }

  validateUname() {
    if (userNameController.text.trim().isEmpty) {
      userNameError = "Please Enter Username";
      notifyListeners();
    } else {
      userNameError = "";
      notifyListeners();
    }
    // notifyListeners();
  }

  validatePwd() {
    if (passwordController.text.trim().isEmpty) {
      passwordError = "Please Enter Password";
      notifyListeners();
    } else if (passwordController.text.trim().length < 8) {
      passwordError = "Password Should not be Less then 8 Characters";
      notifyListeners();
    } else {
      passwordError = "";
      notifyListeners();
    }
  }

  performLogin(BuildContext context) async {
    loginProcessing = true;
    notifyListeners();
    var firebase = FirebaseFirestore.instance.collection("users");
    await firebase
        .where("user_name", isEqualTo: userNameController.text.trim())
        .where("password", isEqualTo: passwordController.text.trim())
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        loginProcessing = false;
        notifyListeners();
        showDialog(
            barrierColor: Colors.red[100],
            context: context,
            builder: (context) {
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.amber[300]!)),
                child: AlertDialog(
                  title: const Text(
                    "Error !",
                    style: TextStyle(color: Colors.red),
                  ),
                  content: const Text(
                      "Invalid Username or Password. Please Try Again"),
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
        loginProcessing = false;
        notifyListeners();

        /// store user data
        ///
        user = User.fromJson(Map<String, dynamic>.from(value.docs[0].data()));
        saveUserInfo();
        // dashboardProvider.getCarsInSystem();

        Get.off(() => Dashboard());
      }
    });
  }

  saveUserInfo() async {
    String dbPath = 'user.db';
    DatabaseFactory dbFactory = databaseFactoryIo;

    final appDocDir = await getApplicationDocumentsDirectory();
    Database db = await databaseFactoryIo
        .openDatabase(join(appDocDir.path, dbPath), version: 1);
    // = await dbFactory.openDatabase(dbPath);

    var store = StoreRef.main();
    await store.record('id').put(db, '${user.userId}');
    await store.record('user_name').put(db, '${user.userName}');
    // await store.record('password').put(db, '${user.password}');

// read values

// ...and delete
    await store.record('version').delete(db);
  }

  getUserInfo(BuildContext context) async {
    String dbPath = 'user.db';
    DatabaseFactory dbFactory = databaseFactoryIo;

    final appDocDir = await getApplicationDocumentsDirectory();
    Database db = await databaseFactoryIo
        .openDatabase(join(appDocDir.path, dbPath), version: 1);
    // = await dbFactory.openDatabase(dbPath);

    var store = StoreRef.main();

    var id = await store.record('id').get(db);
    if (id == null || id == "") {
      Get.to(LoginScreen());
    } else {
      user.userId = await store.record('id').get(db) as String;
      user.userName = await store.record('user_name').get(db) as String;
      var firebase = FirebaseFirestore.instance.collection("users");
      firebase.where("user_id", isEqualTo: user.userId).get().then((value) {
        user = User.fromJson(Map<String, dynamic>.from(value.docs[0].data()));
      });
      Get.to(Dashboard());
    }
  }

  deleteUserInfo() async {
    String dbPath = 'user.db';
    // DatabaseFactory dbFactory = databaseFactoryIo;

    final appDocDir = await getApplicationDocumentsDirectory();
    Database db = await databaseFactoryIo
        .openDatabase(join(appDocDir.path, dbPath), version: 1);
    var store = StoreRef.main();

    await store.record('id').delete(db);
    await store.record('user_name').delete(db);


  }
}
