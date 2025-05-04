import 'package:e_learning_dathboard/admin_screens/group_info_screen/screens/edit_group_info.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/data/models/group_model.dart';
import 'package:e_learning_dathboard/data/models/payment_model.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:e_learning_dathboard/widgets/text_manager.dart';
import 'package:flutter/material.dart';


class GroupListItem extends StatelessWidget {
  const GroupListItem({super.key, required this.groupModel,required this.section});

  final GroupModel groupModel;
  final String section;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
          MediaQuery.of(context).size.height*.02
      ),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(
            MediaQuery.of(context).size.height*.02,
          ),
          decoration: BoxDecoration(
            color: ColorManager.secondDarkColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: (){
                          AppCubit.get(context).deleteGroups(
                              courseName: section,
                              uId: groupModel.uId.toString()
                          );
                        },
                        icon: Icon(Icons.delete,color: ColorManager.red,),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: (){
                          customPushNavigator(context, EditGroupInfo(
                            section: section,
                            uId: groupModel.uId.toString(),
                            courseName: groupModel.courseName.toString(),
                            startDate: groupModel.startDate.toString(),
                            endDate: groupModel.endDate.toString(),
                            startTime: groupModel.startTime.toString(),
                            endTime: groupModel.endTime.toString(),
                            count: groupModel.count.toString(),
                            status: groupModel.status,
                          ));
                        },
                        icon: Icon(Icons.edit,color: ColorManager.primary,),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              rowData(title: 'Course Name', data: groupModel.courseName.toString(),context: context),

              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              rowData(title: 'Start Date', data: groupModel.startDate.toString(),context: context),

              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              rowData(title: 'End Date', data: groupModel.endDate.toString(),context: context),

              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              rowData(title: 'Start Time', data:  groupModel.startTime.toString(),context: context),

              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              rowData(title: 'End Time', data: groupModel.endTime.toString(),context: context),

              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              rowData(title: 'Count', data: groupModel.count.toString(),context: context),

              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              rowData(title: 'Status', data:  groupModel.status.toString(),context: context),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowData ({required String title , required String data,required BuildContext context}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '$title : ',
          style: textManager(color: ColorManager.white),
          overflow: TextOverflow.ellipsis,
        ),

        Expanded(
          child: Text(
            data,
            style: textManager(color: Colors.white,fontSize: MediaQuery.of(context).size.height*.02),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

}
