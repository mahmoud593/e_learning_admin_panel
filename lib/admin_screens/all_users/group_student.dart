
import 'package:e_learning_dathboard/admin_screens/all_users/all_users.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../widgets/navigate_to.dart';

class GroupStudent extends StatelessWidget {
  final String courseName;
  const GroupStudent({super.key,required this.courseName});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){

        },
      builder: (context,state){
          var cubit=AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Text('Groups',style: TextStyle(
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

                              cubit.getAllStudents(
                                  courseName: courseName,
                                  groupName: groupName[index],
                              ).then((value) {
                                // navigateTo(context, AllUser(
                                //     courseName: courseName,
                                //     groupName: groupName[index]
                                // ));
                              });

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
                              child: Text(groupName[index].capitalizeFirst!,
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
      },
    );
  }
}
