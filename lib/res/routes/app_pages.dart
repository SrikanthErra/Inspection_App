import 'package:flutter/cupertino.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';
import 'package:inspection_app_flutter/view/add_sub_user.dart';
import 'package:inspection_app_flutter/view/login.dart';
import 'package:inspection_app_flutter/view/setMpin.dart';
import 'package:inspection_app_flutter/view/mpin_validate.dart';
import 'package:inspection_app_flutter/view/resetMpin.dart';
import 'package:inspection_app_flutter/view/splash.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.splash: ((context) => SplashScreen()),
      AppRoutes.LoginPage: ((context) => LoginPage()),
      AppRoutes.setMpinPage: ((context) => setMpinPage()),
      AppRoutes.mpinValidate: ((context) => mpinValidate()),
      AppRoutes.ResetMpin: ((context) => ResetMpin()),
      AppRoutes.AddSubUser: ((context) => AddSubUser()),
      //   AppRoutes.setMpin: ((context) => SetMpin()),
      //   AppRoutes.validateOtp: ((context) => ValidateOtp()),
      //   AppRoutes.attendance: ((context) => Attendance()),
      //   AppRoutes.ApplyLeave: ((context) => ApplyLeave()),
      //   AppRoutes.RaiseGrievance: ((context) => RaiseGrievance()),
      //   AppRoutes.LeaveReport: ((context) => LeaveReport()),
      //   AppRoutes.GrievanceReport: ((context) => GrievanceReport()),
      //   AppRoutes.PaySlip: ((context) => PaySlip()),
      //   AppRoutes.dashboardScreen: ((context) => Dashboard()),
      //   AppRoutes.downloadMaster: ((context) => DownloadMasters()),
      //   AppRoutes.teamAttendance: ((context) => TeamAttendanceView()),
      //   AppRoutes.approveTeamAttendance: ((context) => ApproveTeamAttendance()),
      //  AppRoutes.privacyPolicy: ((context) => PrivacyPolicyView()),
      //    AppRoutes.appInfo: ((context) => AppInfoScreen()),
      // AppRoutes.LogIn: ((context) => LogIn()),
      // AppRoutes.LogIn: ((context) => LogIn()),
      // AppRoutes.LogIn: ((context) => LogIn()),
    };
  }
}
