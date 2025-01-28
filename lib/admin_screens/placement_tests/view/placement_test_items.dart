import 'package:e_learning_dathboard/admin_screens/free_note_screen/view/upload_pdf.dart';
import 'package:e_learning_dathboard/admin_screens/open_pdf/open_pdf.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigate_to.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacementTestItems extends StatelessWidget {
  final String title;
  final String section;
  const PlacementTestItems({super.key,required this.title,required this.section});

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
                            childAspectRatio: 1/0.85,
                            children: List.generate(1,(index) =>
                                GestureDetector(
                                  onTap: (){
                                    navigateTo(context,  OpenPdf(
                                      title: 'Placement Test',
                                      pdfUrl: cubit.placementModel!.link,
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
                                            image:  AssetImage('assets/images/university.png'),
                                          ),

                                          SizedBox(height: MediaQuery.of(context).size.height*0.02,),

                                          Text(
                                            title,style: TextStyle(
                                              color: ColorManager.white,
                                              fontSize: MediaQuery.of(context).size.height*0.022,
                                              fontWeight: FontWeight.w300
                                          ),
                                            textAlign:  TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                          ),

                                          SizedBox(height: MediaQuery.of(context).size.height*0.02,),

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

          floatingActionButton: FloatingActionButton.extended(
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
          )
        );
      },
    );
  }
}
