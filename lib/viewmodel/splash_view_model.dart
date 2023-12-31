import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/data/local_store_helper.dart';
import 'package:inspection_app_flutter/model/color_constants_model.dart';
import 'package:inspection_app_flutter/model/user_insert_model.dart';
import 'package:inspection_app_flutter/res/constants/app_constants.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';

class SplashViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Get color constants from Firebase
  getAppConstants() async {
    /* await FirebaseDatabase.instance.ref().child("LogIN").push().set(
        UserInsertModel(
                name: "Rekha",
                memberType: "Admin",
                mobileNumber: "9999999999",
                mpin: "1111")
            .toJson()); */

    final List<Map<String, dynamic>> hell = [];
    final databaseReference = FirebaseDatabase.instance.ref();
    Query query = databaseReference.child("AppConstants");
    DatabaseEvent event = await query.once();
    DataSnapshot snapshot = event.snapshot;

    try {
      if (snapshot.value != null) {
        snapshot.children.forEach((element) {
          print("-------0: ${element.key}    ${element.value}");
          if(element.key == "applogo" && element.value != null && element.value != ""){
            AppConstants.appLogo = element.value.toString();
          }
          element.children.forEach((element1) {
            Color color = hexToColor(element1.value.toString());
            if (element.key != null && element1.value != null) {
              print("-------1: ${element.key}    ${element1.value}");
              hell.add({element1.key!: element1.value!});
            }
          });
        });

        Map<String, String> combinedMap = {};

        hell.forEach((map) {
          map.forEach((key, value) {
            combinedMap[key] = value;
          });
        });

        print("combinbed map $combinedMap");
        print("applogo ${AppConstants.appLogo}");
        ColorConstantsModel colorConstants = ColorConstantsModel(
            backgroundColor: combinedMap["backgroundColor"],
            textcolor1: combinedMap["textcolor1"],
            textcolor2: combinedMap["textcolor2"]);
        print("testclr = ${colorConstants.textcolor2}");

        print("Color constants list: ${jsonEncode(hell)}}");

        /* R */

        //ColorConstantsModel? colorConstants;
        /* for (int i = 0; i < hell.length; i++) {
          colorConstants = ColorConstantsModel(
            backgroundColor: hell[i]["backgroundColor"],
            textcolor1: hell[i]["textcolor1"],
            textcolor2: hell[i]["textcolor2"],
          );
        } */

        // Convert to model class
        /* try {
          colorConstantsList.addAll(
              hell.map((map) => ColorConstantsModel.fromJson(map)).toList());
          print("Color constants list111: ${colorConstantsList}");
        } catch (e) {
          print("Error mapping JSON to model: $e");
        }
        for (int i = 0; i < colorConstantsList.length; i++) {
          /* print(
              "Color constants list222: ${colorConstantsList[i].backgroundColor}");
          print("Color constants list333: ${colorConstantsList[i].textcolor2}"); */
          if (colorConstantsList[i].backgroundColor != null) {
            print("-------1: ${colorConstantsList[i].backgroundColor}");
            colorConstants = ColorConstantsModel(
              backgroundColor: colorConstantsList[i].backgroundColor,
            );
            notifyListeners(); // Notify listeners when data is updated
          }
          if (colorConstantsList[i].textcolor2 != null) {
            print("------2: ${colorConstantsList[i].textcolor2}");
            colorConstants = ColorConstantsModel(
              textcolor2: colorConstantsList[i].textcolor2,
            );
            notifyListeners(); // Notify listeners when data is updated
          }
          if (colorConstantsList[i].textcolor1 != null) {
            print("------3: ${colorConstantsList[i].textcolor1}");
            colorConstants = ColorConstantsModel(
              textcolor1: colorConstantsList[i].textcolor1,
            );
            notifyListeners(); // Notify listeners when data is updated
          }
        } */
        /* List<ColorConstantsModel> colorConstantsList =
            hell.map((map) => ColorConstantsModel.fromJson(map)).toList(); */
        print("testclr1 = ${colorConstants}");
        AppConstants.colorConstants = colorConstants;
        print("Color constants: ${AppConstants.colorConstants?.backgroundColor}");
        notifyListeners(); // Notify listeners when data is updated
      } else {
        print("No data found under 'AppConstants'.");
      }
    } catch (e) {
      print("Error fetching or processing color constants: $e");
    }
  }

  /* getAppConstants() async {
    final List<Map<String, dynamic>> hell = [];
    final databaseReference = FirebaseDatabase.instance.ref();
    Query query = databaseReference.child("AppConstants");
    DatabaseEvent event = await query.once();
    DataSnapshot snapshot = event.snapshot;

    if (snapshot.value != null) {
      snapshot.children.forEach((element) {
        element.children.forEach((element1) {
          Color color = hexToColor(element1.value.toString());
          hell.add({element1.key! : colorToHex(color)});
        });
      });

      print("Color constants list: ${hell}");

      // Convert to model class
      List<ColorConstantsModel> colorConstantsList =
          hell.map((map) => ColorConstantsModel.fromJson(map)).toList();
      

      if (colorConstantsList.isNotEmpty) {
        print("Color constants list: ${colorConstantsList[0].textcolor2}");
        AppConstants.colorConstants = colorConstantsList[0];
        print("Color constants: ${AppConstants.colorConstants?.textcolor2}");
        notifyListeners(); // Notify listeners when data is updated
      }
    } else {
      print("No data found under 'AppConstants'.");
    }
  } */

  /* Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  } */

  navigationflow(context) async {
    String? MPIN = await LocalStoreHelper().readTheData("mpin") ?? '';
    print("mpin is $MPIN");
    String? mobileNumber = await LocalStoreHelper().readTheData("mobileNumber") ?? '';
    print("mobileNumber is $mobileNumber");
    String memtype = await LocalStoreHelper().readTheData("membertype") ?? '';
    print("memtype is $memtype");
    AppConstants.memberType = await LocalStoreHelper().readTheData("membertype") ?? '';
    

    if (MPIN!.isNotEmpty && MPIN != "-") {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushNamed(context, AppRoutes.mpinValidate);
      });
      //Navigator.pushNamed(context, AppRoutes.mpinValidate);
    }
    // else if (RegFamCount == 0) {
    //   print("loginifsdfsdf");
    //   Navigator.pushNamed(context, AppRoutes.registraion);
    // }
    
    else {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushNamed(context, AppRoutes.LoginPage);
      });
      //Navigator.pushNamed(context, AppRoutes.LoginPage);
    }
  }

  Color hexToColor(String code) {
    // Remove any leading '#' character
    if (code.startsWith('#')) {
      code = code.substring(1);
    }

    // Parse the color code as a hexadecimal integer
    int colorValue = int.parse(code, radix: 16);

    // Create a Color object by bitwise-ORing the color value with 0xFF (opaque alpha)
    return Color(colorValue | 0xFF000000);
  }
}
