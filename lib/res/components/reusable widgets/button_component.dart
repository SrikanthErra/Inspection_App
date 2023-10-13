import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/res/constants/app_colors.dart';

class ButtonComponent extends StatelessWidget {
  const ButtonComponent(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      this.textColor, this.buttonColors});
  final void Function()? onPressed;
  final String buttonText;
  final Color? textColor;
  final List<Color>? buttonColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: buttonColors ?? [AppColors.background1, AppColors.background2],
      )),
      child: TextButton(
        onPressed: this.onPressed,
        child: Text(
          buttonText,
          style: TextStyle(color: textColor ?? AppColors.textcolorwhite),
        ),
      ),
      /* ElevatedButton(
        style: ElevatedButton.styleFrom(
          //backgroundColor: buttonColor ?? AppColors.backgroundClr,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: this.onPressed!,
        child: Text(
          buttonText,
          style: TextStyle(color: textColor ?? AppColors.textcolorwhite),
        ),
      ), */
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      margin: EdgeInsets.symmetric(vertical: 12.0),
    );
  }
}
