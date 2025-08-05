import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/cambridg_course/cambridg_course.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/lelts_course/ielts_course.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/oxford_course.dart';
import 'package:e_learning_dathboard/admin_screens/group_info_screen/screens/online_face_screen.dart';
import 'package:e_learning_dathboard/admin_screens/group_info_screen/screens/show_group_details_screen.dart';
import 'package:e_learning_dathboard/constants/constants.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';


import 'package:flutter/material.dart';

class GroupInfoScreen extends StatelessWidget {
   GroupInfoScreen({super.key});

  List<String> image=[
    'https://firebasestorage.googleapis.com/v0/b/elearningapp-4adde.appspot.com/o/WhatsApp%20Image%202025-05-07%20at%201.38.42%20AM.jpeg?alt=media&token=7dc8717a-4e85-4c27-a76c-3ab244229559',
    'https://firebasestorage.googleapis.com/v0/b/elearningapp-4adde.appspot.com/o/WhatsApp%20Image%202025-05-07%20at%201.38.42%20AM%20(1).jpeg?alt=media&token=6bb6b54e-9c80-4f9a-bcbc-faa2b29d0364',
    'https://firebasestorage.googleapis.com/v0/b/elearningapp-4adde.appspot.com/o/WhatsApp%20Image%202025-05-07%20at%201.38.43%20AM.jpeg?alt=media&token=0009fb9c-2e9c-42c3-8c15-eef863e2c4a8'
  ];


  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: ColorManager.black,
            size:  MediaQuery.of(context).size.height*0.03,
          ),
        ),
        title: Text(
          'Groups',
          style: TextStyle(
            color: ColorManager.black,
            fontSize:  MediaQuery.of(context).size.height*0.025,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: ColorManager.white,
      ),
      body: Padding(
        padding: EdgeInsets.only(top:  MediaQuery.of(context).size.height*0.01,left:  MediaQuery.of(context).size.height*0.02,right:  MediaQuery.of(context).size.height*0.02, bottom:  MediaQuery.of(context).size.height*0.02),
        child: Column(
          children: [
            SizedBox(height:  MediaQuery.of(context).size.height*0.015),

            Expanded(
              child: ListView.separated(
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      if(index==0){
                        customPushNavigator(context, OnlineFaceScreen(courseName: 'oxford',));
                      }else if(index==1){
                        customPushNavigator(context, OnlineFaceScreen(courseName: 'Cambridge',));
                      }else if(index==2){
                        customPushNavigator(context, OnlineFaceScreen(courseName: 'ielts',));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular( MediaQuery.of(context).size.height*0.022),
                        color: ColorManager.primary,
                      ),
                      height:  MediaQuery.of(context).size.height*0.15,


                      child:Padding(
                        padding: EdgeInsets.all( MediaQuery.of(context).size.height*0.01),
                        child: Row(
                            children: [

                              /// image
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal:  MediaQuery.of(context).size.height*.01,
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                height:  MediaQuery.of(context).size.height*0.1,
                                width:  MediaQuery.of(context).size.height*.1,
                                decoration: BoxDecoration(
                                  color: ColorManager.white.withOpacity(.9),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: image[index],
                                  progressIndicatorBuilder:  (context, url,downloadProgress) {
                                    return const Center(child: CircularProgressIndicator(),);
                                  },
                                  errorWidget: (context, url, error) {
                                    return const Image(image: AssetImage('assets/images/bookshelf.png'));
                                  },
                                ),
                              ),


                              /// sized box
                              SizedBox(width:  MediaQuery.of(context).size.height*0.02,),


                              /// text
                              Expanded(
                                child: Text(
                                  coursesNamesMaterial[index],
                                  style: TextStyle(
                                      fontSize:  MediaQuery.of(context).size.height*0.025,
                                      color: ColorManager.white
                                  ),
                                  maxLines: 2,
                                ),
                              )
                            ]
                        ),
                      ) ,
                    ),
                  );
                },
                separatorBuilder: (context,index){
                  return SizedBox(height:  MediaQuery.of(context).size.height*0.01,);
                },
                itemCount: coursesNames.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
