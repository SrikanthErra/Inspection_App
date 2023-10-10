import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inspection_app_flutter/res/app_alerts/custom_warning_alert.dart';
import 'package:inspection_app_flutter/res/constants/app_colors.dart';
import 'package:inspection_app_flutter/res/constants/app_constants.dart';
import 'package:inspection_app_flutter/res/constants/assetsPath.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';
import 'package:inspection_app_flutter/viewmodel/add_questions_viewModel.dart';
import 'package:inspection_app_flutter/viewmodel/food_survey_view_model.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final addQuestionsViewModel = Provider.of<AddQuestionViewModel>(context, listen: false);
    final foodSurveyViewModel = Provider.of<FoodSurveyViewModel>(context, listen: false);
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
                version: "verson1111" ?? '');
          },
        );
        return Future.value(false);
      },
      child: Scaffold(
        //drawer: SideMenuView(),
        appBar: AppBar(
          title: Text('Dashboard', style: TextStyle(color: AppColors.textcolorblack)),
          centerTitle: true,
          backgroundColor: AppColors.backgroundClr,
          leading: Builder(
            builder: (BuildContext innerContext) {
              return IconButton(
                icon: Icon(Icons.menu, color:  AppColors.textcolorblack),
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
          /* decoration: BoxDecoration(
              //color : Color.fromARGB(255, 113, 84, 60),
              //borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(colors: [
            Color(0xffB81736),
            Color(0xff281637),
          ])), */
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.AddSubUser);
                    
                    },
                    child: Container(
                      color: Colors.amber,
                      height: 100,
                      width: 100,
                      //child: Image.asset(AssetPath.tsfire_logo),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Add Inspector",)),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  GestureDetector(
                    onTap: () async{
                      await foodSurveyViewModel.getQuestions();
                      Navigator.pushNamed(context, AppRoutes.FoodSurvey);
                    },
                    child: Visibility(
                      visible: AppConstants.inspectorFlag ?? false,
                      child: Container(
                        color: Colors.amber,
                        height: 100,
                        width: 100,
                        //child: Image.asset(AssetPath.tsfire_logo),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Food Survey",)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  GestureDetector(
                    onTap: () async{
                      await addQuestionsViewModel.getRatingOptions();
                      Navigator.pushNamed(context, AppRoutes.AddQuestions);
                    },
                    child: Visibility(
                      visible: AppConstants.adminFlag ?? false,
                      child: Container(
                        color: Colors.amber,
                        height: 100,
                        width: 100,
                        //child: Image.asset(AssetPath.tsfire_logo),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Add Questions",)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
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
