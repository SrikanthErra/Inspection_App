import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/data/local_store_helper.dart';
import 'package:inspection_app_flutter/model/submit_answers_model.dart';
import 'package:inspection_app_flutter/res/components/base_scaffold.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/app_input_text.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/button_component.dart';
import 'package:inspection_app_flutter/res/constants/app_colors.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';
import 'package:inspection_app_flutter/utils/loader.dart';
import 'package:inspection_app_flutter/viewmodel/food_survey_view_model.dart';
import 'package:provider/provider.dart';
import 'package:group_radio_button/group_radio_button.dart';

class FoodSurvey extends StatefulWidget {
  const FoodSurvey({super.key});

  @override
  State<FoodSurvey> createState() => _FoodSurveyState();
}

class _FoodSurveyState extends State<FoodSurvey> {
  Map<int, String> selectedValues = new Map<int, String>();
  List<SubmitAnswersModel> submitAnswers = [];
  String name = '';
  String mobileNumber = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      name = await LocalStoreHelper().readTheData("name");
      mobileNumber = await LocalStoreHelper().readTheData("mobileNumber");
      print("name is $name");
      final foodSurveyViewModel =
          Provider.of<FoodSurveyViewModel>(context, listen: false);
      await foodSurveyViewModel.getQuestions(context);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final foodSurveyViewModel =
        Provider.of<FoodSurveyViewModel>(context, listen: false);
    return Stack(
      children: [
            BaseScaffold(
            AppBarvis: true,
            titleName: "Inspection Survey",
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          AppInputText(
                              text: "Take Survey",
                              colors: AppColors.textcolorwhite,
                              size: 16,
                              weight: FontWeight.bold),
                          SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: foodSurveyViewModel.questions.length,
                            itemBuilder: (context, index) {
                              final GetQuestionsList =
                                  foodSurveyViewModel.questions[index];
                              List<String> _status = [
                                GetQuestionsList["25"],
                                GetQuestionsList["50"],
                                GetQuestionsList["75"],
                                GetQuestionsList["100"]
                              ];
                              return Column(
                                children: [
                                  Container(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            color: Colors.black87, width: 1),
                                      ),
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          RowComponent(index + 1,
                                              GetQuestionsList["question"]),
                                          RadioGroup<String>.builder(
                                            direction: Axis.vertical,
                                            groupValue: selectedValues[index] ?? '',
                                            /* onChanged: (value) {
                                              setState(() {
                                                DateTime now = DateTime.now();
                                                String questionId =
                                                    GetQuestionsList["questionID"];
    
                                                // Find the index of the question in the submitAnswers list
                                                int index = submitAnswers
                                                    .indexWhere((element) =>
                                                        element.questionId ==
                                                        questionId);
    
                                                // If the question is not in the list, add it with an empty list of answers
                                                if (index == -1) {
                                                  submitAnswers
                                                      .add(SubmitAnswersModel(
                                                    name: name,
                                                    time: now.toString(),
                                                    mobile: mobileNumber,
                                                    question: GetQuestionsList[
                                                        "question"],
                                                    answerPercent: questionId,
                                                    questionId: questionId,
                                                    answers: <String>[],
                                                  ));
    
                                                  // Get the index of the newly added question
                                                  index = submitAnswers.length - 1;
                                                }
    
                                                // Add the selected answer to the list of answers for the question
                                                submitAnswers[index]
                                                    .answers
                                                    .add(value ?? '');
    
                                                print(
                                                    "submitAnswers is ${submitAnswers[index].questionId}");
                                              });
                                            }, */
    
                                            onChanged: (value) => setState(() {
                                              DateTime now = DateTime.now();
    
                                              selectedValues[index] = value ?? '';
                                              print(
                                                  "selected question ${GetQuestionsList["question"]}");
                                              print(
                                                  "id ${GetQuestionsList["questionID"]}");
                                              print(
                                                  "selected list $selectedValues");
                                              String?
                                                  key; // Initialize a variable to store the key.
    
                                              GetQuestionsList.forEach((k, v) {
                                                if (v == value) {
                                                  key =
                                                      k; // If the value matches the target, set the key.
                                                }
                                              });
                                              print("key is $key");
                                              int index1 = submitAnswers.indexWhere(
                                                  (element) =>
                                                      element.questionId ==
                                                      GetQuestionsList[
                                                          "questionID"]);
    
                                              SubmitAnswersModel newModel =
                                                  SubmitAnswersModel(
                                                      name: name,
                                                      time: now.toString(),
                                                      mobile: mobileNumber,
                                                      question: GetQuestionsList[
                                                          "question"],
                                                      answer: value ?? '',
                                                      answerPercent: key ?? '',
                                                      questionId: GetQuestionsList[
                                                          "questionID"]);
                                              if (index1 == -1) {
                                                submitAnswers.add(newModel);
                                              } else {
                                                // Replace the entire SubmitAnswersModel at the existing index
                                                submitAnswers[index] = newModel;
                                              }
    
                                              print(
                                                  "submitAnswers is ${submitAnswers[0].questionId}");
                                            }),
                                            items: _status,
                                            itemBuilder: (item) =>
                                                RadioButtonBuilder(
                                              item,
                                              //textPosition: RadioButtonTextPosition.left,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  ButtonComponent(
                      buttonColor: Colors.white,
                      textColor: AppColors.backgroundClr,
                      onPressed: () async {
                        print("submitAnswers len is ${submitAnswers.length}");
                        print(
                            "ques len is ${foodSurveyViewModel.questions.length}");
    
                        if (await foodSurveyViewModel.submitAnswers(
                            submitAnswers, context)) {
                          await Navigator.pushReplacementNamed(
                              context, AppRoutes.DashboardView);
                        }
                        //
                      },
                      buttonText: "SUBMIT")
                ],
              ),
            )),
            if (foodSurveyViewModel.getIsLoadingStatus) LoaderComponent()
          ],
    );
  }

  RowComponent(var data, var value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              data.toString(),
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 9,
            child: Text(
              value.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
