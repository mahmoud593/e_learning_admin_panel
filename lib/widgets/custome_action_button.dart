import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';


class CustomActionButton extends StatelessWidget {
  final IconData boxIcon;
  final GestureTapCallback onTap;
  Color? backgroundColor;
  Color? iconColor;


  CustomActionButton(
      {Key? key,
        required this.boxIcon,
        required this.onTap,
        this.backgroundColor = Colors.white,
        this.iconColor = Colors.black,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width * 0.13,
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              width: 2,
              color: const Color.fromARGB(255, 240, 237, 237),
            ),
            borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            boxIcon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}