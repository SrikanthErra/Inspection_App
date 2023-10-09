import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/data/local_store_helper.dart';
import 'package:inspection_app_flutter/model/user_insert_model.dart';
import 'package:inspection_app_flutter/res/app_alerts/customAlerts.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';

class LogInViewModel extends ChangeNotifier {
  validateInputs(mobileNumber, context) {
    if (mobileNumber.isEmpty) {
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

  loginCount(String mobileNumber, context) async {
    /* final ref = FirebaseDatabase.instance.ref().child("LogIN");
    final snapshot = await ref.get(); */

    final databaseReference = FirebaseDatabase.instance.ref();
    Query query = databaseReference
        .child("LogIN")
        .orderByChild("mobileNumber")
        .equalTo(mobileNumber);
    DatabaseEvent event = await query.once();
    DataSnapshot snapshot = event.snapshot;

    int count = 0;
    if (snapshot.value != null) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      for (var entry in values.entries) {
        var key = entry.key;
        var value = entry.value;
        count++;
        await LocalStoreHelper().writeTheData("name", value["Name"]);
        await LocalStoreHelper()
            .writeTheData("mobileNumber", value["mobileNumber"]);
        await LocalStoreHelper()
            .writeTheData("membertype", value["memberType"]);
        await LocalStoreHelper().writeTheData("mpin", value["mpin"]);
        print('Matching key: $key');
        print('Matching value: $value');
      }
      ;

      print('Total matching records: $count');
    }
    if (count == 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              // title: "Invalid User mobile number",d
              title: "User not registered",
              descriptions: "Please Register with this mobile number",
              Buttontext: "OK",
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.LoginPage);
              },
            );
          });
    } else {
      String mpin = await LocalStoreHelper().readTheData("mpin");
      print("mpin is $mpin");
      if (mpin != '-') {
        Navigator.pushNamed(context, AppRoutes.mpinValidate);
      } else {
        Navigator.pushNamed(context, AppRoutes.setMpinPage);
      }
    }
    return count;
    /* if (snapshot.exists) {
      print(snapshot.children.length);
      snapshot.children.forEach((DataSnapshot dataSnapshot) {
        dataSnapshot.children.forEach((element) {
          
          hell.add(element);
          print("11111 ${element.value}");
        });
        print("1111133333 ${hell}");
        hell.forEach((element) {
          print("mobile number is ${element}");
          if (element["mobileNumber"] == mobileNumber) {
            print("true}");
            print("11111333334444 ${element['name']}");
          }
        });
      });
    } */
  }

  /* LoginCall(String mobileNumber) async {
    final DatabaseHelper _databaseService = DatabaseHelper.instance;
    final saved = await _databaseService.queryRowCountforuser(
        DatabaseHelper.table, mobileNumber);
    final users = await _databaseService.queryRowCount();
    print("data saved ${saved}");
    print("data users ${users}");
    flag = saved;
    print('flag is $flag');

    if (flag == 0 && users != 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              // title: "Invalid User mobile number",d
              title: "User not registered",
              descriptions: strings.LoginAlert_InvalidMobile,
              Buttontext: strings.Presc_Ok,
              img: Image.asset(AssetPath.WarningBlueIcon),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          });
    } else if (users == 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "User Not found",
              descriptions: strings.LoginAlert_signUp,
              Buttontext: strings.Presc_Ok,
              img: Image.asset(AssetPath.CrossIcon),
              bgColor: Colors.red[900],
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          });
    } else {
      Navigator.pushNamed(
        context,
        AppRoutes.mpinValidate, /* arguments: ScreenArguments(_mobile.text) */
      );
    }
    // print('mobile number is${saved[0]['mobileNumber']}');
    /* for (var i = 0; i < saved.length; i++) {
      // print('mobile numbers are ${saved[i]["mobileNumber"]}');
      mobileList.add({saved[i]["mobileNumber"]}.toString());
    }
    print(mobileList); */
  } */
}
