import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inspection_app_flutter/res/app_alerts/custom_warning_alert.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/app_input_text.dart';
import 'package:inspection_app_flutter/res/constants/app_colors.dart';
import 'package:inspection_app_flutter/res/constants/app_constants.dart';
import 'package:inspection_app_flutter/res/constants/assetsPath.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';
import 'package:inspection_app_flutter/view/dashboard_grid_view.dart';
import 'package:inspection_app_flutter/view/sidemenu_view.dart';
import 'package:inspection_app_flutter/viewmodel/add_questions_viewModel.dart';
import 'package:inspection_app_flutter/viewmodel/food_survey_view_model.dart';
import 'package:inspection_app_flutter/viewmodel/survey_report_view_model.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final addQuestionsViewModel =
        Provider.of<AddQuestionViewModel>(context, listen: false);
    final foodSurveyViewModel =
        Provider.of<FoodSurveyViewModel>(context, listen: false);
    final surveyReportViewModel =
        Provider.of<SurveyReportViewModel>(context, listen: false);
    return WillPopScope(
      onWillPop: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return CustomWarningAlert(
                descriptions: "Are you sure you want to exit the application?",
                onPressed: () {
                  Navigator.pop(context);
                },
                Img: AssetPath.WarningBlueIcon,
                onPressed1: () {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  }
                },
                version: AppConstants.version_number ?? '');
          },
        );
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundClr,
        drawer: SideMenuView(),
        appBar: AppBar(
          //iconTheme: IconThemeData(color: Colors.white),
          title: Text('Inspection',
              style: TextStyle(color: AppColors.textcolorwhite)),
          centerTitle: true,
          backgroundColor: AppColors.background1,
          leading: Builder(
            builder: (BuildContext innerContext) {
              return IconButton(
                icon: Icon(Icons.menu, color: AppColors.textcolorwhite),
                onPressed: () {
                  // Open the drawer using the inner context
                  Scaffold.of(innerContext).openDrawer();
                },
              );
            },
          ),
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AssetPath.background), fit: BoxFit.cover),
              /* gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.background1, AppColors.background2],
            ) */
            ),
            child: /*  AppConstants.memberType == "Admin"
                ?  */
                Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          color: Colors.white,
                          child: CircleAvatar(
                            //radius: 35,
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                child: Image.asset(
                                  AssetPath.app_logo,
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        /* Image.network(
                          AppConstants.appLogo ?? '',
                          height: 100,
                          width: 100,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 100,
                              width: 100,
                              child: SvgPicture.asset(
                                AssetPath.no_uploaded,
                              ),
                            );
                          },
                        ), */
                        SizedBox(
                          height: 6,
                        ),
                        AppInputText(
                            text: AppConstants.userName ?? '',
                            colors: AppColors.textcolorwhite,
                            size: 16,
                            weight: FontWeight.bold)
                      ],
                    )),
                Expanded(flex: 3, child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: DashboardGridView(),
                ))
              ],
            )
            /* : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Image.network(
                                AppConstants.appLogo ?? '',
                                height: 100,
                                width: 100,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 100,
                                    width: 100,
                                    child: SvgPicture.asset(
                                      AssetPath.no_uploaded,
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              AppInputText(
                                  text: AppConstants.userName ?? '',
                                  colors: AppColors.textcolorwhite,
                                  size: 16,
                                  weight: FontWeight.bold)
                            ],
                          )),
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: () async {
                            await foodSurveyViewModel.getQuestions();
                            Navigator.pushNamed(context, AppRoutes.FoodSurvey);
                          },
                          child: Container(
                            height: 100,
                            width: 150,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                //side: BorderSide(width: 5, color: Colors.green)
                              ),
                              color: AppColors.navy,
                              elevation: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppInputText(
                                    colors: AppColors.textcolorwhite,
                                    size: 16,
                                    text: "Take Survey",
                                    weight: FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ) */
            ),
        bottomNavigationBar: Container(
          color: AppColors.textcolorblack,
          //color: Color.fromARGB(255, 154, 32, 56),
          height: MediaQuery.of(context).size.height * 0.06,
          child: Image.asset(
            AssetPath.footer_png,
            width: double.infinity,
          ),
        ),
      ),
      /* BaseScaffold(
        
        drawercontent: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    image: AssetImage(AssetPath.tsfire_logo),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.DashboardView);
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.DashboardView);
                },
              ),
            ],
          ),
        ),
        //leadingAction: false,
        AppBarvis: false,
        
        titleName: 'Dashboard',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                color: Colors.white,
                /* height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.8, */
                height: 25.h,
                width: 80.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppInputButtonComponent(
                      onPressed: () async {
                        //Navigator.pushNamed(context, AppRoutes.DashboardView);
                        Navigator.pushNamed(context, AppRoutes.NocModuleView);
                      },
                      buttonText: StringConstants.noc_module,
                    ),
                    /* ButtonReusable(
                      button_text: StringConstants.noc_module,
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.NocModuleView);
                      },
                    ), */
                    SizedBox(
                      height: 3.h,
                      //height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    AppInputButtonComponent(
                      onPressed: () async {
                        //Navigator.pushNamed(context, AppRoutes.DashboardView);
                        Navigator.pushNamed(
                            context, AppRoutes.PeriodicPendingInspection);
                      },
                      buttonText: StringConstants.periodic_inspection,
                    ),
                    /* ButtonReusable(
                      button_text: StringConstants.periodic_inspection,
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRoutes.PeriodicPendingInspection);
                      },
                    ), */
                  ],
                )),
          ],
        ),
      ), */
    );
  }
}
