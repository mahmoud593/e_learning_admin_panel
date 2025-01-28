
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/default_button.dart';
import 'package:e_learning_dathboard/widgets/text_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ConfirmUserRequest extends StatelessWidget {


  const ConfirmUserRequest({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit= AppCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.white,

          // title
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
            title: Text('Identity Confirmation',
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
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.height*.04,
                    vertical: MediaQuery.of(context).size.height*.01
                ),
                child: Column(
                  children: [

                    CircleAvatar(
                      backgroundImage:const NetworkImage('https://img.freepik.com/premium-photo/portrait-handsome-young-african-american-man-smiling-isolated-yellow-wall_255757-754.jpg?w=740'),
                      radius: MediaQuery.of(context).size.height*.1,
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.03,),

                    /// Name
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Name',
                        style: textManager(color: ColorManager.black,fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.01,),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Mahmoud Reda',
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
                        hintText: 'mahmoudreda1811@gmail.com',
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
                      child: Text('Phone',
                        style: textManager(color: ColorManager.black,fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.01,),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: '01277556432',
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

                    /// Course
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Course',
                        style: textManager(color: ColorManager.black,fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.01,),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Oxford',
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

                    /// Group
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Group',
                        style: textManager(color: ColorManager.black,fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.01,),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Group 2',
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


                    // accept and refuse buttons
                    Row(
                      children: [

                        // accept
                        Expanded(
                          child: DefaultButton(
                              text: 'accept',
                              color: ColorManager.primary,
                              onPressed: (){

                              }
                          ),
                        ),

                        SizedBox(width: MediaQuery.of(context).size.height*.02,),

                        // refuse
                        Expanded(
                          child: DefaultButton(
                              text: 'refuse',
                              color: ColorManager.red,
                              onPressed: (){

                              }
                          ),
                        ),

                      ],
                    )
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
