import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:inspection_app_flutter/res/constants/app_colors.dart';
import 'package:inspection_app_flutter/res/constants/app_constants.dart';
import 'package:inspection_app_flutter/viewmodel/splash_view_model.dart';
import 'package:provider/provider.dart';

class AppInputTextfield extends StatelessWidget {
  //const AppInputTextfield(
  // {super.key,
  // required this.hintText,
  // required this.nameController,
  // required this.errorMessage,
  // required this.input_type,
  // required this.obsecuretext,
  // required this.node,
  // required this.action,
  // required this.onEditingComplete,
  // this.globalKey,
  // this.prefixIcon,
  // // this.isSecured,
  // // this.isVisible,
  // this.onTap,
  // this.suffixIcon, this.onChanged, this.length,});

  const AppInputTextfield(
      {super.key,
      required this.hintText,
      required this.nameController,
      required this.errorMessage,
      required this.input_type,
      required this.obsecuretext,
      required this.node,
      required this.action,
      required this.onEditingComplete,
      this.globalKey,
      this.prefixIcon,
      // this.isSecured,
      // this.isVisible,
      this.onTap,
      this.suffixIcon,
      this.onChanged,
      this.length,
      this.inputFormatters,
      this.autofocus});
  final String hintText, errorMessage;
  final TextEditingController nameController;
  final TextInputType input_type;
  final bool obsecuretext;
  final FocusScopeNode node;
  final TextInputAction action;
  final VoidCallback? onEditingComplete;
  final GlobalKey? globalKey;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final int? length;
  final List<TextInputFormatter>? inputFormatters;
  final bool? autofocus;
  final void Function()? onTap;
  Widget build(BuildContext context) {
    final splash_provider = Provider.of<SplashViewModel>(context,);

  final textcolor = splash_provider.hexToColor(AppConstants.colorConstants?.textcolor2 ?? "#000000");
  print("color11 is $textcolor");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FocusScope(
        node: node,
        child: Form(
          key: globalKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: TextFormField(
              autofocus: autofocus ?? false,
              maxLength: length,
              inputFormatters: inputFormatters,
              obscureText: obsecuretext,
              textInputAction: TextInputAction.done,
              onEditingComplete: onEditingComplete,
              style:  TextStyle(color: AppColors.textcolorblack),
              controller: nameController,
              decoration: InputDecoration(
                hintText: hintText,
                counterText: '',
                hintStyle: TextStyle(color: AppColors.textcolorblack),
                prefixIcon: prefixIcon,
                //suffixIcon: null == suffixIcon ? null : Icon(suffixIcon),
                suffixIcon: suffixIcon,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.textcolorblack)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.textcolorblack)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.textcolorblack)),
                labelStyle: TextStyle(
                  color: Colors.black,
                  // color: node.hasFocus?Colors.amber:Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                labelText: hintText,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return errorMessage;
                }
              },
              keyboardType: input_type,
              /* Platform.isIOS
                  ? TextInputType.text
                  : input_type, */
            ),
          ),
        ),
      ),
    );
  }
}
