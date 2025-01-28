
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/books/books_name.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/cambridg_course/handouts/cambridge_handouts_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/cambridg_course/home_work/home_work.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/cambridg_course/mock_exams/cambridge_mock_exams_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/cambridg_course/revision/cambridge_handouts_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/cambridg_course/speaking/oxford_speaking_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/cambridg_course/tracks/cambridge_tracks_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/home_work.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/speaking_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/tracks_screen.dart';
import 'package:e_learning_dathboard/constants/constants.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:flutter/material.dart';

class CambridgeCourseScreen extends StatelessWidget {
  const CambridgeCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {

    List actions = [
      ()=>customPushNavigator(context, const CambridgeHandoutsScreen(title: 'Handouts',)),
      ()=>customPushNavigator(context, const CambridgeSpeakingScreen()),
      ()=>customPushNavigator(context, const CambridgeTracksScreen()),
      ()=>customPushNavigator(context, const HomeWorkCambridgeScreen()),
      ()=>customPushNavigator(context, const CambridgeMockExamsScreen(title: 'Mock Exams',)),
      ()=>customPushNavigator(context, const CambridgeRevisionScreen(title: 'Revision',)),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: ()=>Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: ColorManager.black,
            size: MediaQuery.of(context).size.height*0.03,
          ),
        ),
        title: Text(
          'Cambridge Course',
          style: TextStyle(
            color: ColorManager.black,
            fontSize: MediaQuery.of(context).size.height*0.025,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: ColorManager.white,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.height*0.02,
            right: MediaQuery.of(context).size.height*0.02,
            bottom: MediaQuery.of(context).size.height*0.02),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.025,),

            Expanded(
              child: ListView.separated(
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: actions[index],
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.1,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.02),
                      ),

                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cambridgeCourseSections[index],
                              style: TextStyle(
                                color: ColorManager.white,
                                fontSize: MediaQuery.of(context).size.height*0.015,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: ColorManager.white,
                              size: MediaQuery.of(context).size.height*0.03,
                            ),
                          ],
                        ),
                      ),

                    ),
                  );
                },
                separatorBuilder: (context,index){
                  return SizedBox(height: MediaQuery.of(context).size.height*0.01,);
                },
                itemCount: cambridgeCourseSections.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
