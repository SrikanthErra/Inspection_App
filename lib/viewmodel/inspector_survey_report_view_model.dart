import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/res/app_alerts/customAlerts.dart';
import 'package:inspection_app_flutter/res/constants/app_constants.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';
import 'package:inspection_app_flutter/utils/internet_check.dart';

class InspectorSurveyReportViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get getIsLoadingStatus => _isLoading;
  setIsLoadingStatus(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  double percent_25 = 0.0;
  double percent_50 = 0.0;
  double percent_75 = 0.0;
  double percent_100 = 0.0;
  final dataMap = <String, double>{};
  /* final dataMap = <String, double>{
    "Poor": 5,
    "Average": 3,
    "Good": 2,
    "Excellent": 2,
  }; */

  getMemberSurveyReport(context) async {
    dataMap.clear();
    percent_25 = 0.0;
    percent_50 = 0.0;
    percent_75 = 0.0;
    percent_100 = 0.0;
    bool isConnected = await InternetCheck().hasInternetConnection();
    if (isConnected) {
      setIsLoadingStatus(true);
      final databaseReference = await FirebaseDatabase.instance.ref();
      Query query = databaseReference.child("SurveyAnswers");
      DatabaseEvent event = await query.once();
      DataSnapshot snapshot = event.snapshot;
      double length = snapshot.children.length.toDouble();
      print("length is $length");

      if (snapshot.value != null) {
        setIsLoadingStatus(false);
        snapshot.children.forEach((element) {
          //print("element:${element.key} ${element.value}");
          Map<String, dynamic> values =
              jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
          for (var entry in values.entries) {
            var key = entry.key;
            var value = entry.value;
            /* print("key is $key");
        print("value is $value"); */
            /*  print("value['QuestionId'] is ${value['QuestionId']}");
        print("AppConstants.memberkey is ${AppConstants.memberkey}"); */
            if (value['mobile'] == AppConstants.mobileNumber) {
              // Found a matching entry

              if (value['AnswerPercent'] == "25") {
                // Found a matching entry
                print("Matching entry found: $value");
                percent_25++;
                print("percent_25 is $percent_25");
              }
              if (value['AnswerPercent'] == "50") {
                // Found a matching entry
                print("Matching entry found: $value");
                percent_50++;
                print("percent_50 is $percent_50");
              }
              if (value['AnswerPercent'] == "75") {
                // Found a matching entry
                print("Matching entry found: $value");
                percent_75++;
                print("percent_75 is $percent_75");
              }
              if (value['AnswerPercent'] == "100") {
                // Found a matching entry
                print("Matching entry found: $value");
                percent_100++;
                print("percent_100 is $percent_100");
              }

              if (percent_25 == 0.0 &&
                  percent_75 == 0.0 &&
                  percent_50 == 0.0 &&
                  percent_100 == 0.0) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialogBox(
                        wrongFlag: true,
                        bgColor: Colors.red,
                        title: 'NO DATA FOUND',
                        descriptions: "User Survey Report is not available",
                        Buttontext: 'OK',
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, AppRoutes.DashboardView);
                        },
                      );
                    });
              }
            }
          }
        });
        dataMap["Poor"] = percent_25;
        dataMap["Average"] = percent_50;
        dataMap["Good"] = percent_75;
        dataMap["Excellent"] = percent_100;
      } else {}
    } else {
      setIsLoadingStatus(false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'NO INTERNET',
              descriptions: "Please check your internet connection",
              Buttontext: 'OK',
              onPressed: () {
                Navigator.pop(context);
              },
            );
          });
    }
  }
}
