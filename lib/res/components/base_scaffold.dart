import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/res/constants/app_colors.dart';
import 'package:inspection_app_flutter/res/constants/app_constants.dart';
import 'package:inspection_app_flutter/res/constants/assetsPath.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/splash_view_model.dart';
import '../routes/app_routes.dart';

// ignore: must_be_immutable
class BaseScaffold extends StatefulWidget {
  BaseScaffold(
      {this.key,
      this.child,
      this.bottomsheet,
      this.resize,
      this.appBar,
      this.endDrawer,
      this.routeName,
      this.titleName,
      this.color,
      this.extendBodyBehindAppBar,
      this.bottomSheetVis,
      this.drawerContent,
      this.AppBarvis,
      this.appBarSize,
      this.backArrowFlag,
      this.sidebarVis,
      this.backgroundImageVisible});
  final Widget? child;
  final Widget? bottomsheet;
  final bool? resize;
  final bool? bottomSheetVis;
  final Key? key;
  final bool? sidebarVis;
  final bool? AppBarvis;
  final bool? backArrowFlag;
  final bool? extendBodyBehindAppBar;
  final AppBar? appBar;
  final Widget? endDrawer;
  final Widget? drawerContent;
  final String? routeName;
  final String? titleName;
  final bool? backgroundImageVisible;
  Color? color;
  final double? appBarSize;
  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  void initState() {
    super.initState();
  }

  Color? themeColor;
  @override
  Widget build(BuildContext context) {
    final splash_provider =
        Provider.of<SplashViewModel>(context, listen: false);
        print(" AppColors.backgroundClr ${ AppColors.backgroundClr}");
        print("AppConstants.colorConstants?.backgroundColor ${AppConstants.colorConstants?.backgroundColor}");
    
    return Scaffold(
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar ?? false,
      drawer: Visibility(
        visible: widget.sidebarVis ?? false,
        child: Drawer(
          child: widget.drawerContent,
        ),
      ),
      key: widget.key,
      //endDrawer: widget.endDrawer,
      resizeToAvoidBottomInset: widget.resize,
      bottomSheet: widget.bottomSheetVis == true
          ? Image.asset(
              AssetPath.footer_png,
              width: double.infinity,
              height: 40,
            )
          : widget.bottomsheet,
      appBar: widget.AppBarvis == true
          ? PreferredSize(
              preferredSize: Size.fromHeight(40.0),
              child: AppBar(
                leading: IconButton(
                    onPressed: () {
                      widget.backArrowFlag == true
                          ? Navigator.pushNamed(context, AppRoutes.LoginPage)
                          : Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColors.textcolorblack,
                    )),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.DashboardView);
                        //ProviderForPropertyTax.navigate(context, AppRoutes.dashboard);
                      },
                      icon: Icon(
                        Icons.home,
                        color: AppColors.textcolorblack,
                      ))
                ],
                centerTitle: true,
                backgroundColor: Colors.white,
                title: Text(
                  widget.titleName ?? '',
                  style: TextStyle(
                    color: AppColors.textcolorblack,
                  ),
                ),
              ),
            )
          : PreferredSize(
              preferredSize: Size.fromHeight(widget.appBarSize ?? 40),
              child: widget.appBar ??
                  Container(
                    color: Colors.transparent,
                  ),
            ),
      body: widget.backgroundImageVisible == true
          ? Container(
              height: double.infinity,
              width: double.infinity,
              color: AppColors.textcolorwhite,
              decoration: BoxDecoration(
                  /* image: DecorationImage(
                  image: AssetImage(AssetPath.bg_image),
                  fit: BoxFit.cover,
                ), */
                  ),
              child: widget.child,
            )
          : Container(
              height: double.infinity,
              width: double.infinity,
              color: AppColors.backgroundClr,
              child: widget.child,
            ),
    );
  }
}
