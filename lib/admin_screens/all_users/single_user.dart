
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/data/models/student_model.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/default_button.dart';
import 'package:e_learning_dathboard/widgets/text_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../business_logic/app_cubit/app_states.dart';
import '../../data/models/user_model.dart';

class SingleUser extends StatelessWidget {
  final StudentModel studentModel;
  final bool isVerified;
  const SingleUser({super.key,
    required this.studentModel,
    required this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit=AppCubit.get(context);
        Size size =MediaQuery.of(context).size;
        return Scaffold(

          // title
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
            title: Text('Student Profile',
              style: TextStyle(
                  color: ColorManager.black,
                  fontWeight: FontWeight.w500,
                  fontSize: size.height*.025
              ),),
            titleSpacing: 0,

          ),

          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height*.02
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    CircleAvatar(
                      backgroundImage:const AssetImage('assets/images/student.png'),
                      radius: MediaQuery.of(context).size.height*.1,
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.03,),

                    ///Student Name
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Student Name',
                        style: textManager(color: ColorManager.black,fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.01,),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: studentModel.studentName,
                        iconColor: ColorManager.primary,
                        enabled: false,
                        hintStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height*0.02,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                              color: Colors.black
                            )
                        ),
                      ),


                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.03,),

                    /// Email
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Email',
                        style: textManager(color: ColorManager.black,fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.01,),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: studentModel.email,
                        iconColor: ColorManager.primary,
                        enabled: false,
                        hintStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height*0.02,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                                color: Colors.black
                            )
                        ),
                      ),


                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.03,),


                    /// Phone
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Student Phone',
                        style: textManager(color: ColorManager.black,fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.01,),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: studentModel.studentPhone,
                        iconColor: ColorManager.primary,
                        enabled: false,
                        hintStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height*0.02,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                                color: Colors.black
                            )
                        ),
                      ),


                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.03,),

                    /// Session
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Session',
                        style: textManager(color: ColorManager.black,fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.01,),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: studentModel.session[0],
                        iconColor: ColorManager.primary,
                        enabled: false,
                        hintStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height*0.02,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                                color: Colors.black
                            )
                        ),
                      ),


                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.03,),

                    /// Board
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Board',
                        style: textManager(color: ColorManager.black,fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.01,),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: studentModel.board,
                        iconColor: ColorManager.primary,
                        enabled: false,
                        hintStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height*0.02,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                                color: Colors.black
                            )
                        ),
                      ),


                    ),


                    SizedBox(height: MediaQuery.of(context).size.height*.03,),

                    /// School
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('School',
                        style: textManager(color: ColorManager.black,fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.01,),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: studentModel.school,
                        iconColor: ColorManager.primary,
                        enabled: false,
                        hintStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height*0.02,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                                color: Colors.black
                            )
                        ),
                      ),


                    ),


                    SizedBox(height: MediaQuery.of(context).size.height*.03,),

                    /// Parent Name
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Parent Name',
                        style: textManager(color: ColorManager.black,fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.01,),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: studentModel.parentName,
                        iconColor: ColorManager.primary,
                        enabled: false,
                        hintStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height*0.02,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                                color: Colors.black
                            )
                        ),
                      ),


                    ),


                    SizedBox(height: MediaQuery.of(context).size.height*.03,),


                    /// Parent Phone
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Parent Phone',
                        style: textManager(color: ColorManager.black,fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.01,),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: studentModel.parentPhone,
                        iconColor: ColorManager.primary,
                        enabled: false,
                        hintStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height*0.02,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                                color: Colors.black
                            )
                        ),
                      ),


                    ),


                    SizedBox(height: MediaQuery.of(context).size.height*.03,),

                    /// Payment Status
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Payment Status',
                        style: textManager(color: ColorManager.black,fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.01,),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: studentModel.isPayment==true?'Paid':'Not Paid',
                        iconColor: ColorManager.primary,
                        enabled: false,
                        hintStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height*0.02,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                                color: Colors.black
                            )
                        ),
                      ),


                    ),


                    SizedBox(height: MediaQuery.of(context).size.height*.03,),

                    isVerified==true?
                    DefaultButton(
                        color: ColorManager.primary,
                        text: 'Verify User',
                        onPressed: (){
                          cubit.verifiyUser(
                            userId: studentModel.uId,
                          ).then((value) {
                            Navigator.pop(context);
                          });
                        }
                    ):Container(),

                    isVerified==true?
                    SizedBox(height: MediaQuery.of(context).size.height*.03,):Container(),

                    DefaultButton(
                        color: ColorManager.red,
                        text: 'Delete User',
                        onPressed: (){
                          cubit.deleteUser(
                            userId: studentModel.uId,
                          ).then((value) {
                            Navigator.pop(context);
                          });
                        }
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.03,),


                  ],
                ),
              ),
            ),
          ),

        );

      },
    );
  }
}
