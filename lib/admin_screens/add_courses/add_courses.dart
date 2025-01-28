
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/default_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class AddCourses extends StatelessWidget {

  const AddCourses({Key? key}) : super(key: key);

  static TextEditingController courseTitleController=TextEditingController();
  static TextEditingController courseLinkController=TextEditingController();

  static GlobalKey<FormState> formKey= GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){


      },
      builder: (context,state){
        var cubit=AppCubit.get(context);
        return Scaffold(

          // title
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
            title: Text('addCourse',
              style: GoogleFonts.aBeeZee(
                  color: ColorManager.black,
                  fontWeight: FontWeight.w500,
                  fontSize: MediaQuery.of(context).size.height*.03
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
                    horizontal: MediaQuery.of(context).size.height*.025,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: MediaQuery.of(context).size.height*.01,),

                      // course title
                      Text(
                        'title',
                        style: GoogleFonts.roboto(
                          color: ColorManager.black,
                          fontSize: MediaQuery.of(context).size.height*.025,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*.01,),

                      // enter course title
                      DefaultFormField(
                        textInputType: TextInputType.text,
                        controller: courseTitleController,
                        hint: 'enterCourseTitle',
                        validText: 'pleaseEnter',
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*.02,),

                      // course link
                      Text(
                        'link',
                        style: GoogleFonts.roboto(
                          color: ColorManager.black,
                          fontSize: MediaQuery.of(context).size.height*.025,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*.01,),

                      // Enter course link
                      DefaultFormField(
                        textInputType: TextInputType.text,
                        controller: courseLinkController,
                        hint: 'enterCourseLink',
                        validText: 'pleaseEnter',

                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*.02,),

                      Text(
                        'courseImage',
                        style: GoogleFonts.roboto(
                          color: ColorManager.black,
                          fontSize: MediaQuery.of(context).size.height*.025,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*.02,),

                      // GestureDetector(
                      //   onTap: (){
                      //
                      //   },
                      //   child: Container(
                      //     height: MediaQuery.of(context).size.height*.4,
                      //     width: MediaQuery.of(context).size.width,
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(15),
                      //         border: Border.all(
                      //           color: ColorManager.primary,
                      //         ),
                      //         image:cubit.courseImage!=null? DecorationImage(
                      //           image:  FileImage(cubit.courseImage!) ,
                      //         ):const DecorationImage(
                      //             image: AssetImage('assets/images/courseImage.jpg'),
                      //             fit: BoxFit.cover
                      //         )
                      //     ),
                      //   ),
                      // ),

                      SizedBox(height: MediaQuery.of(context).size.height*.02,),


                      // add course
                      // state is UploadCourseImageLoadingState?
                      // const Center(
                      //   child: CircularProgressIndicator(),
                      // ):
                      // DefaultButton(
                      //   text: 'addCourse',
                      //   onPressed: (){
                      //     if(formKey.currentState!.validate()){
                      //
                      //
                      //
                      //       }
                      //       else{
                      //
                      //         customToast(title: 'Please,Add required image', color: ColorManager.red);
                      //
                      //       }
                      //
                      //
                      //     }
                      //
                      //
                      // ),

                      SizedBox(height: MediaQuery.of(context).size.height*.01,),


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
