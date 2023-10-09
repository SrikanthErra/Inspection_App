import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInputTextFormfield extends StatelessWidget {

  const AppInputTextFormfield(
      {super.key,
      required this.labeltext,
      required this.nameController,
      this.errorMessage,
      required this.input_type,
      required this.obsecuretext,
       this.node,
       this.action,
       this.onEditingComplete,
      this.globalKey,
      this.prefixIcon,
      this.onTap,
      this.suffixIcon,
      this.onChanged,
      this.length,
      this.inputFormatters,
      this.autofocus});
  final String labeltext; 
  final String? errorMessage;
  final TextEditingController nameController;
  final TextInputType input_type;
  final bool obsecuretext;
  final FocusScopeNode? node;
  final TextInputAction? action;
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
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FocusScope(
        node: node,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          child: TextFormField(
            onChanged: onChanged,
            autofocus: autofocus ?? false,
            maxLength: length,
            inputFormatters: inputFormatters,
            obscureText: obsecuretext,
            textInputAction: TextInputAction.done,
            onEditingComplete: onEditingComplete,
            style: const TextStyle(color: Colors.black),
            controller: nameController,
            decoration: InputDecoration(
              //hintText: hintText,
              counterText: '',
              hintStyle: TextStyle(color: Colors.black),
              prefixIcon: prefixIcon,
              //suffixIcon: null == suffixIcon ? null : Icon(suffixIcon),
              suffixIcon: suffixIcon,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black)),
              labelStyle: TextStyle(
                color: Colors.black,
                // color: node.hasFocus?Colors.amber:Colors.blue,
                fontWeight: FontWeight.normal,
              ),
              labelText: labeltext,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return errorMessage;
              }else{
                return null;
              }
            },
            keyboardType: input_type,
          ),
        ),
      ),
    );
  }
}
