
import 'package:e_learning_dathboard/admin_screens/admin_home/admin_home.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_)async{
      if(mounted){
        Future.delayed(const Duration(seconds: 3), () {
            customPushReplacement(context, const AdminHome());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).height*0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            /// title
            Text(
              'How to easily get A+ with \nDr. Mohamed Ismail',
              style: TextStyle(
                  fontSize:  MediaQuery.sizeOf(context).height*0.03,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),

            SizedBox(height:  MediaQuery.sizeOf(context).height*0.03,),

            /// image
            Container(
              height:  MediaQuery.sizeOf(context).height * 0.4,
              width:  MediaQuery.sizeOf(context).height * 0.4,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                color: ColorManager.white
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image(
                height:  MediaQuery.sizeOf(context).height * 0.3,
                width:  MediaQuery.sizeOf(context).width,
                image: const AssetImage('assets/images/elearning_splash.jpg'),
                fit: BoxFit.fill,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
