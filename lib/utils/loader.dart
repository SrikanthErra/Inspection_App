import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/res/constants/assetsPath.dart';
import 'package:lottie/lottie.dart';

class LoaderComponent extends StatefulWidget {
  const LoaderComponent({super.key});
  @override
  State<LoaderComponent> createState() => _LoaderComponentState();
}

class _LoaderComponentState extends State<LoaderComponent> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          color: Colors.black.withOpacity(0.3),
          child: Lottie.asset(
            AssetPath.loader,
            height: 20,
            width: 20,
          ),
        ),
      ],
    );
  }
}
