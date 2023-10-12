import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/res/app_alerts/customAlerts.dart';
import 'package:inspection_app_flutter/utils/internet_check.dart';

class SurveyReportViewModel extends ChangeNotifier {
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

  getSurveyReport(context) async {
    setIsLoadingStatus(true);
    dataMap.clear();
    bool isConnected = await InternetCheck().hasInternetConnection();
    if (isConnected) {
      print("--------------------getSurveyReport-------------------");
      
      try {
        final databaseReference = await FirebaseDatabase.instance.ref();
        Query query = databaseReference.child("SurveyAnswers");
        DatabaseEvent event = await query.once();
        DataSnapshot snapshot = event.snapshot;
        double length = snapshot.children.length.toDouble();
        print("length is $length");

        Query query25 = databaseReference
            .child("SurveyAnswers")
            .orderByChild("AnswerPercent")
            .equalTo("25");
        Query query50 = databaseReference
            .child("SurveyAnswers")
            .orderByChild("AnswerPercent")
            .equalTo("50");
        Query query75 = databaseReference
            .child("SurveyAnswers")
            .orderByChild("AnswerPercent")
            .equalTo("75");
        Query query100 = databaseReference
            .child("SurveyAnswers")
            .orderByChild("AnswerPercent")
            .equalTo("100");

        DatabaseEvent event25 = await query25.once();
        DataSnapshot snapshot25 = event25.snapshot;
        double number = snapshot25.children.length.toDouble() / length * 100;
        String formattedNumber = number.toStringAsFixed(2);
        percent_25 = double.parse(formattedNumber);
        print("percent_25 is $percent_25");

        DatabaseEvent event50 = await query50.once();
        DataSnapshot snapshot50 = event50.snapshot;
        double number1 = snapshot50.children.length.toDouble() / length * 100;
        String formattedNumber1 = number1.toStringAsFixed(2);
        percent_50 = double.parse(formattedNumber1);
        print("percent_50 is $percent_50");

        DatabaseEvent event75 = await query75.once();
        DataSnapshot snapshot75 = event75.snapshot;
        double number2 = snapshot75.children.length.toDouble() / length * 100;
        String formattedNumber2 = number2.toStringAsFixed(2);
        percent_75 = double.parse(formattedNumber2);
        print("percent_75 is $percent_75");

        DatabaseEvent event100 = await query100.once();
        DataSnapshot snapshot100 = event100.snapshot;
        double number3 = snapshot100.children.length.toDouble() / length * 100;
        String formattedNumber3 = number3.toStringAsFixed(2);
        percent_100 = double.parse(formattedNumber3);
        print("percent_100 is $percent_100");

        dataMap["Poor"] = percent_25;
        dataMap["Average"] = percent_50;
        dataMap["Good"] = percent_75;
        dataMap["Excellent"] = percent_100;
        setIsLoadingStatus(false);
      } catch (e) {
        print("error is $e");
      }
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
