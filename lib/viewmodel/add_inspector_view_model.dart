import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/model/user_insert_model.dart';
import 'package:inspection_app_flutter/res/app_alerts/customAlerts.dart';
import 'package:inspection_app_flutter/utils/internet_check.dart';

class AddInspectorViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setIsLoadingStatus(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  validateInputs(name, mobileNumber, context) {
    if (name.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Name cannot be empty",
              descriptions: "Please Enter Inspector Name",
              Buttontext: "OK",
              //img: Image.asset(AssetPath.WarningBlueIcon),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          });
      return false;
    } else if (mobileNumber.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Mobile Number cannot be empty",
              descriptions: "Please Register with this mobile number",
              Buttontext: "OK",
              //img: Image.asset(AssetPath.WarningBlueIcon),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          });
      return false;
    } else if (mobileNumber.length < 10) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "MOBILE NUMBER INVALID",
              descriptions: "Please Check and Enter a Valid Mobile Number",
              Buttontext: "OK",
              //img: Image.asset(AssetPath.WarningBlueIcon),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          });
      return false;
    } else if (!RegExp(r'^([6-9]{1})([0-9]{9})$').hasMatch(mobileNumber)) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "MOBILE NUMBER INVALID",
              descriptions: "Please Check and Enter a Valid Mobile Number",
              Buttontext: "OK",
              //img: Image.asset(AssetPath.WarningBlueIcon),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          });
      return false;
    } else {
      //Login Flow
      return true;
    }
  }

  Future<bool> checkNumberExists(String number, context) async {
    bool isConnected = await InternetCheck().hasInternetConnection();
    if (isConnected) {
      setIsLoadingStatus(true);
      final databaseReference = await FirebaseDatabase.instance.ref();
      DataSnapshot snapshot = (await databaseReference
              .child('LogIN')
              .orderByChild('mobileNumber')
              .equalTo(number)
              .once())
          .snapshot;
      setIsLoadingStatus(false);
      return snapshot.value != null;
    } else {
      setIsLoadingStatus(false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "NO INTERNET",
              descriptions: "Please Check your Internet Connection",
              Buttontext: "OK",
              //img: Image.asset(AssetPath.WarningBlueIcon),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          });
      return false;
    }
  }

  insertInspectorData(name, mobileNumber, context) async {
    bool isConnected = await InternetCheck().hasInternetConnection();
    if (isConnected) {
      setIsLoadingStatus(true);
      await FirebaseDatabase.instance
          .ref()
          .child("LogIN")
          .push()
          .set(UserInsertModel(
            name: name,
            mobileNumber: mobileNumber,
            memberType: "Inspector",
            mpin: '-',
          ).toJson());
      setIsLoadingStatus(false);
    } else {
      setIsLoadingStatus(false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "NO INTERNET",
              descriptions: "Please Check your Internet Connection",
              Buttontext: "OK",
              //img: Image.asset(AssetPath.WarningBlueIcon),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          });
    }
  }

/* await FirebaseDatabase.instance
                            .ref()
                            .child("Family List")
                            .push()
                            .set(UserInsertModel(
                              name: family_name.text,
                              age: age.text,
                              mobile: mobileNumber.text,
                              gender: selectedValue,
                              membertype: "family member",
                              mpin: '-',
                              familyID: id.toString(),
                            ).toJson()); */
}
