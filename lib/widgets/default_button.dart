import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  Color? color;
  double? height;
   DefaultButton({
    required this.text,
    required this.onPressed,
    this.color = ColorManager.lightBlue,
    this.height = 50,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onPressed();
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height:  height,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: GoogleFonts.roboto(
            color: ColorManager.white,
            fontSize: MediaQuery.of(context).size.height*.025,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
