import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inspection_app_flutter/model/user_insert_model.dart';
import 'package:inspection_app_flutter/res/app_alerts/customAlerts.dart';
import 'package:inspection_app_flutter/res/components/base_scaffold.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/app_input_text.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/app_input_textfield.dart';
import 'package:inspection_app_flutter/res/components/reusable%20widgets/button_component.dart';
import 'package:inspection_app_flutter/res/constants/app_colors.dart';
import 'package:inspection_app_flutter/res/routes/app_routes.dart';
import 'package:inspection_app_flutter/utils/loader.dart';
import 'package:inspection_app_flutter/viewmodel/add_inspector_view_model.dart';
import 'package:provider/provider.dart';

class AddSubUser extends StatefulWidget {
  const AddSubUser({super.key});

  @override
  State<AddSubUser> createState() => _AddSubUserState();
}

class _AddSubUserState extends State<AddSubUser> {
  TextEditingController family_name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  FocusScopeNode node = FocusScopeNode();
  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
  final _formkey3 = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /* id = await LocalStoreHelper().readTheData("familyID");
      print("fam Mem id is $id"); */
    });
  }

  @override
  Widget build(BuildContext context) {
    final addInspectorModel =
        Provider.of<AddInspectorViewModel>(context, listen: false);
    return Stack(
      children: [
        BaseScaffold(
          //bottomSheetVis: true,
          resize: true,
          AppBarvis: true,
          titleName: "Add Inspection Member",
          appBar: AppBar(
            title: Center(
                child: Text(
              "Add Inspection Member",
            )),
          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width * 0.85,
                    margin: EdgeInsets.only(top: 20),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /* CircleAvatar(
                              radius: 50, backgroundImage: AssetImage(AssetPath.AppLogo)), */
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 15),
                            child: AppInputText(
                              text: "Add Inspection Member",
                              colors: AppColors.textcolorblack,
                              size: 20,
                              weight: FontWeight.w600,
                            ),
                          ),
                          AppInputTextfield(
                            textfieldwidth: MediaQuery.of(context).size.width * 0.7,
                            hintText: "Inspector Name",
                            nameController: family_name,
                            inputFormatters: [
                              new FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                            ],
                            errorMessage: "Please enter inspector name",
                            input_type: TextInputType.text,
                            obsecuretext: false,
                            action: TextInputAction.next,
                            node: node,
                            onEditingComplete: () {
                              node.nextFocus();
                            },
                            globalKey: _formkey1,
                          ),
                          /* AppInputTextfield(
                            hintText: strings.RegFam_Hint_Age,
                            nameController: age,
                            inputFormatters: [
                              new FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            ],
                            errorMessage: strings.RegFam_ErrorMsg_Age,
                            input_type: TextInputType.number,
                            obsecuretext: false,
                            length: 3,
                            action: TextInputAction.next,
                            node: node,
                            onEditingComplete: () {
                              node.nextFocus();
                            },
                            globalKey: _formkey2,
                          ), */
                          AppInputTextfield(
                            textfieldwidth: MediaQuery.of(context).size.width * 0.7,
                            hintText: "mobile Number",
                            nameController: mobileNumber,
                            errorMessage: "Please enter mobile number",
                            input_type: TextInputType.number,
                            obsecuretext: false,
                            action: TextInputAction.next,
                            node: node,
                            inputFormatters: [
                              new FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            ],
                            onEditingComplete: () {
                              node.nextFocus();
                            },
                            length: 10,
                            //lengthRequired: 10,
                            globalKey: _formkey3,
                          ),
                          /* Container(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    strings.Gender_SelectHeader,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        addRadioButton(0, strings.Gender_Male),
                                        addRadioButton(1, strings.Gender_Female),
                                        addRadioButton(2, strings.Gender_Other),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ), */
                          ButtonComponent(
                              onPressed: () async {
                                if (await addInspectorModel.validateInputs(
                                    family_name.text, mobileNumber.text, context)) {
                                  bool exists = await addInspectorModel
                                      .checkNumberExists(mobileNumber.text, context);
                                  if (exists) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialogBox(
                                          title: "MOBILE NUMBER ALREADY EXISTS",
                                          descriptions:
                                              "Please enter another mobile number",
                                          Buttontext: 'OK',
                                          //img: Image.asset(AssetPath.WarningBlueIcon),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                    );
                                  } else {
                                    await addInspectorModel.insertInspectorData(family_name.text, mobileNumber.text, context);
                                    //Navigator.pushReplacementNamed(context, AppRoutes.DashboardView);
                                  }
                                }
                              },
                              buttonText: "Submit"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (addInspectorModel.isLoading) LoaderComponent()
      ],
    );
  }

  /* Row addRadioButton(int btnValue, String title) {
    return Row(
      children: <Widget>[
        Radio(
          activeColor: Colors.white,
          value: Gender[btnValue],
          groupValue: selectedValue,
          onChanged: (value) {
            setState(() {
              print(value);
              selectedValue = value;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            title,
            style: RadioTextSTyle,
          ),
        )
      ],
    );
  } */
}
