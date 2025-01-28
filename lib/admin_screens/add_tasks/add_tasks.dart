
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/default_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/default_button.dart';


class AddTasks extends StatelessWidget {

  const AddTasks({Key? key}) : super(key: key);

  static TextEditingController taskUrlController=TextEditingController();
  static TextEditingController taskDescriptionController=TextEditingController();
  static TextEditingController taskTypeController=TextEditingController();
  static TextEditingController taskTimerController=TextEditingController();
  static TextEditingController taskPriceController=TextEditingController();

  static GlobalKey<FormState> formKey= GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){

        return Scaffold(

          // title
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
            title: Text('add_tasks',
              style: GoogleFonts.aBeeZee(
                  color: ColorManager.black,
                  fontWeight: FontWeight.w500,
                  fontSize:  MediaQuery.of(context).size.height*.03
              ),),
            titleSpacing: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white
            ),
          ),

          body: SafeArea(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal:  MediaQuery.of(context).size.height*.025,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height:  MediaQuery.of(context).size.height*.01,),

                      // title
                      Text(
                        'url',
                        style: GoogleFonts.roboto(
                          color: ColorManager.black,
                          fontSize:  MediaQuery.of(context).size.height*.025,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height:  MediaQuery.of(context).size.height*.01,),

                      // enter task url
                      DefaultFormField(
                        textInputType: TextInputType.text,
                        controller: taskUrlController,
                        hint: 'enterTaskUrl',
                        validText:'pleaseEnter',
                      ),

                      SizedBox(height:  MediaQuery.of(context).size.height*.02,),

                      // Description
                      Text(
                        'description',
                        style: GoogleFonts.roboto(
                          color: ColorManager.black,
                          fontSize:  MediaQuery.of(context).size.height*.025,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height:  MediaQuery.of(context).size.height*.01,),

                      // enter task Description
                      DefaultFormField(
                        textInputType: TextInputType.text,
                        controller: taskDescriptionController,
                        hint: 'enterTaskDescription',
                        maxLines: 5,
                        validText: 'pleaseEnter',

                      ),

                      SizedBox(height:  MediaQuery.of(context).size.height*.02,),

                      // Type
                      Text(
                        'type',
                        style: GoogleFonts.roboto(
                          color: ColorManager.black,
                          fontSize:  MediaQuery.of(context).size.height*.025,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height:  MediaQuery.of(context).size.height*.01,),

                      // Enter task type
                      DefaultFormField(
                        textInputType: TextInputType.text,
                        controller: taskTypeController,
                        hint: 'enterTaskType',
                        validText: 'pleaseEnter',

                      ),

                      SizedBox(height:  MediaQuery.of(context).size.height*.02,),

                      // timer
                      Text(
                        'timer',
                        style: GoogleFonts.roboto(
                          color: ColorManager.black,
                          fontSize:  MediaQuery.of(context).size.height*.025,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height:  MediaQuery.of(context).size.height*.01,),

                      // Enter task timer
                      DefaultFormField(
                        textInputType: TextInputType.text,
                        controller: taskTimerController,
                        hint: 'enterTaskTimer',
                        validText: 'pleaseEnter',

                      ),

                      SizedBox(height:  MediaQuery.of(context).size.height*.02,),

                      // price
                      Text(
                        'price',
                        style: GoogleFonts.roboto(
                          color: ColorManager.black,
                          fontSize:  MediaQuery.of(context).size.height*.025,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height:  MediaQuery.of(context).size.height*.01,),

                      // Enter task price
                      DefaultFormField(
                        textInputType: TextInputType.text,
                        controller: taskPriceController,
                        hint: 'enterTaskPrice',
                        validText: 'pleaseEnter',

                      ),

                      SizedBox(height:  MediaQuery.of(context).size.height*.02,),

                      // send task
                      DefaultButton(
                        text:'send_task',
                        onPressed: (){
                            if(formKey.currentState!.validate()){



                            }
                        },

                      ),

                      SizedBox(height:  MediaQuery.of(context).size.height*.01,),


                    ],
                  ),
                ),
              ),
            ),
          ),
        );

      },

    );
  }
}
