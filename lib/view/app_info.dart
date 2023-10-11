import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/res/components/base_scaffold.dart';
import 'package:inspection_app_flutter/res/constants/app_colors.dart';
import 'package:inspection_app_flutter/res/constants/assetsPath.dart';
import 'package:sizer/sizer.dart';


class AppInfoScreen extends StatefulWidget {
  const AppInfoScreen({super.key});

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
  String versionName = "", lastViersionDate = "";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: BaseScaffold(
        AppBarvis: true,
        titleName: "App Info",
        bottomSheetVis: true,
        /* bottomNavigationBar: Container(
          color: AppColors.PRIMARY_COLOR_LIGHT,
          height: MediaQuery.of(context).size.height * 0.06,
          child: Image.asset(
            AssetPath.footer_png,
            width: double.infinity,
          ),
        ), */
        child: Stack(alignment: AlignmentDirectional.center, children: [
          Column(
            children: [
              /* Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CircleAvatar(
                  radius: 40,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      child: Image.asset(AssetPath.tsfire_logo)),
                ),
              ), */
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Version :",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textcolorblack,
                                  fontSize:/*  SizerUtil.deviceType == DeviceType.tablet ? 10.sp : */ 14
                                  ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              /* AppConstants.version_number ?? */ "",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textcolorblack,
                                  fontSize: /* SizerUtil.deviceType == DeviceType.tablet ? 10.sp :  */14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Last updated date :",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textcolorblack,
                                  fontSize: /* SizerUtil.deviceType == DeviceType.tablet ? 10.sp :  */14),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              lastViersionDate,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textcolorblack,
                                  fontSize: /* SizerUtil.deviceType == DeviceType.tablet ? 10.sp :  */14),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
    
    });
  }
}
