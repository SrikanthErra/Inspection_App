import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/res/constants/app_colors.dart';
import 'package:inspection_app_flutter/res/constants/app_constants.dart';

class CustomWarningAlert extends StatefulWidget {
  final String descriptions;
  final String? version;
  final void Function() onPressed;
  final void Function() onPressed1;
  final String Img;
  final Color? imagebg;
  final Color? bgColor;

  const CustomWarningAlert({
    Key? key,
    required this.descriptions,
    required this.onPressed,
    this.bgColor,
    required this.Img,
    this.imagebg,
    required this.onPressed1,
    this.version,
  }) : super(key: key);

  @override
  _CustomWarningAlertState createState() => _CustomWarningAlertState();
}

class _CustomWarningAlertState extends State<CustomWarningAlert> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.only(left: 10, top: 50, right: 10, bottom: 10),
          margin: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(0.0),
              color: AppColors.textcolorwhite,
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                "Inspection App",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Version: ${AppConstants.version_number}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            //minimumSize: MaterialStateProperty.all(Size(22, 50)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: widget.onPressed,
                        child: Text(
                          "No",
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            //minimumSize: MaterialStateProperty.all(Size(22, 50)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                        onPressed: widget.onPressed1,
                        child: Text(
                          "Yes",
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 10,
          right: 10,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 93, 2, 20),
              radius: 35,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  child: Image.asset(
                    widget.Img,
                    fit: BoxFit.cover,
                  )),
              /* Image.asset(
                    widget.Img,
                    // width: 100, height: 100,
                    fit: BoxFit.cover,
                  )), */
            ),
          ),
        ),
      ],
    );
  }
}
