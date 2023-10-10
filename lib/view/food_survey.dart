import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/data/local_store_helper.dart';
import 'package:inspection_app_flutter/model/submit_answers_model.dart';
import 'package:inspection_app_flutter/res/components/base_scaffold.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/button_component.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';
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
  String name = '' ;
  String mobileNumber = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
     name = await LocalStoreHelper().readTheData("name");
      mobileNumber = await LocalStoreHelper().readTheData("mobileNumber");
      print("name is $name");
    });
  }

  @override
  Widget build(BuildContext context) {
    final foodSurveyViewModel =
        Provider.of<FoodSurveyViewModel>(context, listen: false);
    return BaseScaffold(
        AppBarvis: true,
        titleName: "Food Survey",
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
                      Text("Take Food Survey"),
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
                                        onChanged: (value) => setState(() {
                                          DateTime now = DateTime.now();

                                          selectedValues[index] = value ?? '';
                                          print(
                                              "selected question ${GetQuestionsList["question"]}");
                                          print(
                                              "id ${GetQuestionsList["questionID"]}");
                                          print(
                                              "selected list $selectedValues");

                                          submitAnswers.add(SubmitAnswersModel(
                                              name: name,
                                              time: now.toString(),
                                              mobile: mobileNumber,
                                              question:
                                                  GetQuestionsList["question"],
                                              answer: value ?? '',
                                              questionId: GetQuestionsList[
                                                  "questionID"]));

                                                  print("submitAnswers is ${submitAnswers[0].questionId}");
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
              ButtonComponent(onPressed: () async{
                print("submitAnswers len is ${submitAnswers.length}");
                print("ques len is ${foodSurveyViewModel.questions.length}");
               
                if( await foodSurveyViewModel.submitAnswers(submitAnswers, context)) {
                  await Navigator.pushReplacementNamed(context, AppRoutes.DashboardView);
                }
                //
              }, buttonText: "SUBMIT")
            ],
          ),
        ));
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
