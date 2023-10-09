import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
   AppText({super.key, required this.textEditingController, required this.labeltext});
  final TextEditingController textEditingController; 
  final String labeltext;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: TextField(
            controller: textEditingController,
            focusNode: FocusScopeNode(canRequestFocus: false),
            decoration: InputDecoration(
              labelText: labeltext,
              labelStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
              hintStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black)),
            )),
      ),
    );
  }
}
