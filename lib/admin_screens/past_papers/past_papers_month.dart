import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning_dathboard/admin_screens/free_note_screen/view/material_screen.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/constants/constants.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigate_to.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/app_cubit/app_cubit.dart';

class PastPapersMonth extends StatelessWidget {
 final String title;
 final int mainIndex;
 const PastPapersMonth({super.key,required this.title,required this.mainIndex});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorManager.white,

            /// appbar
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Text(
                title,style: TextStyle(
                fontSize: MediaQuery.of(context).size.height*.025,
                color: ColorManager.black
                ,),
              ),
            ),

            ///body
            body: Column(
                children: [

                  ///listview
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index){

                          return GestureDetector(
                            onTap: (){
                              // navigateTo(context, const MaterialScreen(title: 'Papers', image: 'assets/images/paper.png',));
                              },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.height*.02,
                                  vertical: MediaQuery.of(context).size.height*.01
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.022),
                                color: ColorManager.primary,
                              ),
                              height: MediaQuery.of(context).size.height*0.15,


                              child:Row(
                                  children: [

                                    /// image
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.height*.02,
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      height: MediaQuery.of(context).size.height*0.1,
                                      width: MediaQuery.of(context).size.height*.1,
                                      decoration: BoxDecoration(
                                        color: ColorManager.white.withOpacity(.9),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: mainIndex==1?pastPapersImages[1]:pastPapersImages[0],
                                        progressIndicatorBuilder:  (context, url,downloadProgress) {
                                          return const Center(child: CircularProgressIndicator(),);
                                        },
                                        errorWidget: (context, url, error) {
                                          return const Image(image: AssetImage('assets/images/bookshelf.png'));
                                        },
                                      )
                                    ),


                                    /// sized box
                                    SizedBox(width: MediaQuery.of(context).size.height*0.02,),


                                    /// text
                                    Text(mainIndex==1? oxfordMonthString[index]:cambridgeMonthString[index],style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.height*0.025,
                                        color: ColorManager.white
                                    ),)
                                  ]
                              ) ,
                            ),
                          );
                        },
                        separatorBuilder: (context, index){
                          return SizedBox(height: MediaQuery.of(context).size.height*0.01,);
                        },
                        itemCount: mainIndex==1?oxfordMonthString.length:cambridgeMonthString.length
                    ),
                  ),

                ]
            ),
          );
        }
    );
  }
}
