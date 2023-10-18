import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/res/components/base_scaffold.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/app_input_text.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/button_component.dart';
import 'package:inspection_app_flutter/res/constants/app_colors.dart';
import 'package:inspection_app_flutter/res/constants/assetsPath.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';
import 'package:inspection_app_flutter/utils/loader.dart';
import 'package:inspection_app_flutter/viewmodel/mpin_view_model.dart';
import 'package:provider/provider.dart';

class setMpinPage extends StatefulWidget {
  const setMpinPage({super.key});

  @override
  State<setMpinPage> createState() => _setMpinPageState();
}

class _setMpinPageState extends State<setMpinPage> {
  TextEditingController _mpin = TextEditingController();
  TextEditingController _confirm_mpin = TextEditingController();
  late String mpin, confirmMpin;
  String? phoneNumber;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getdata();
  }

  @override
  Widget build(BuildContext context) {
    final mpinViewModel = Provider.of<MpinViewModel>(context, listen: false);
    return Stack(
      children: [
        BaseScaffold(
          bottomSheetVis: true,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                // height: MediaQuery.of(context).size.height * 0.52,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          //backgroundColor:  Colors.white,
                          radius: 35,
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              child: Image.asset(
                                AssetPath.app_logo,
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ),
                      /* CircleAvatar(
                          radius: 60, backgroundImage: AssetImage(AssetPath.AppLogo)), */
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppInputText(
                            text: "Set MPIN",
                            colors: AppColors.textcolorblack,
                            size: 30,
                            weight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: AppInputText(
                            text: "Enter 4 digit MPIN",
                            colors: AppColors.textcolorblack,
                            size: 15,
                            weight: FontWeight.bold),
                      ),
                      PinCodeFields(
                        obscureText: true,
                        length: 4,
                        fieldBorderStyle: FieldBorderStyle.square,
                        controller: _mpin,
                        responsive: false,
                        fieldHeight: 40.0,
                        fieldWidth: 40.0,
                        borderWidth: 1.0,
                        obscureCharacter: '⬤',
                        activeBorderColor: Colors.amber,
                        activeBackgroundColor: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        keyboardType: TextInputType.number,
                        autoHideKeyboard: true,
                        fieldBackgroundColor: AppColors.background1,
                        borderColor: Colors.grey,
                        textStyle: TextStyle(
                          color: AppColors.textcolorwhite,
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
                            colors: AppColors.textcolorblack,
                            size: 15,
                            weight: FontWeight.bold),
                      ),
                      PinCodeFields(
                        length: 4,
                        fieldBorderStyle: FieldBorderStyle.square,
                        controller: _confirm_mpin,
                        obscureText: true,
                        responsive: false,
                        fieldHeight: 40.0,
                        fieldWidth: 40.0,
                        borderWidth: 1.0,
                        obscureCharacter: '⬤',
                        activeBorderColor: Colors.grey,
                        activeBackgroundColor: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        keyboardType: TextInputType.number,
                        autoHideKeyboard: true,
                        fieldBackgroundColor: AppColors.background1,
                        borderColor: Colors.grey,
                        textStyle: TextStyle(
                          color: AppColors.textcolorwhite,
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
                            await mpinViewModel.validateMpinInput(
                                _mpin.text, _confirm_mpin.text, context);
                            //Navigator.pushNamed(context, AppRoutes.mpinValidate);
                          },
                          buttonText: "Proceed"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (mpinViewModel.getIsLoadingStatus) LoaderComponent()
      ],
    );
  }
}
