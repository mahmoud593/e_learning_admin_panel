
import 'package:e_learning_dathboard/admin_screens/admin_home/admin_home.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/default_button.dart';
import 'package:e_learning_dathboard/widgets/navigate_to.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


class NotUsersYet extends StatelessWidget {
  const NotUsersYet ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:  MediaQuery.of(context).size.height,
      color: ColorManager.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.height*0.03,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Lottie.asset("assets/images/empty.json"),

            SizedBox(height:  MediaQuery.of(context).size.height*0.02,),

            Text('notUserEnterYet',
              style: GoogleFonts.roboto(
                fontSize:  MediaQuery.of(context).size.height*0.02,
                color: ColorManager.secondDarkColor,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height:  MediaQuery.of(context).size.height*0.1,),

            DefaultButton(
              text:'backToHome',
              onPressed: ()=>navigateAndRemove(context, const AdminHome()),
              color: ColorManager.secondDarkColor,
            ),
          ],
        ),
      ),
    );
  }
}
