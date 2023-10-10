import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inspection_app_flutter/res/components/base_scaffold.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/app_input_text.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/app_input_textfield.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/button_component.dart';
import 'package:inspection_app_flutter/res/constants/app_colors.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';
import 'package:inspection_app_flutter/viewmodel/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _mobile = TextEditingController();
  FocusScopeNode _node = FocusScopeNode();
  final _formkey1 = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  int? flag;
  List<String> mobileList = [];
  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LogInViewModel>(context, listen: false);

    return WillPopScope(
      onWillPop: () => _backPressed(),
      child: BaseScaffold(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(AssetPath.AppLogo)), */
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppInputText(
                    text: "Log IN",
                    colors: AppColors.textcolorblack,
                    size: 20,
                    weight: FontWeight.bold),
              ),
              AppInputTextfield(
                length: 10,
                inputFormatters: [
                  new FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
                hintText: "Mobile Number",
                nameController: _mobile,
                errorMessage: "please enter Mobile number",
                input_type: TextInputType.number,
                obsecuretext: false,
                node: _node,
                action: TextInputAction.next,
                onEditingComplete: () {
                  _node.nextFocus();
                },
                //lengthRequired: 10,
                globalKey: _formkey1,
              ),
              ButtonComponent(
                  onPressed: () async {
                    if (await loginViewModel.validateInputs(
                        _mobile.text, context)) {
                      int count = await loginViewModel.loginCount(
                          _mobile.text, context);
                      print("count is $count");
                    }
                    ;
                    //Navigator.pushNamed(context, AppRoutes.mpinValidate);
                  },
                  buttonText: "LOGIN"),
              /* Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppInputText(
                      text: strings.AccountCheck,
                      colors: Colors.black,
                      size: 15,
                      weight: FontWeight.w300),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.registraion);
                    },
                    child: Text(
                      strings.SignUp,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ) */
            ],
          ),
        ),
      ),
    );
  }

  /* Future<int> countMatchingRecords(String mobileNumber) async {
    final databaseReference = FirebaseDatabase.instance.ref();
    Query query = databaseReference
        .child("Family List")
        .orderByChild("mobileNumber")
        .equalTo(mobileNumber);
    DatabaseEvent event = await query.once();
    DataSnapshot snapshot = event.snapshot;
    int count = 0;
    if (snapshot.value != null) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      for (var entry in values.entries) {
        var key = entry.key;
        var value = entry.value;
        count++;
      await LocalStoreHelper().writeTheData("name", value["name"]);
      await LocalStoreHelper().writeTheData("mobile", value["mobile"]);
      await LocalStoreHelper().writeTheData("gender", value["gender"]);
      await LocalStoreHelper().writeTheData("membertype", value["membertype"]);
      await LocalStoreHelper().writeTheData("mpin", value["mpin"]);
      await LocalStoreHelper().writeTheData("familyID", value["familyID"]);
      await LocalStoreHelper().writeTheData("age", value["age"]);
      await LocalStoreHelper().writeTheData("FamilyKey",key);
        print('Matching key: $key');
        print('Matching value: $value');
      }
      ;
      
      print('Total matching records: $count');
    }
    return count;
  } */

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _mobile.text = '1111111111';
  }

  Future<bool> _backPressed() async {
    SystemNavigator.pop();
    return true;
  }
}
