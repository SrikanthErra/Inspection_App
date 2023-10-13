import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/data/local_store_helper.dart';
import 'package:inspection_app_flutter/res/constants/app_colors.dart';
import 'package:inspection_app_flutter/res/constants/assetsPath.dart';
import 'package:inspection_app_flutter/viewmodel/side_menu_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inspection_app_flutter/res/constants/app_constants.dart';
import 'package:sizer/sizer.dart';

class SideMenuView extends StatefulWidget {
  const SideMenuView({
    Key? key,
  }) : super(key: key);
  @override
  State<SideMenuView> createState() => _SideMenuViewState();
}

class _SideMenuViewState extends State<SideMenuView> {
  String? memberType;
  List<Map<String, dynamic>> subtitleGroups = [];
  List<Map<String, dynamic>> adminGroup = [
    {
      'title': '',
      'subtitles': [
        {'title': 'Home', 'image': AssetPath.home},
        {'title': 'Add Inspector', 'image': AssetPath.add_inspector_svg},
        {'title': 'Add Questions', 'image': AssetPath.add_questions_svg},
        {'title': 'Take Survey', 'image': AssetPath.take_survey_svg},
        {'title': 'Survey Report', 'image': AssetPath.survey_report_svg},
      ],
    },
    {
      'title': 'Info',
      'subtitles': [
        {'title': 'Privacy Policy', 'image': AssetPath.privacy},
        {'title': 'App Info', 'image': AssetPath.appinfo}
      ],
    },
    {
      'title': 'Others',
      'subtitles': [
        {'title': 'Exit application', 'image': AssetPath.exit},
        {'title': 'Logout', 'image': AssetPath.logout},
      ],
    },
  ]; // Define the subtitle groups as a list of maps

  List<Map<String, dynamic>> inspectorGroup = [
    {
      'title': '',
      'subtitles': [
        {'title': 'Home', 'image': AssetPath.home},
        {'title': 'Take Survey', 'image': AssetPath.take_survey_svg},
        {'title': 'Survey Report', 'image': AssetPath.survey_report_svg},
      ],
    },
    {
      'title': 'Info',
      'subtitles': [
        {'title': 'Privacy Policy', 'image': AssetPath.privacy},
        {'title': 'App Info', 'image': AssetPath.appinfo}
      ],
    },
    {
      'title': 'Others',
      'subtitles': [
        {'title': 'Exit application', 'image': AssetPath.exit},
        {'title': 'Logout', 'image': AssetPath.logout},
      ],
    },
  ];
  //List<Map<String, dynamic>> subtitles = [];

  String? ImagePath;

  @override
  void initState() {
    super.initState();
    if (AppConstants.memberType == "Admin") {
      subtitleGroups = adminGroup;
    } else {
      subtitleGroups = inspectorGroup;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //memberType = await LocalStoreHelper().readTheData("membertype");

      setState(() {});
      // Add Your Code here.
      //ImagePath = AssetPath.home;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuViewModel>(context);
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.65,
      //SizerUtil.deviceType == DeviceType.tablet ? 55.w : 65.w,
      child: Column(
        children: [
          Expanded(
            flex: /*  SizerUtil.deviceType == DeviceType.tablet ? 3 :  */ 2,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.background1, AppColors.background2],
              )),
              width: double.infinity,
              //height: 30.h,
              child: Image.network(
                AppConstants.appLogo ?? '',
                height: 20,
                width: 20,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 50,
                    width: 50,
                    child: SvgPicture.asset(
                      AssetPath.no_uploaded,
                    ),
                  );
                },
              ),
              /* Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      /* width: 80.w,
                      height: 22.h, */
                      child: Image.asset(AssetPath.tsfire_logo, fit: BoxFit.cover),
                      
                      ),
                  SizedBox(
                    height: 5.0,
                  ),
                  /* Text('${widget.employeeName}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.white)), */
                ],
              ), */
            ),
          ),
          Expanded(
            flex: /* SizerUtil.deviceType == DeviceType.tablet ? 7 :  */ 6,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: ListView.builder(
                itemCount: subtitleGroups.length,
                itemBuilder: (BuildContext context, int index) {
                  String groupTitle = subtitleGroups[index]['title'];
                  List<Map<String, dynamic>> subtitles =
                      subtitleGroups[index]['subtitles'];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (groupTitle != '') ...{
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, bottom: 5.0),
                          child: Text(
                            groupTitle,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    /* SizerUtil.deviceType == DeviceType.tablet
                                        ? 14.sp
                                        : */
                                    15.0,
                                color: Colors.black45),
                          ),
                        ),
                        Column(
                          children: subtitles.map((subtitle) {
                            return ListTile(
                              leading: SvgPicture.asset(
                                subtitle['image'],
                                width: /* SizerUtil.deviceType == DeviceType.tablet
                                    ? 4.w
                                    :  */
                                    24.0,
                                height:
                                    /* SizerUtil.deviceType == DeviceType.tablet
                                        ? 4.h
                                        :  */
                                    24.0,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                subtitle['title'],
                                style: TextStyle(
                                  fontSize:
                                      /* SizerUtil.deviceType == DeviceType.tablet
                                          ? 10.sp
                                          : */
                                      14.0,
                                ),
                              ),
                              onTap: () {
                                sideMenuProvider.navigationTo(
                                    context, subtitle['title']);
                              },
                            );
                          }).toList(),
                        ),
                      } else ...{
                        Column(
                          children: subtitles.map((subtitle) {
                            return ListTile(
                              leading: SvgPicture.asset(
                                subtitle['image'],
                                width: /*  SizerUtil.deviceType == DeviceType.tablet
                                    ? 4.w
                                    :  */
                                    24.0,
                                height:
                                    /* SizerUtil.deviceType == DeviceType.tablet
                                        ? 4.h
                                        :  */
                                    24.0,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                subtitle['title'],
                                style: TextStyle(
                                  fontSize:
                                      /* SizerUtil.deviceType == DeviceType.tablet
                                          ? 10.sp
                                          :  */
                                      14.0,
                                ),
                              ),
                              onTap: () {
                                sideMenuProvider.navigationTo(
                                    context, subtitle['title']);
                              },
                            );
                          }).toList(),
                        ),
                      },
                      Divider()
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
