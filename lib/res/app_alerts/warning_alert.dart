/* import 'package:flutter/material.dart';
import '../app_colors/app_colors.dart';
import '../string_constants/string_constants.dart';

class WarningAlert extends StatefulWidget {
  final String descriptions, Buttontext1, Buttontext2;
  final String img;
  final Color? Button1bgColor;
  final Color? Button2bgColor;
  final Color? imagebg;
  final double? width;
  final double? height;
  final void Function()? onButton1Pressed;
  final void Function()? onButton2Pressed;

  const WarningAlert({
    Key? key,
    required this.descriptions,
    required this.Buttontext1,
    required this.Buttontext2,
    required this.img,
    this.imagebg,
    this.width,
    this.height,
    required this.onButton1Pressed,
    required this.onButton2Pressed,
    this.Button1bgColor,
    this.Button2bgColor,
  }) : super(key: key);

  @override
  _WarningAlertState createState() => _WarningAlertState();
}

class _WarningAlertState extends State<WarningAlert> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(0.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Version: ${AppConstants.version_number}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                AppStrings.appName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(80, 35)),
                        backgroundColor: MaterialStateProperty.all(
                            widget.Button1bgColor ?? AppColors.Red)),
                    onPressed: widget.onButton1Pressed,
                    child: Text(
                      widget.Buttontext1,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(80, 35)),
                        backgroundColor: MaterialStateProperty.all(
                            widget.Button2bgColor ?? AppColors.green)),
                    onPressed: widget.onButton2Pressed,
                    child: Text(
                      widget.Buttontext2,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
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
                radius: 35,
                backgroundColor: widget.imagebg ?? Colors.white,
                child: Image.asset(
                  widget.img,
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ],
    );
  }
}
 */