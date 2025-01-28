

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textManager({
   required Color color,
   FontWeight fontWeight=FontWeight.w400,
   double fontSize=17,
  }){

  return  GoogleFonts.roboto(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
  );

}
