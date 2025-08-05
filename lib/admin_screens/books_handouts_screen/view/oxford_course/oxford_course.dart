
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/books/books_name.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/home_work.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/handouts/oxford_handouts_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/home_work/home_work.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/mock_exams/oxford_home_work_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/mock_exams/oxford_tabs_mock_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/speaking/oxford_speaking_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/tracks/oxford_tracks_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/speaking_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/tracks_screen.dart';
import 'package:e_learning_dathboard/constants/constants.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:flutter/material.dart';

class OxfordCourseScreen extends StatelessWidget {
  const OxfordCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {

    List actions = [
          ()=>customPushNavigator(context, const OxfordHandoutsScreen(title: 'Books',)),
          ()=>customPushNavigator(context, const OxfordSpeakingScreen()),
          ()=>customPushNavigator(context, const OxfordTracksScreen()),
          ()=>customPushNavigator(context, const HomeWorkOxfordScreen()),
          ()=>customPushNavigator(context, const OxfordTabsMockScreen()),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: ()=>Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: ColorManager.black,
            size:  MediaQuery.sizeOf(context).height*0.03,
          ),
        ),
        title: Text(
          'Oxford Course',
          style: TextStyle(
            color: ColorManager.black,
            fontSize:  MediaQuery.sizeOf(context).height*0.025,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: ColorManager.white,
      ),
      body: Padding(
        padding: EdgeInsets.only(left:  MediaQuery.sizeOf(context).height*0.02,
            right:  MediaQuery.sizeOf(context).height*0.02,
            bottom:  MediaQuery.sizeOf(context).height*0.02),
        child: Column(
          children: [
            SizedBox(height:  MediaQuery.sizeOf(context).height*0.025,),

            Expanded(
              child: ListView.separated(
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: actions[index],
                    child: Container(
                      height:  MediaQuery.sizeOf(context).height*0.1,
                      width:  MediaQuery.sizeOf(context).width,
                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.circular( MediaQuery.sizeOf(context).height*0.02),
                      ),

                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal:  MediaQuery.sizeOf(context).height*0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              oxfordCourseSections[index],
                              style: TextStyle(
                                color: ColorManager.white,
                                fontSize:  MediaQuery.sizeOf(context).height*0.015,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: ColorManager.white,
                              size:  MediaQuery.sizeOf(context).height*0.03,
                            ),
                          ],
                        ),
                      ),

                    ),
                  );
                },
                separatorBuilder: (context,index){
                  return SizedBox(height:  MediaQuery.sizeOf(context).height*0.01,);
                },
                itemCount: oxfordCourseSections.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
