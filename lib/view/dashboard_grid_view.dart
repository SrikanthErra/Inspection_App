import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/app_input_text.dart';
import 'package:inspection_app_flutter/res/constants/app_colors.dart';
import 'package:inspection_app_flutter/res/constants/app_constants.dart';
import 'package:inspection_app_flutter/res/constants/assetsPath.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';
import 'package:inspection_app_flutter/viewmodel/add_questions_viewModel.dart';
import 'package:inspection_app_flutter/viewmodel/food_survey_view_model.dart';
import 'package:inspection_app_flutter/viewmodel/survey_report_view_model.dart';
import 'package:provider/provider.dart';

class DashboardGridView extends StatelessWidget {
  //final List<DashboardMenuList> items;

  DashboardGridView({super.key});

  List<Map<String, dynamic>> items = [
    {
      "name": "Take Survey",
      "imagePath": AssetPath.take_survey_svg,
    },
    {
      "name": "Add Questions",
      "imagePath": AssetPath.add_questions_svg,
    },
    {
      "name": "Add Inspector",
      "imagePath": AssetPath.add_inspector_svg,
    },
    {
      "name": "Survey Report",
      "imagePath": AssetPath.survey_report_svg,
    }
  ];
  @override
  Widget build(BuildContext context) {
    print("appconstants ${AppConstants.memberType}");

    return SizedBox(
      child: GridView.builder(
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Adjust the crossAxisCount as per your needs
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          childAspectRatio: (.7 / .4),
        ),
        itemBuilder: (context, index) {
          return SizedBox(
            /* width: MediaQuery.of(context).size.width,
            height: 50, */
            child: GridTile(
              child: Container(
                /* decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ), */
                //color:AppColors.white,
                child: GestureDetector(
                  onTap: () {
                    getDetails(context, items[index]["name"]);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      //side: BorderSide(width: 5, color: Colors.green)
                    ),
                    color: Colors.white,
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /* Image.network(
                          items[index].imagePath ?? '',
                          height: 50.0,
                          width: 50.0,
                        ), */
                        SvgPicture.asset(
                          items[index]["imagePath"] ?? '',
                          height: 50.0,
                          width: 50.0,
                          //color: AppColors.backgroundClr,
                        ),
                        AppInputText(
                          colors: AppColors.backgroundClr,
                          size: 16,
                          text: items[index]["name"] ?? '',
                          weight: FontWeight.normal,
                          /* textAlign: TextAlign.center,
                          text: items[index].serviceName ?? '',
                          fontsize: 16,
                          color: AppColors.white, */
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void getDetails(BuildContext context, String itemName) async {
    final addQuestionsViewModel =
        Provider.of<AddQuestionViewModel>(context, listen: false);
    final takeSurveyViewModel =
        Provider.of<FoodSurveyViewModel>(context, listen: false);
    final surveyReportViewModel =
        Provider.of<SurveyReportViewModel>(context, listen: false);
    switch (itemName) {
      case "Take Survey":
        await takeSurveyViewModel.getQuestions();
        Navigator.pushNamed(context, AppRoutes.FoodSurvey);
        break;
      case "Add Questions":
        await addQuestionsViewModel.getRatingOptions();
        Navigator.pushNamed(context, AppRoutes.AddQuestions);
        break;
      case "Add Inspector":
        Navigator.pushNamed(context, AppRoutes.AddSubUser);
        break;
      case "Survey Report":
        await surveyReportViewModel.getSurveyReport();
        Navigator.pushNamed(context, AppRoutes.SurveyReport);
        break;
      default:
        print('Please dont ask me');
    }
  }

  /* void getDetails(BuildContext context, int index) {
    switch (items[index]["name"]) {
      case 1: Navigator.pushNamed(context, AppRoutes.FoodSurvey);
        break;
      case 2:
        Navigator.pushNamed(context, AppRoutes.AddQuestions);
        break;
      case 3:
        Navigator.pushNamed(context, AppRoutes.AddSubUser);
      case 4:
        Navigator.pushNamed(context, AppRoutes.SurveyReport);
        break;
      default:
        print('Please dont ask me');
    } */
}
