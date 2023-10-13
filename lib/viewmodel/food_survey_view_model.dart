import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inspection_app_flutter/model/submit_answers_model.dart';
import 'package:inspection_app_flutter/res/app_alerts/SuccessCutomAlerts.dart';
import 'package:inspection_app_flutter/res/app_alerts/customAlerts.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';
import 'package:inspection_app_flutter/utils/internet_check.dart';
import 'package:inspection_app_flutter/utils/loader.dart';

class FoodSurveyViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> questions = [];
  bool _isLoading = false;
  bool get getIsLoadingStatus => _isLoading;
  setIsLoadingStatus(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  getQuestions(context) async {
    setIsLoadingStatus(true);
    /* if (getIsLoadingStatus) {
      //LoaderComponent();
      //EasyLoading.show(status: 'loading...');
    } */
    //EasyLoading.show(status: 'loading...');
    bool isConnected = await InternetCheck().hasInternetConnection();
    if (isConnected) {
      print("loader is $getIsLoadingStatus");
      try {
        final databaseReference = await FirebaseDatabase.instance.ref();
        Query query = databaseReference.child("Questions").orderByValue();
        DatabaseEvent event = await query.once();
        DataSnapshot snapshot = event.snapshot;

        int count = 0;
        if (snapshot.value != null) {
          //Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
          questions = [];
          List<Map<String, dynamic>> reversedQuestions = [];
          Map<String, dynamic> values =
              jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;

          values.entries.forEach((element) {
            print("element is ${element.key} ${element.value}");
          });
          for (var entry in values.entries) {
            var key = entry.key;
            var value = entry.value;

            //questions.add(value);

            Map<String, dynamic> mapValue = {};
            count++;

            /* print('Matching key: $key');
            print('Matching value: ${value}'); */
            for (var entry in value.entries) {
              var key = entry.key;
              var value = entry.value;
              mapValue[key] = value;

              /* print('Matching key11: $key');
              print('Matching value11: ${value}'); */
            }
            mapValue["questionID"] = key;
            //questions.add(mapValue);

            /* // Reverse the list

            reversedQuestions.add(mapValue);

            print("reversedQuestions is $reversedQuestions");

            questions = reversedQuestions.reversed.toList();
            notifyListeners();
 */
            questions.add(mapValue);
            print("_questions is $questions");
          }
          ;

          print('Total matching records: $count');
          setIsLoadingStatus(false);
          await Navigator.pushNamed(context, AppRoutes.FoodSurvey);
          //.dismiss();
        } else {
          setIsLoadingStatus(false);
          //EasyLoading.dismiss();
          print('No matching records.');
        }
      } catch (e) {
        print('Error adding tasks: $e');
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

  submitAnswers(List<SubmitAnswersModel> submitAnswers, context) async {
    print("entered in submitanswers");
    bool isConnected = await InternetCheck().hasInternetConnection();
    if (isConnected) {
      setIsLoadingStatus(true);
      if (questions.length == submitAnswers.length) {
        try {
          for (var answer in submitAnswers) {
            await FirebaseDatabase.instance
                .ref()
                .child("SurveyAnswers")
                .push()
                .set(SubmitAnswersModel(
                        name: answer.name,
                        mobile: answer.mobile,
                        time: answer.time,
                        question: answer.question,
                        answer: answer.answer,
                        answerPercent: answer.answerPercent,
                        questionId: answer.questionId)
                    .toJson());
            //await Navigator.pushNamed(context, AppRoutes.DashboardView);
          }
          setIsLoadingStatus(false);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SuccessCustomAlert(
                  title: 'SURVEY SUCCESSFUL',
                  descriptions: 'Survey data added Successfully',
                  Buttontext: 'OK',
                  onPressed: () async {
                    //await resetMpin(mpin, context);
                    //getdata(_mpin.text);
                    /* DatabaseHelper.instance
                                        .UpdateMpin(_mpin.text, mobile); */
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.DashboardView);
                  },
                );
              });
        } catch (e) {
          print('Error adding tasks: $e');
        }
        return true;
      } else {
        setIsLoadingStatus(false);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: "Options cannot be unselected",
                descriptions: "Please answer all questions",
                Buttontext: "OK",
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );
            });
        /* showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Alert"),
              content: Text("Please answer all questions"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"))
              ],
            );
          }); */
        return false;
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
