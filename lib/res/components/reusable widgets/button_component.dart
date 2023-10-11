import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/res/constants/app_colors.dart';

class ButtonComponent extends StatelessWidget {
  const ButtonComponent(
      {super.key, required this.onPressed, required this.buttonText, this.buttonColor, this.textColor});
  final void Function()? onPressed;
  final String buttonText;
  final Color? buttonColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor ?? AppColors.backgroundClr,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: this.onPressed!,
          child: Text(buttonText,style: TextStyle(color: textColor ?? AppColors.textcolorwhite),),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      margin: EdgeInsets.symmetric(vertical: 12.0),
    );
  }
}
