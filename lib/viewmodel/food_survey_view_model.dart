import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/model/submit_answers_model.dart';
import 'package:inspection_app_flutter/res/app_alerts/customAlerts.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';

class FoodSurveyViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> questions = [];

  getQuestions() async {
    final databaseReference = FirebaseDatabase.instance.ref();
    Query query = databaseReference.child("Questions");
    DatabaseEvent event = await query.once();
    DataSnapshot snapshot = event.snapshot;

    int count = 0;
    if (snapshot.value != null) {
      //Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      questions = [];
      Map<String, dynamic> values =
          jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
      for (var entry in values.entries) {
        var key = entry.key;
        var value = entry.value;

        //questions.add(value);

        Map<String, dynamic> mapValue = {};
        count++;

        print('Matching key: $key');
        print('Matching value: ${value}');
        for (var entry in value.entries) {
          var key = entry.key;
          var value = entry.value;
          mapValue[key] = value;

          print('Matching key11: $key');
          print('Matching value11: ${value}');
        }
        mapValue["questionID"] = key;
        questions.add(mapValue);
        print("_questions is $questions");
      }
      ;
      print('Total matching records: $count');
    } else {
      print('No matching records.');
    }
  }

  submitAnswers(List<SubmitAnswersModel> submitAnswers, context) async {
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
      } catch (e) {
        print('Error adding tasks: $e');
      }
      return true;
    } else {
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
  }
}
