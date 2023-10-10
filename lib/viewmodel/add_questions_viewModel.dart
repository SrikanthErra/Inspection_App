import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/model/questions_insert_model.dart';
import 'package:inspection_app_flutter/res/app_alerts/customAlerts.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';

class AddQuestionViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Map<dynamic, dynamic>> ratingMap = [];

  Map<String, List<String>> rating25 = {};
  List<String> rating25List = [];
  Map<String, List<String>> rating50 = {};
  List<String> rating50List = [];
  Map<String, List<String>> rating75 = {};
  List<String> rating75List = [];
  Map<String, List<String>> rating100 = {};
  List<String> rating100List = [];

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  getRatingOptions() async {
    final databaseReference = FirebaseDatabase.instance.ref();
    Query query = databaseReference.child("RatingOptions").orderByChild("25");
    DatabaseEvent event = await query.once();
    DataSnapshot snapshot = event.snapshot;
    print("len is ${snapshot.children.length}}");

    if (snapshot.value != null) {
      snapshot.children.forEach((element) {
        print("element:${element.key} ${element.value}");
        String ratingOptionsString = element.value.toString();
        List<String> ratingOptionsList = ratingOptionsString.split(', ');
        ratingMap.add({element.key: ratingOptionsList});
        //ratingMap[element.key] = ratingOptionsList;
        print(ratingOptionsList);
      });
    }
    print("rating map is ${ratingMap}");
    ratingMap.forEach((element) {
      element.forEach((key, value) {
        if (key == "25") {
          rating25[key] = value;
          rating25List = value;
        }
        if (key == "50") {
          rating50[key] = value;
          rating50List = value;
        }
        if (key == "75") {
          rating75[key] = value;
          rating75List = value;
        }
        if (key == "100") {
          rating100[key] = value;
          rating100List = value;
        }
        print("key is $key");
        print("value is $value");
      });
    });
    print("rating 25 is $rating25");
    print("rating 50 is $rating50");
    print("rating 75 is $rating75");
    print("rating 100 is $rating100");
  }

  insertQuestions(question, opt25, opt50, opt75, opt100, context) async {
    if (question.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Question cannot be empty",
              descriptions: "Please enter the question",
              Buttontext: "OK",
              //img: Image.asset(AssetPath.WarningBlueIcon),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          });
      return false;
    } else if (opt25 == null ||
        opt25.isEmpty ||
        opt50 == null ||
        opt50.isEmpty ||
        opt75 == null ||
        opt75.isEmpty ||
        opt100 == null ||
        opt100.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Options cannot be empty",
              descriptions: "Please select the options",
              Buttontext: "OK",
              //img: Image.asset(AssetPath.WarningBlueIcon),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          });
      return false;
    } else {
      final databaseReference = await FirebaseDatabase.instance.ref();
      await databaseReference
          .child("Questions")
          .push()
          .set(QuestionsInsertModel(
            question: question,
            s25: opt25,
            s50: opt50,
            s75: opt75,
            s100: opt100,
          ).toJson());
        await Navigator.pushReplacementNamed(context, AppRoutes.DashboardView);
      return true;
    }
  }
}
