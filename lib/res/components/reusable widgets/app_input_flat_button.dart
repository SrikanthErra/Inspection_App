/* import 'package:flutter/material.dart';

class AppInputFlatButton extends StatelessWidget {
  AppInputFlatButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.color, required this.icon,
  });
  final void Function()? onPressed;
  final String buttonText;
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.0),
          color: color
          ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparent,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon),
            
            Text(
              buttonText,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
 */