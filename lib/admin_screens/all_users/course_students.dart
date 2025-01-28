
import 'package:e_learning_dathboard/admin_screens/all_users/group_student.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../widgets/navigate_to.dart';

class CourseStudent extends StatelessWidget {
  const CourseStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Course Students',style: TextStyle(
          color: ColorManager.black,
        ),),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      navigateTo(context,  GroupStudent(courseName: coursesNames[index],));
                    },
                    child: Container(
                      alignment: AlignmentDirectional.centerStart,
                      height:  MediaQuery.of(context).size.height*.14,
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height*.02,
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal:  MediaQuery.of(context).size.height*.02,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorManager.black
                          ),
                          borderRadius: BorderRadius.circular( MediaQuery.of(context).size.height*.02),

                      ),
                      // test
                      child: Text(coursesNames[index].toUpperCase(),
                        style: TextStyle(
                            color: ColorManager.black,
                            fontWeight: FontWeight.w500,
                            fontSize:  MediaQuery.of(context).size.height*.025
                        ),
                      ),


                    ),
                  );
                },
                separatorBuilder: (context,index){
                  return SizedBox(height:  MediaQuery.of(context).size.height*.03,);
                },
                itemCount: coursesNames.length,
              ),
            ),

          ]
        ),
      ),
    );
  }
}
