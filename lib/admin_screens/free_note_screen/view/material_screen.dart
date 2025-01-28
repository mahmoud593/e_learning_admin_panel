
import 'package:e_learning_dathboard/admin_screens/free_note_screen/view/upload_pdf.dart';
import 'package:e_learning_dathboard/admin_screens/open_pdf/open_pdf.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigate_to.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaterialScreen extends StatelessWidget {
  final String title;
  final String image;
  final String section;
  const MaterialScreen({super.key,required this.title,required this.image,required this.section});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){

        },
        builder: (context,state){
          var cubit = AppCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  section,style: TextStyle(
                  color: ColorManager.black,
                ),
                ),
              ),
              body: BlocBuilder<AppCubit,AppStates>(
                builder:  (context,state){
                  var cubit=AppCubit.get(context);
                  return Container(
                      color: ColorManager.white,
                      child: Column(
                        children: [
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio: 1/.7,
                              children: List.generate(cubit.freeNotesList.length,(index) =>
                                  GestureDetector(
                                onTap: (){
                                  navigateTo(context,  OpenPdf(
                                      title: cubit.freeNotesList[index].title,
                                      pdfUrl: cubit.freeNotesList[index].url,
                                  ));

                                },
                                child: Container(
                                  padding:  EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context).size.height*0.02
                                  ) ,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: MediaQuery.of(context).size.height*0.015,
                                      vertical: MediaQuery.of(context).size.height*0.01
                                  ),
                                  decoration: BoxDecoration(
                                      color: ColorManager.primary,
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.height*0.02
                                      )
                                  ),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Image(
                                          height: MediaQuery.of(context).size.height*0.06,
                                          width: MediaQuery.sizeOf(context).height*0.06,
                                          image:  AssetImage(image),
                                        ),

                                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),

                                        Text(
                                          cubit.freeNotesList[index].title,style: TextStyle(
                                            color: ColorManager.white,
                                            fontSize: MediaQuery.of(context).size.height*0.022,
                                            fontWeight: FontWeight.w300
                                        ),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ]
                                  ),
                                ),
                              ),
                              ),
                            ),
                          )
                        ],
                      )
                  );
                }
              ),

              floatingActionButton: title=='Pdf'?FloatingActionButton.extended(
                  backgroundColor: Colors.redAccent,
                  onPressed: (){
                    customPushNavigator(context, UploadPdf(
                      section: section,
                    ));
                  },
                  label: Row(
                    children: [
                      Icon(
                        Icons.upload_file_outlined,
                        color: ColorManager.white,
                      ),
                      SizedBox(width:  MediaQuery.sizeOf(context).height*0.01,),
                      Text(
                        'Upload',style: TextStyle(
                            color: ColorManager.white,
                            fontSize:  MediaQuery.sizeOf(context).height*0.02
                        ))
                    ],
                  )
                 ):title=='Audio'?FloatingActionButton(
                  backgroundColor: Colors.redAccent,
                  onPressed: (){

                  },
                  child: Icon(
                    Icons.audio_file,
                    color: ColorManager.white,
                  )
              ):FloatingActionButton(
                  backgroundColor: Colors.redAccent,
                  onPressed: (){

                  },
                  child: Icon(
                    Icons.video_call,
                    color: ColorManager.white,
                  )
              ),
            );
        },
    );
  }
}
