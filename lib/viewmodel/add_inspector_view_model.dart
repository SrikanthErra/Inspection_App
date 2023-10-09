import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/model/user_insert_model.dart';
import 'package:inspection_app_flutter/res/app_alerts/customAlerts.dart';

class AddInspectorViewModel extends ChangeNotifier {
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

  Future<bool> checkNumberExists(String number) async {
    final databaseReference = FirebaseDatabase.instance.ref();
    DataSnapshot snapshot = (await databaseReference
            .child('LogIN')
            .orderByChild('mobileNumber')
            .equalTo(number)
            .once())
        .snapshot;
    return snapshot.value != null;
  }

  insertInspectorData(name, mobileNumber, context) async {
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
