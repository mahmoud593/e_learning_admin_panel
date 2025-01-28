
import 'package:e_learning_dathboard/data/models/student_model.dart';
import 'package:e_learning_dathboard/data/models/user_model.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:flutter/material.dart';


class UserItem extends StatelessWidget {

  final StudentModel studentModel;

  const UserItem({Key? key,required this.studentModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.height*.02,
        right: MediaQuery.of(context).size.height*.02,
        bottom: MediaQuery.of(context).size.height*.0,
      ),
      child: Material(
        elevation: 2,
        color: ColorManager.primary.withOpacity(.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.height*.02,
            right: MediaQuery.of(context).size.height*.02,
            top: MediaQuery.of(context).size.height*.02,
            bottom: MediaQuery.of(context).size.height*.02,
          ),

          decoration: BoxDecoration(
            color: ColorManager.black.withOpacity(.8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: ColorManager.white,
                    radius:  MediaQuery.of(context).size.height*.032,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/student.png'),
                      radius: MediaQuery.of(context).size.height*.03,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.height*.03,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:  CrossAxisAlignment.start,
                      children: [
                        Text(studentModel.studentName,
                          style: TextStyle(
                            color: ColorManager.white,
                            fontWeight: FontWeight.w300,
                            fontSize: MediaQuery.of(context).size.height*.022
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*.01,),
                        Text(studentModel.email,
                          style: TextStyle(
                                color: ColorManager.white,
                              fontWeight: FontWeight.w300,
                              fontSize: MediaQuery.of(context).size.height*.018
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
