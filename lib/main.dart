import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:inspection_app_flutter/res/routes/app_pages.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';
import 'package:inspection_app_flutter/viewmodel/add_inspector_view_model.dart';
import 'package:inspection_app_flutter/viewmodel/add_questions_viewModel.dart';
import 'package:inspection_app_flutter/viewmodel/food_survey_view_model.dart';
import 'package:inspection_app_flutter/viewmodel/login_view_model.dart';
import 'package:inspection_app_flutter/viewmodel/mpin_view_model.dart';
import 'package:inspection_app_flutter/viewmodel/side_menu_viewmodel.dart';
import 'package:inspection_app_flutter/viewmodel/splash_view_model.dart';
import 'package:inspection_app_flutter/viewmodel/survey_report_view_model.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(
      const MyApp(),
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SplashViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => LogInViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => MpinViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddInspectorViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddQuestionViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => FoodSurveyViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SurveyReportViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SideMenuViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Inspection App Flutter",
        initialRoute: AppRoutes.initial,
        routes: AppPages.routes,
        /* theme: ThemeData(
          primarySwatch: AppColors.navy,
        ), */
        //home: SideMenu(),
        //builder: EasyLoading.init(),
      ),
    );
  }
}
