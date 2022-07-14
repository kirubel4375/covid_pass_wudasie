import 'package:covid_pass_wudasie/Constants/dimentions.dart';
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({Key? key, required this.webscreenLayout, required this.mobileScreenLayout}) : super(key: key);

  final Widget webscreenLayout;
  final Widget mobileScreenLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((BuildContext context, BoxConstraints constraints) {
        if(constraints.maxWidth>=kTabSize) {
          return webscreenLayout;
        }
        return mobileScreenLayout;
      }),
    );
  }
}
