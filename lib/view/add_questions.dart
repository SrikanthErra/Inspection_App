import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/res/components/base_scaffold.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/app_input_text.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/app_input_textformfield.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/button_component.dart';
import 'package:inspection_app_flutter/res/constants/app_colors.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';
import 'package:inspection_app_flutter/utils/loader.dart';
import 'package:inspection_app_flutter/viewmodel/add_questions_viewModel.dart';
import 'package:inspection_app_flutter/viewmodel/login_view_model.dart';
import 'package:provider/provider.dart';

/* class Question {
  final String question;
  final List<String> options;

  Question({required this.question, required this.options});
} */

class AddQuestions extends StatefulWidget {
  @override
  _AddQuestionsState createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  /* List<Question> questions = [
    Question(
      question: 'What is your favorite color?',
      options: ['Red', 'Green', 'Blue'],
    ),
    Question(
      question: 'What is your favorite animal?',
      options: ['Dog', 'Cat', 'Bird'],
    ),
    Question(
      question: 'What is your favorite food?',
      options: ['Pizza', 'Burger', 'Pasta'],
    ),
  ];

  List<String> selectedOptions = [];
 */
  TextEditingController _question = TextEditingController();
  bool? textfieldFlag;
  String? selected25Value;
  String? selected50Value;
  String? selected75Value;
  String? selected100Value;
  /* @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final addQuestionsViewModel =
          Provider.of<AddQuestionViewModel>(context, listen: false);
      await addQuestionsViewModel.getRatingOptions();
      setState(() {
        
      });
    });
  } */

  @override
  Widget build(BuildContext context) {
    final addQuestionsViewModel =
        Provider.of<AddQuestionViewModel>(context, listen: false);
    final login_provider = Provider.of<LogInViewModel>(context);

    return Stack(
      children: [
        BaseScaffold(
          resize: false,
          AppBarvis: true,
          titleName: "Add Questions",
          child: SingleChildScrollView(
            child: Card(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /* SizedBox(
                        width: 20,
                      ), */
                      AppInputText(
                          text: "Add Inspection Questions",
                          colors: AppColors.textcolorblack,
                          size: 16,
                          weight: FontWeight.bold),
                      SizedBox(
                        width: 30,
                      ),
                      GestureDetector(
                          onTap: () async {
                            setState(() {
                              textfieldFlag = true;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.add_circle_outline,
                                color: AppColors.textcolorblack),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: textfieldFlag ?? false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppInputTextFormfield(
                            backgroundColor: AppColors.textcolorblack,
                            labeltext: "Add Question for Survey",
                            nameController: _question,
                            input_type: TextInputType.name,
                            obsecuretext: false),
                        SizedBox(
                          height: 20,
                        ),
                        AppInputText(
                            text: "Add options for Answers ",
                            colors: AppColors.textcolorblack,
                            size: 16,
                            weight: FontWeight.bold),
                        SizedBox(
                          height: 20,
                        ),
                        RowComponent(
                          "Option 1",
                          selected25Value,
                          addQuestionsViewModel.rating25List,
                          (value) async {
                            setState(() {
                              selected25Value = value as String;
                            });
                            print("selected value is $selected25Value");
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RowComponent(
                          "Option 2",
                          selected50Value,
                          addQuestionsViewModel.rating50List,
                          (value) async {
                            setState(() {
                              selected50Value = value as String;
                            });
                            print("selected value is $selected50Value");
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RowComponent(
                          "Option 3",
                          selected75Value,
                          addQuestionsViewModel.rating75List,
                          (value) async {
                            setState(() {
                              selected75Value = value as String;
                            });
                            print("selected value is $selected75Value");
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RowComponent(
                          "Option 4",
                          selected100Value,
                          addQuestionsViewModel.rating100List,
                          (value) async {
                            setState(() {
                              selected100Value = value as String;
                            });
                            print("selected value is $selected100Value");
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ButtonComponent(
                              /* buttonColor: AppColors.textcolorwhite,
                              textColor: AppColors.backgroundClr, */
                              onPressed: () async {
                                print("question is ${_question.text}");
                                print("25 is $selected25Value");
                                print("50 is $selected50Value");
                                print("75 is $selected75Value");
                                print("100 is $selected100Value");
                                final insert =
                                    addQuestionsViewModel.insertQuestions(
                                        _question.text,
                                        selected25Value,
                                        selected50Value,
                                        selected75Value,
                                        selected100Value,
                                        context);
                                print("insert is $insert");
                                /* if (insert) {
                                      Navigator.pushReplacementNamed(context, AppRoutes.DashboardView);
                                    } */
                                /* if (await loginViewModel.validateInputs(
                                    _mobile.text, context)) {
                                  int count = await loginViewModel.loginCount(
                                      _mobile.text, context);
                                  print("count is $count");
                                }; */
                                //Navigator.pushNamed(context, AppRoutes.mpinValidate);
                              },
                              buttonText: "SUBMIT"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        if (login_provider.getIsLoadingStatus) LoaderComponent()
      ],
    );
  }

  RowComponent(
    var option,
    var selectedValue,
    List<String> List,
    Function(String?) onValueChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppInputText(
              text: option,
              colors: AppColors.textcolorblack,
              size: 16,
              weight: FontWeight.bold),
          Container(
            width: 250,
            child: DropdownButtonFormField<String>(
              //focusColor: Colors.white,
              dropdownColor: AppColors.textcolorwhite,
              decoration: InputDecoration(
                labelText: "Add option",
                labelStyle: TextStyle(color: AppColors.textcolorblack),
                //hintText: strings.Presc_MemNameHint,
                //hintStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.textcolorblack)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.textcolorblack)),
              ),

              value: selectedValue,
              items: List.map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      color: AppColors.textcolorblack,
                      fontSize: 14,
                    ),
                  ))).toList(),
              onChanged: onValueChanged,

              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
