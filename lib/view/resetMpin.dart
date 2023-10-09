import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:inspection_app_flutter/res/components/base_scaffold.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/app_input_text.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/button_component.dart';
import 'package:inspection_app_flutter/res/constants/app_colors.dart';
import 'package:inspection_app_flutter/viewmodel/mpin_view_model.dart';
import 'package:provider/provider.dart';

class ResetMpin extends StatefulWidget {
  const ResetMpin({super.key});

  @override
  State<ResetMpin> createState() => _ResetMpintate();
}

class _ResetMpintate extends State<ResetMpin> {
  TextEditingController _mpin = TextEditingController();
  TextEditingController _confirm_mpin = TextEditingController();
  late String mpin, confirmMpin;
  String? phoneNumber;
  

  @override
  Widget build(BuildContext context) {
    /* final mobile = ModalRoute.of(context)?.settings.arguments as dynamic;
    print(mobile); */
    final mpinViewModel =
        Provider.of<MpinViewModel>(context, listen: false);
    return BaseScaffold(
      //resizeToAvoidBottomInset: true,
      
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /* CircleAvatar(
                  radius: 60, backgroundImage: AssetImage(AssetPath.AppLogo)), */
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppInputText(
                    text: "RESET MPIN",
                    colors: AppColors.textcolorblack,
                    size: 25,
                    weight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppInputText(
                    text: "Enter 4 digit MPIN",
                    colors: AppColors.textcolorblack,
                    size: 15,
                    weight: FontWeight.bold),
              ),
              PinCodeFields(
                length: 4,
                obscureText: true,
                fieldBorderStyle: FieldBorderStyle.square,
                controller: _mpin,
                responsive: false,
                fieldHeight: 40.0,
                fieldWidth: 40.0,
                borderWidth: 1.0,
                obscureCharacter: '⬤',
                activeBorderColor: Colors.grey,
                activeBackgroundColor: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
                keyboardType: TextInputType.number,
                autoHideKeyboard: true,
                fieldBackgroundColor: Colors.black12,
                borderColor: Colors.black38,
                textStyle: TextStyle(
                  color: AppColors.textcolorblack,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                onComplete: (mpinOutput) {
                  // Your logic with pin code
                  print(mpinOutput);
                  _mpin.text = mpinOutput;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: AppInputText(
                    text: "Confirm 4 digit MPIN",
                    colors:  AppColors.textcolorblack,
                    size: 15,
                    weight: FontWeight.bold),
              ),
              PinCodeFields(
                length: 4,
                obscureText: true,
                fieldBorderStyle: FieldBorderStyle.square,
                controller: _confirm_mpin,
                responsive: false,
                fieldHeight: 40.0,
                fieldWidth: 40.0,
                borderWidth: 1.0,
                obscureCharacter: '⬤',
                activeBorderColor: Colors.grey,
                activeBackgroundColor: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
                keyboardType: TextInputType.number,
                autoHideKeyboard: true,
                fieldBackgroundColor: Colors.black12,
                borderColor: Colors.black38,
                textStyle: TextStyle(
                  color:  AppColors.textcolorblack,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                onComplete: (confirm_mpinOutput) {
                  // Your logic with pin code
                  print(confirm_mpinOutput);
                  _confirm_mpin.text = confirm_mpinOutput;
                },
              ),
              ButtonComponent(
                  onPressed: () async {
                    mpinViewModel.reserMpin(_mpin.text, _confirm_mpin.text, context);
                  },
                  buttonText: "Proceed"),
            ],
          ),
        ),
      ),
    );
  }

  /* getdata(MPIN) async {
    phoneNumber = await LocalStoreHelper().readTheData("mobileNumber");
    print("phone number is $phoneNumber");
    final ref = FirebaseDatabase.instance.ref().child("Family List");
    ref
      .orderByChild('mobileNumber')
      .equalTo(phoneNumber)
      .once()
      .then((DatabaseEvent snapshot) { // Change the parameter type to DatabaseEvent
    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic> values = snapshot.snapshot.value as Map<dynamic, dynamic>;;
      values.forEach((key, value) {
        ref.child(key).update({
          "mpin": MPIN
        });
      });
    }
  });
  } */
}
