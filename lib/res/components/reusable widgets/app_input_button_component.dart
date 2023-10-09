/* import 'package:flutter/material.dart';

class AppInputButtonComponent extends StatelessWidget {
  AppInputButtonComponent({
    super.key,
    required this.onPressed,
    required this.buttonText, this.width, this.height,
  });
  final void Function() onPressed;
  final String buttonText;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * 0.4,
      height: height ?? MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(colors: [
            AppColors.PRIMARY_COLOR_LIGHT,
            const Color.fromARGB(255, 209, 54, 83),
          ])),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparent,
        ),
        onPressed: onPressed,
        child: Text(

          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
 */