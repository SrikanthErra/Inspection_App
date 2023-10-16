import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inspection_app_flutter/model/moduels_model.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/app_input_text.dart';
import 'package:inspection_app_flutter/res/constants/app_colors.dart';
import 'package:inspection_app_flutter/res/constants/app_constants.dart';
import 'package:inspection_app_flutter/res/constants/assetsPath.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';
import 'package:inspection_app_flutter/viewmodel/add_questions_viewModel.dart';
import 'package:inspection_app_flutter/viewmodel/food_survey_view_model.dart';
import 'package:inspection_app_flutter/viewmodel/inspector_survey_report_view_model.dart';
import 'package:inspection_app_flutter/viewmodel/survey_report_view_model.dart';
import 'package:provider/provider.dart';

class DashboardGridView extends StatelessWidget {
  //final List<DashboardMenuList> items;

  DashboardGridView({super.key});

  List<ModulesModel> items = [];
  @override
  Widget build(BuildContext context) {
    print("appconstants ${AppConstants.memberType}");
    AppConstants.memberType == "Admin"
        ? items = AppConstants.AdminModules ?? []
        : items = AppConstants.InspectorModules ?? [];
    /* print("items are ${items[1].moduleName}}"); */
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
                    getDetails(context, items[index].moduleName ?? '',
                        items[index].routeName ?? '');
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
                          items[index].imagePath ?? '',
                          height: 50.0,
                          width: 50.0,
                          //color: AppColors.backgroundClr,
                        ),
                        AppInputText(
                          colors: AppColors.background1,
                          size: 16,
                          text: items[index].moduleName ?? '',
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

  void getDetails(
      BuildContext context, String itemName, String routeName) async {
    final addQuestionsViewModel =
        Provider.of<AddQuestionViewModel>(context, listen: false);
    final takeSurveyViewModel =
        Provider.of<FoodSurveyViewModel>(context, listen: false);
    final surveyReportViewModel =
        Provider.of<SurveyReportViewModel>(context, listen: false);
    final inspectorSurveyReportViewModel =
        Provider.of<InspectorSurveyReportViewModel>(context, listen: false);
    switch (itemName) {
      case "Take Survey":
        await takeSurveyViewModel.getQuestions(context);
        //await Navigator.pushNamed(context, routeName);
        break;
      case "Add Questions":
        //await addQuestionsViewModel.getRatingOptions(context);
        await Navigator.pushNamed(context, routeName);
        break;
      case "Add Inspector":
        await Navigator.pushNamed(context, routeName);
        break;
      case "Survey Report":
        if (AppConstants.memberType == "Admin") {
          //await surveyReportViewModel.getSurveyReport(context);
          await Navigator.pushNamed(context, routeName);
        } else if (AppConstants.memberType == "Inspector") {
          await inspectorSurveyReportViewModel.getMemberSurveyReport(context);
          //await Navigator.pushNamed(context, routeName);
        }

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
