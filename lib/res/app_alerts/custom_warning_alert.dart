/* import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class CustomWarningAlert extends StatefulWidget {
  final String descriptions;
  final String? Buttontext;
  final String Img;
  final Color? imagebg;
  final Color? bgColor;
  final void Function()? onPressed;

  const CustomWarningAlert({
    Key? key,
    required this.descriptions,
    this.Buttontext,
    required this.onPressed,
    this.bgColor,
    required this.Img,
    this.imagebg,
  }) : super(key: key);

  @override
  _CustomWarningAlertState createState() => _CustomWarningAlertState();
}

class _CustomWarningAlertState extends State<CustomWarningAlert> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, top: 50, right: 10, bottom: 10),
          margin: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(0.0),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Version: ${AppConstants.version_number}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                AppStrings.appName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(colors: [
                        AppColors.PRIMARY_COLOR_LIGHT,
                        AppColors.PRIMARY_COLOR_DARK,
                      ])),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orange,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Ok",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 10,
          right: 10,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: CircleAvatar(
              backgroundColor: widget.imagebg ?? Colors.white,
              radius: 35,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  child: Image.asset(
          widget.Img,
          fit: BoxFit.cover,
        )),
                  /* Image.asset(
                    widget.Img,
                    // width: 100, height: 100,
                    fit: BoxFit.cover,
                  )), */
            ),
          ),
        ),
      ],
    );
  }
}
 */