import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inspection_app_flutter/res/constants/app_constants.dart';
import 'package:inspection_app_flutter/res/constants/assetsPath.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';
import 'package:inspection_app_flutter/viewmodel/splash_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final splash_provider = Provider.of<SplashViewModel>(
      context,
    );

    Color clr = splash_provider
        .hexToColor(AppConstants.colorConstants?.backgroundColor ?? "#000000");
    print("color is $clr");
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: clr,
            /* image: DecorationImage(
                image: AssetImage(AssetPath.splash), fit: BoxFit.cover), */
          ),
          child: Image.network(
            AppConstants.appLogo ?? '',
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 200,
                width: 200,
                child: SvgPicture.asset(
                  AssetPath.no_uploaded,
                ),
              );
            },
          ),
        )
      ],
    ));
  }

  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getAppConstantsdata(context);
    });
  }

  getAppConstantsdata(context) async {
    final splash_provider =
        Provider.of<SplashViewModel>(context, listen: false);
    await splash_provider.getAppConstants();
    await splash_provider.navigationflow(context);
  }
}
