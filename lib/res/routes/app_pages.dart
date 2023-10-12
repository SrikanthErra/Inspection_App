import 'package:flutter/cupertino.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';
import 'package:inspection_app_flutter/view/add_questions.dart';
import 'package:inspection_app_flutter/view/add_sub_user.dart';
import 'package:inspection_app_flutter/view/app_info.dart';
import 'package:inspection_app_flutter/view/dashboard_view.dart';
import 'package:inspection_app_flutter/view/inspector_survey_report.dart';
import 'package:inspection_app_flutter/view/splash_two.dart';
import 'package:inspection_app_flutter/view/take_survey.dart';
import 'package:inspection_app_flutter/view/login.dart';
import 'package:inspection_app_flutter/view/privacy_policy.dart';
import 'package:inspection_app_flutter/view/setMpin.dart';
import 'package:inspection_app_flutter/view/mpin_validate.dart';
import 'package:inspection_app_flutter/view/resetMpin.dart';
import 'package:inspection_app_flutter/view/splash.dart';
import 'package:inspection_app_flutter/view/survey_report.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.splash: ((context) => SplashScreen()),
      AppRoutes.LoginPage: ((context) => LoginPage()),
      AppRoutes.setMpinPage: ((context) => setMpinPage()),
      AppRoutes.mpinValidate: ((context) => mpinValidate()),
      AppRoutes.ResetMpin: ((context) => ResetMpin()),
      AppRoutes.AddSubUser: ((context) => AddSubUser()),
      AppRoutes.DashboardView: ((context) => DashboardView()),
      AppRoutes.AddQuestions: ((context) => AddQuestions()),
      AppRoutes.FoodSurvey: ((context) => FoodSurvey()),
      AppRoutes.SurveyReport: ((context) => SurveyReport()),
      AppRoutes.AppInfoScreen: ((context) => AppInfoScreen()),
      AppRoutes.PrivacyPolicyView: ((context) => PrivacyPolicyView()),
      AppRoutes.InspectorSurveyReport: ((context) => InspectorSurveyReport()),
      AppRoutes.SplashTwoScreen: ((context) => SplashTwoScreen()),
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
