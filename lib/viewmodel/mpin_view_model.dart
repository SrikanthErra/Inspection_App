import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/data/local_store_helper.dart';
import 'package:inspection_app_flutter/res/app_alerts/SuccessCutomAlerts.dart';
import 'package:inspection_app_flutter/res/app_alerts/customAlerts.dart';
import 'package:inspection_app_flutter/res/constants/app_constants.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';

class MpinViewModel extends ChangeNotifier {
  /* getdata(MPIN) async {
    phoneNumber = await LocalStoreHelper().readTheData("mobileNumber");
    print("phone number is $phoneNumber");
    final ref = FirebaseDatabase.instance.ref().child("Family List");
    ref
      .orderByChild('mobileNumber')
      .equalTo(phoneNumber)
      .once()
      .then((DatabaseEvent snapshot) async { // Change the parameter type to DatabaseEvent
    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic> values = snapshot.snapshot.value as Map<dynamic, dynamic>;;
      for (var entry in values.entries) {
        var key = entry.key;
        var value = entry.value;
        await LocalStoreHelper().writeTheData("FamilyKey", key);
        ref.child(key).update({
          "mpin": MPIN
        });
      };
    }
  });
  } */

  reserMpin(mpin, confirmMpin, context) {
    if (mpin.length == 4 && mpin.isNotEmpty) {
      if (confirmMpin.length == 4 && confirmMpin.isNotEmpty) {
        if (mpin == confirmMpin) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SuccessCustomAlert(
                  title: 'MPIN RESET SUCCESS',
                  descriptions: 'Mpin for user is Reset Successfully',
                  Buttontext: 'OK',
                  onPressed: () async {
                    resetMpin(mpin, context);
                    //getdata(_mpin.text);
                    /* DatabaseHelper.instance
                                        .UpdateMpin(_mpin.text, mobile); */
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.LoginPage);
                  },
                );
              });
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: 'RESET MPIN',
                  descriptions: "MPINs doesn't match Please Check..!!",
                  Buttontext: 'OK',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              });
        }
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: 'RESET MPIN',
                descriptions: "Please Enter above MPIN correctly to confirm",
                Buttontext: 'OK',
                //img: Image.asset(AssetPath.WarningBlueIcon),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'RESET MPIN',
              descriptions: " Please enter 4 digit MPIN",
              Buttontext: 'OK',
              onPressed: () {
                Navigator.pop(context);
              },
            );
          });
    }
  }

  validateMpinInput(mpin, confirmMpin, context) {
    if (mpin.length == 4 && mpin.isNotEmpty) {
      if (confirmMpin.length == 4 && confirmMpin.isNotEmpty) {
        if (mpin == confirmMpin) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SuccessCustomAlert(
                  title: 'MPIN SET SUCCESSFULLY',
                  descriptions: 'Mpin for user is set Successfully',
                  Buttontext: 'OK',
                  onPressed: () async {
                    await resetMpin(mpin, context);
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.LoginPage);
                    //getdata(_mpin.text);
                  },
                );
              });
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: 'SET MPIN',
                  descriptions: "MPINs doesn't match Please Check..!!",
                  Buttontext: 'OK',
                  //img: Image.asset(AssetPath.WarningBlueIcon),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              });
        }
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: 'SET MPIN',
                descriptions: "Please Enter above MPIN correctly to confirm",
                Buttontext: 'OK',
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'SET MPIN',
              descriptions: " Please enter 4 digit MPIN",
              Buttontext: 'OK',
              onPressed: () {
                Navigator.pop(context);
              },
            );
          });
    }
  }

  mpinValidateLoginCall(String mpin, context) async {
    String Mpin = await LocalStoreHelper().readTheData("mpin");
    String memberType = await LocalStoreHelper().readTheData("membertype");
    AppConstants.userName = await LocalStoreHelper().readTheData("name");
    AppConstants.memberType = memberType;
    if (memberType == "Admin") {
      AppConstants.adminFlag = true;
      AppConstants.inspectorFlag = false;
    }
    if (memberType == "Inspector") {
      AppConstants.adminFlag = false;
      AppConstants.inspectorFlag = true;
    }
    if (Mpin == mpin) {
      Navigator.pushReplacementNamed(context, AppRoutes.DashboardView);
      return true;
    } else {
      return false;
      
    }
    //notifyListeners();
  }

  resetMpin(MPIN, context) async {
    String phoneNumber = await LocalStoreHelper().readTheData("mobileNumber");
    print("phone number is $phoneNumber");
    final ref = FirebaseDatabase.instance.ref().child("LogIN");
    ref
        .orderByChild('mobileNumber')
        .equalTo(phoneNumber)
        .once()
        .then((DatabaseEvent snapshot) {
      // Change the parameter type to DatabaseEvent
      if (snapshot.snapshot.value != null) {
        Map<dynamic, dynamic> values =
            snapshot.snapshot.value as Map<dynamic, dynamic>;
        ;
        values.forEach((key, value) {
          ref.child(key).update({"mpin": MPIN});
        });
      }
    });
  }
}
