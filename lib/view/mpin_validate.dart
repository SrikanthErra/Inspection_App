import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:inspection_app_flutter/data/local_store_helper.dart';
import 'package:inspection_app_flutter/res/app_alerts/customAlerts.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/app_input_text.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/button_component.dart';
import 'package:inspection_app_flutter/res/constants/app_colors.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';
import 'package:inspection_app_flutter/viewmodel/mpin_view_model.dart';
import 'package:provider/provider.dart';
class mpinValidate extends StatefulWidget {
  const mpinValidate({super.key});

  @override
  State<mpinValidate> createState() => _mpinValidateState();
}

class _mpinValidateState extends State<mpinValidate> {
  TextEditingController _mpin = TextEditingController();
  late String mpin;
  String? Mpin;
  String? phoneNumber;
  Map mpin_value = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Mpin = await LocalStoreHelper().readTheData("mpin");
      phoneNumber = await LocalStoreHelper().readTheData("mobileNumber");
    });
  }

  @override
  Widget build(BuildContext context) {
    final mpinViewModel = Provider.of<MpinViewModel>(context, listen: false);
    //final arg = ModalRoute.of(context)?.settings.arguments as ScreenArguments;

    return Scaffold(
      // resizeToAvoidBottomInset: true,
      body: Center(
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
                    text: "Validate MPIN",
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
                borderColor: Colors.grey,
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.ResetMpin,
                            arguments: phoneNumber);
                      },
                      child: Text(
                        "Forgot MPIN?",
                        style: TextStyle(
                          shadows: [
                            Shadow(color: AppColors.textcolorblack, offset: Offset(0, -5))
                          ],
                          color: Colors.transparent,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.navy,
                          decorationThickness: 4,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ButtonComponent(
                  onPressed: () {
                    if (_mpin.text.isNotEmpty && _mpin.text.length == 4) {
                      mpinViewModel.mpinValidateLoginCall(_mpin.text, context);
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialogBox(
                              title: "INVALID MPIN",
                              descriptions: "Please enter 4 digit MPIN",
                              Buttontext: "OK",
                              
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            );
                          });
                    }
                  },
                  buttonText: "Validate"),
            ],
          ),
        ),
      ),
    );
  }

  /* LoginCall(String mpin) async {
    if (Mpin == mpin) {
      await EasyLoading.show(
          status: strings.Loader, maskType: EasyLoadingMaskType.black);
      Navigator.pushReplacementNamed(context, AppRoutes.dashboardGridview);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "WRONG MPIN",
              descriptions: strings.Mpin_validation,
              Buttontext: strings.Presc_Ok,
              img: Image.asset(AssetPath.CrossIcon),
              onPressed: () {
                Navigator.of(context).pop();
                _mpin.text = "";
              },
              bgColor: Colors.red[900],
            );
          });
    }
    /* flag = saved;
    print('flag is $flag');
    if (flag == 0) {
      showAlert('Please Enter Valid MPIN');
    } else if (flag == 1) {
      Navigator.pushNamed(context, AppRoutes.dashboardGridview);
    } */
  } */
}
