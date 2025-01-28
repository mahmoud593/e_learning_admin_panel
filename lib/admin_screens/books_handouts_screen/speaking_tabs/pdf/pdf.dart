import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PdfSpeakerScreen extends StatelessWidget {
  const PdfSpeakerScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){

        },
      builder: (context,state){
          var cubit=AppCubit.get(context);
          return Scaffold(
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.redAccent,
                onPressed: (){
                  // cubit.uploadPdf(
                  //     title: 'title',
                  //     section: 'section'
                  // );
                },
                child: Icon(
                  Icons.upload_file_outlined,
                  color: ColorManager.white,
                )
            ),

            body: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,
                  left: MediaQuery.of(context).size.height*0.02,
                  right: MediaQuery.of(context).size.height*0.02,
                  bottom: MediaQuery.of(context).size.height*0.02
              ),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.015,),

                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context,index){
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.022),
                            color: ColorManager.primary,
                          ),
                          height: MediaQuery.of(context).size.height*0.15,


                          child:Padding(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.01),
                            child: Row(
                                children: [

                                  /// image
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: MediaQuery.of(context).size.height*.01,
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
                                      imageUrl: 'https://img.freepik.com/free-photo/english-books-with-red-background_23-2149440458.jpg?w=360&t=st=1703150045~exp=1703150645~hmac=38549c832725cef0920fc52fc2a15442b0f41c825fb24c92f7c44122af614ddd',
                                      progressIndicatorBuilder:  (context, url,downloadProgress) {
                                        return const Center(child: CircularProgressIndicator(),);
                                      },
                                      errorWidget: (context, url, error) {
                                        return const Image(image: AssetImage('assets/images/bookshelf.png'));
                                      },
                                    ),
                                  ),


                                  /// sized box
                                  SizedBox(width: MediaQuery.of(context).size.height*0.02,),


                                  /// text
                                  Expanded(
                                    child: Text(
                                      'Book Name Here',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height*0.02,
                                          color: ColorManager.white
                                      ),
                                      maxLines: 2,
                                    ),
                                  )
                                ]
                            ),
                          ) ,
                        );
                      },
                      separatorBuilder: (context,index){
                        return SizedBox(height: MediaQuery.of(context).size.height*0.01,);
                      },
                      itemCount: 10,
                    ),
                  ),
                ],
              ),
            ),
          );
      },
    );
  }
}
