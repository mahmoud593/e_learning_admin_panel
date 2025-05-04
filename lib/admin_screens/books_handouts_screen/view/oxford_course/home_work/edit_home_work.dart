import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/custom_toast.dart';
import 'package:e_learning_dathboard/widgets/default_button.dart';
import 'package:e_learning_dathboard/widgets/default_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditHomeWorkOxford extends StatefulWidget {
  EditHomeWorkOxford({super.key,required this.section,required this.index,required this.uId,required this.title,required this.url});
  final String section;
  final String uId;
  final String title;
  final String url;
  final int index;

  @override
  State<EditHomeWorkOxford> createState() => _EditOxfordSpeackingState();
}

class _EditOxfordSpeackingState extends State<EditHomeWorkOxford> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text=widget.title;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text('Upload Pdf'),
        ),
        body: BlocConsumer<AppCubit,AppStates>(
          listener: (context, state) {
            if(state is UpdateOxfordSpeakingSuccessState){
              customToast(title: 'Upload successfully ', color: ColorManager.primary);
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            return  ModalProgressHUD(
                inAsyncCall: state is UpdateOxfordSpeakingLoadingState,
                progressIndicator: CircularProgressIndicator(color: ColorManager.white,),
                child: Container(
                  padding:EdgeInsets.all( MediaQuery.sizeOf(context).height*0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name of Pdf',style: TextStyle(
                          fontSize:  MediaQuery.sizeOf(context).height*0.023,
                          fontWeight: FontWeight.bold
                      ),),


                      SizedBox( height:  MediaQuery.sizeOf(context).height*0.02,),

                      DefaultFormField(
                          hint: 'Enter name of Speaking....',
                          controller: controller,
                          maxLines: 3,
                          textInputType: TextInputType.name
                      ),

                      SizedBox( height:  MediaQuery.sizeOf(context).height*0.02,),
                      Text('Press to upload pdf',style: TextStyle(
                          fontSize:  MediaQuery.sizeOf(context).height*0.023,
                          fontWeight: FontWeight.bold
                      ),),

                      SizedBox( height:  MediaQuery.sizeOf(context).height*0.02,),

                      GestureDetector(
                        onTap: (){
                          cubit.updateOxfordSpeakingCourses(
                              title: controller.text,
                              uId: widget.uId,
                              index: widget.index,
                              filed: 'homeWork',
                              section: widget.index==0?'assignments':'markedAssignments'
                          );
                        },
                        child:  Container(
                          height:  MediaQuery.sizeOf(context).height*0.2,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Upload Pdf',style: TextStyle(
                                  fontSize:  MediaQuery.sizeOf(context).height*0.022,
                                  color:  ColorManager.white
                              )),

                              SizedBox( height:  MediaQuery.sizeOf(context).height*0.022,),
                              Image(
                                height:  MediaQuery.sizeOf(context).height*0.08,
                                image:  AssetImage('assets/images/pdf.png'),
                              )
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      DefaultButton(
                          color: ColorManager.primary,
                          text: 'Save',
                          onPressed: (){
                            cubit.updateOxfordSpeakingCoursesWithoutUrl(
                                title: controller.text,
                                url: widget.url,
                                filed: 'homeWork',
                                uId: widget.uId,
                                index: widget.index,
                                section: widget.index==0?'assignments':'markedAssignments'
                            );
                          }

                      )
                    ],
                  ),
                )
            );
          },
        )
    );
  }
}
