import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class DefaultFormField extends StatelessWidget {

  final String hint;
  final bool isPassword;
  final TextInputType textInputType;
  final TextEditingController controller;
  IconData? suffixIcon;
  Function? suffixFunction;
  Widget? prefixWidget;
  String? validText;
  int? maxLines;
  bool enabled;

  DefaultFormField({
    required this.hint,
    required this.controller,
    required this.textInputType,
    this.isPassword=false,
    this.suffixIcon,
    this.suffixFunction,
    this.prefixWidget,
    this.enabled=true,
    this.validText,
    this.maxLines=1,
    Key? key
  }):super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        iconColor: ColorManager.primary,
        fillColor: Colors.grey[150],
        hintStyle: GoogleFonts.lato(
          fontSize: MediaQuery.of(context).size.height*0.017,
          color: Colors.black54,
        ),
        errorStyle: GoogleFonts.roboto(),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none
        ),
        prefixIcon: prefixWidget,
        suffixIcon: IconButton(onPressed: (){suffixFunction!();}, icon: Icon(suffixIcon),),
      ),
      style: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: MediaQuery.of(context).size.height*0.018,
      ),
      maxLines: maxLines,
      controller: controller,
      keyboardType: textInputType,
      obscureText: isPassword,
      validator: (value){
        if(value!.isEmpty){
          return validText;
        } else {
          return null;
        }
      },
    );
  }
}