import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/data/local_store_helper.dart';
import 'package:inspection_app_flutter/res/constants/app_constants.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';

class SplashTwoViewModel extends ChangeNotifier{

  navigationflow(context) async {
    String? MPIN = await LocalStoreHelper().readTheData("mpin") ?? '';
    print("mpin is $MPIN");
    String? mobileNumber =
        await LocalStoreHelper().readTheData("mobileNumber") ?? '';
    print("mobileNumber is $mobileNumber");
    String memtype = await LocalStoreHelper().readTheData("membertype") ?? '';
    print("memtype is $memtype");
    AppConstants.memberType =
        await LocalStoreHelper().readTheData("membertype") ?? '';

    if (MPIN!.isNotEmpty && MPIN != "-") {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushNamed(context, AppRoutes.mpinValidate);
      });
      //Navigator.pushNamed(context, AppRoutes.mpinValidate);
    }
    // else if (RegFamCount == 0) {
    //   print("loginifsdfsdf");
    //   Navigator.pushNamed(context, AppRoutes.registraion);
    // }

    else {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushNamed(context, AppRoutes.LoginPage);
      });
      //Navigator.pushNamed(context, AppRoutes.LoginPage);
    }
  }
}