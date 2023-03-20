import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task_showroom/model/cars_model.dart';

class DashBoardProvider extends ChangeNotifier {
  bool getCarsProcessing = false;
  bool uploadProcessing = false;
  bool updateProcessing = false;
  bool applyValidation = false;
  int selectedIndex = 0;

  List<Car> allCars = <Car>[];
  List<Car> tempAllCars = <Car>[];
  var firebase = FirebaseFirestore.instance.collection("cars");

  var modelController = TextEditingController();
  var registrationController = TextEditingController();
  var ownerController = TextEditingController();
  var carNameController = TextEditingController();

  String modelError = "";
  String registrationError = "";
  String ownerError = "";
  String carNameError = "";

  validateModel() {
    if (modelController.text.trim().isEmpty) {
      modelError = "Please Enter Model Information";
    } else {
      modelError = "";
    }
    notifyListeners();
  }

  validateRegistration() {
    if (registrationController.text.trim().isEmpty) {
      registrationError = "Please Enter Registration Information";
    } else {
      registrationError = "";
    }
    notifyListeners();
  }

  validateOwner() {
    if (ownerController.text.trim().isEmpty) {
      ownerError = "Please Enter Registration Information";
    } else {
      ownerError = "";
    }
    notifyListeners();
  }

  validateCarName() {
    if (carNameController.text.trim().isEmpty) {
      carNameError = "Please Enter Vehicle Name";
    } else {
      carNameError = "";
    }
    notifyListeners();
  }

  var colors = [
    'Select one',
    'Black',
    'White',
    'Grey',
    'True Blue',
    'Black Gold',
    'Construction Yellow',
  ];
  String colorDropDownValue = 'Select one';
  var manufacturer = [
    'Select one',
    'BMW',
    'Daimler',
    'Honda',
    'Ford',
    'Hyundai',
  ];
  String manufacturerDropDownValue = 'Select one';
  var categories = [
    'Select one',
    'Standard',
    'Economic',
    'Business Class',
    'Luxury',
  ];
  String categoryDropDownValue = 'Select one';

  updateColorDropDownValue({required String newValue}) {
    colorDropDownValue = newValue;
    notifyListeners();
  }

  updateManufacturerDropDownValue({required String newValue}) {
    manufacturerDropDownValue = newValue;
    notifyListeners();
  }

  updateCategoryDropDownValue({required String newValue}) {
    categoryDropDownValue = newValue;
    notifyListeners();
  }

  getCarsInSystem() async {
    getCarsProcessing = true;
    // String id = firebase.doc().id;
    await firebase.get().then((value) {
      allCars = value.docs.map((document) {
        Car car = Car.fromJson(Map<String, dynamic>.from(document.data()));
        // Car car1 =Car.fromJson(Map<String, dynamic>.from(value.docs[0].0data()));

        return car;
      }).toList();
      tempAllCars = allCars;
      getCarsProcessing = false;
      notifyListeners();
    });
  }

  getFilteredCars({required int index}) async {
    selectedIndex = index;
    // notifyListeners();

    if(index == 0 ){
      getCarsProcessing = true;
      // String id = firebase.doc().id;
      await firebase.get().then((value) {
        allCars.clear();
        allCars = value.docs.map((document) {
          Car car = Car.fromJson(Map<String, dynamic>.from(document.data()));
          // Car car1 =Car.fromJson(Map<String, dynamic>.from(value.docs[0].0data()));

          return car;
        }).toList();
        tempAllCars = allCars;
        getCarsProcessing = false;
        notifyListeners();
      });
    }else{
      getCarsProcessing = true;
      // String id = firebase.doc().id;
      await firebase.where("category", isEqualTo: categories[index]).get().then((value) {
        allCars.clear();
        allCars = value.docs.map((document) {
          Car car = Car.fromJson(Map<String, dynamic>.from(document.data()));
          // Car car1 =Car.fromJson(Map<String, dynamic>.from(value.docs[0].0data()));

          return car;
        }).toList();
        tempAllCars = allCars;
        getCarsProcessing = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  Future<bool> validateAll() async {
    bool returnValue = false;
    validateCarName();
    validateRegistration();
    validateModel();
    validateOwner();
    applyValidation = true;
    notifyListeners();

    if (carNameError == "" &&
        registrationError == "" &&
        modelError == "" &&
        ownerError == "" &&
        colorDropDownValue != "Select one" &&
        manufacturerDropDownValue != "Select one" &&
        categoryDropDownValue != "Select one") {
      returnValue = true;
    } else {
      returnValue = false;
    }
    return returnValue;
  }

  uploadCarToSystem(
      {required BuildContext context,
      required String uploadedBy,
      required String uploaderId}) async {
    await validateAll().then((value) async {
      if (value) {
        uploadProcessing = true;
        notifyListeners();
        var firebase = FirebaseFirestore.instance.collection("cars");
        String id = firebase.doc().id;
        await firebase
            .where("registration",
                isEqualTo: registrationController.text.trim())
            .get()
            .then((value) {
          if (value.docs.length > 0) {
            uploadProcessing = false;
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
                      content: Text(
                          "A vehicle with registration '${registrationController.text.trim()}' is already registered"),
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
              'id': id,
              'category': categoryDropDownValue,
              'color': colorDropDownValue,
              'car_name': carNameController.text.trim(),
              'make': manufacturerDropDownValue,
              'model': modelController.text.trim(),
              'owner': ownerController.text.trim(),
              'registration': registrationController.text.trim(),
              'uploaded_by': uploadedBy,
              'user_id': uploaderId,
            }).whenComplete(() {
              var value = firebase.doc(id).get().then((value) {});
              uploadProcessing = false;
              notifyListeners();
              clearControllers();
              Get.back();
              getCarsInSystem();
              // Get.offAll(Dashboard());
            });
          }
        });
      }
    });
  }

  clearControllers() {
    registrationController.clear();
    modelController.clear();
    ownerController.clear();
    colorDropDownValue = "Select one";
    manufacturerDropDownValue = "Select one";
    categoryDropDownValue = "Select one";
  }

  deleteCarFromSystem({required String id, required int index}) {
    getCarsProcessing = true;
    notifyListeners();
    var firebase = FirebaseFirestore.instance.collection("cars");
    firebase.doc(id).delete();
    getCarsInSystem();
  }

  initializeCurrentCarSettings(int index) {
    Car car = allCars[index];
    carNameController.text = car.carName!;
    modelController.text = car.model!;
    colorDropDownValue = car.color!;
    manufacturerDropDownValue = car.make!;
    categoryDropDownValue = car.category!;
    registrationController.text = car.registration!;
    ownerController.text = car.owner!;
    notifyListeners();
  }

  updateCurrentCar({required String id, required String uploadedBy}) async {
    updateProcessing = true;
    notifyListeners();
    var firebase = FirebaseFirestore.instance.collection("cars");
    await firebase.doc(id).update({
      'category': categoryDropDownValue,
      'color': colorDropDownValue,
      'car_name': carNameController.text.trim(),
      'make': manufacturerDropDownValue,
      'model': modelController.text.trim(),
      'owner': ownerController.text.trim(),
      'registration': registrationController.text.trim(),
      'uploaded_by': uploadedBy,
    }).whenComplete(() {
      updateProcessing = false;
      notifyListeners();
      clearControllers();
      getCarsInSystem();
    });
  }
}
