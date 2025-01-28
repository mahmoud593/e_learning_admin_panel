
import 'package:e_learning_dathboard/admin_screens/free_note_screen/view/free_notest_section.dart';
import 'package:e_learning_dathboard/admin_screens/free_note_screen/view/material_screen.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/constants/constants.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigate_to.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class FreeNoteScreen extends StatelessWidget {
  const FreeNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: ()=>Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: ColorManager.black,
            size: MediaQuery.of(context).size.height*0.03,
          ),
        ),
        title: Text(
          'Free Notes',
          style: TextStyle(
            color: ColorManager.black,
            fontSize: MediaQuery.of(context).size.height*0.025,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: ColorManager.white,
      ),
      body: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){
          if(state is GetFreeNotesSuccessState){

          }
        },
        builder: (context, state){
          return ModalProgressHUD(
              progressIndicator: CircularProgressIndicator(color: ColorManager.white,),
              inAsyncCall: state is GetFreeNotesLoadingState,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height*0.02,
                    right: MediaQuery.of(context).size.height*0.02,
                    bottom: MediaQuery.of(context).size.height*0.02
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: ()async{
                              await AppCubit.get(context).getAllFreeNotes(
                                  section: freeNotesTitles[index]
                              );
                              navigateTo(context, MaterialScreen(
                                title: 'Pdf',
                                image: 'assets/images/pdf.png',
                                section: freeNotesTitles[index],
                              ));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.1,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,

                              decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height*0.02
                                ),
                              ),

                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.height*0.02,
                                  vertical: MediaQuery.of(context).size.height*0.02,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      freeNotesTitles[index],
                                      style: TextStyle(
                                        color: ColorManager.white,
                                        fontSize: MediaQuery.of(context).size.height*0.02,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: ColorManager.white,
                                      size: MediaQuery.of(context).size.height*0.03,
                                    ),
                                  ],
                                ),
                              ),

                            ),
                          );
                        },
                        separatorBuilder: (context,index){
                          return SizedBox(height: MediaQuery.of(context).size.height*0.01,);
                        },
                        itemCount: freeNotesTitles.length,
                      ),
                    ),
                  ],
                ),
              ),
          );
        }

      )
    );
  }
}
