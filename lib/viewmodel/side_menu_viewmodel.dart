import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inspection_app_flutter/res/app_alerts/custom_warning_alert.dart';
import 'package:inspection_app_flutter/res/constants/assetsPath.dart';
import 'package:inspection_app_flutter/viewmodel/add_questions_viewModel.dart';
import 'package:inspection_app_flutter/viewmodel/food_survey_view_model.dart';
import 'package:inspection_app_flutter/viewmodel/survey_report_view_model.dart';
import 'package:provider/provider.dart';

import '../../res/routes/app_routes.dart';

class SideMenuViewModel with ChangeNotifier {
  navigationTo(
    BuildContext context,
    subtitle,
  ) async {
    final addQuestionsViewModel = Provider.of<AddQuestionViewModel>(context, listen: false);
    final takeSurveyViewModel = Provider.of<FoodSurveyViewModel>(context, listen: false);
    final surveyReportViewModel = Provider.of<SurveyReportViewModel>(context, listen: false);
    if (subtitle == 'Home') {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, AppRoutes.DashboardView);
    } else if (subtitle == 'Take Survey') {
      await takeSurveyViewModel.getQuestions();
      Navigator.pop(context);
      Navigator.pushNamed(context, AppRoutes.FoodSurvey);
    } else if (subtitle == 'Add Inspector') {
      
      Navigator.pop(context);
      Navigator.pushNamed(
        context,
        AppRoutes.AddSubUser,
      );
    } else if (subtitle == 'Add Questions') {
      await addQuestionsViewModel.getRatingOptions();
      Navigator.pop(context);
      Navigator.pushNamed(
        context,
        AppRoutes.AddQuestions,
      );
    } 
    else if (subtitle == 'Survey Report') {
      await surveyReportViewModel.getSurveyReport();
      Navigator.pop(context);
      Navigator.pushNamed(
        context,
        AppRoutes.SurveyReport,
      );
    }
    else if (subtitle == 'App Info') {
      Navigator.pop(context);
      Navigator.pushNamed(context, AppRoutes.AppInfoScreen);
    } 
    else if (subtitle == 'Privacy Policy') {
      Navigator.pop(context);
      Navigator.pushNamed(context, AppRoutes.PrivacyPolicyView);
    }
    else if (subtitle == 'Exit application') {
      Navigator.pop(context);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CustomWarningAlert(
                descriptions: "Are you sure you want to exit the application?",
                onPressed: () {
                  Navigator.pop(context);
                },
                Img: AssetPath.WarningBlueIcon,
                onPressed1: () {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  }
                },
               // version: "verson1111" ?? ''
                );
        },
      );
    } else if (subtitle == 'Logout') {
      Navigator.pop(context);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CustomWarningAlert(
              descriptions:  "Are you sure you want to logout the application?",
              onPressed: () {
                Navigator.pop(context);
              },
              Img: AssetPath.WarningBlueIcon,
              onPressed1: () =>
                  Navigator.pushReplacementNamed(context, AppRoutes.LoginPage),
              //version: /* AppConstants.version_number ?? */ ''
              );
          
        },
      );
    }
  }
}
