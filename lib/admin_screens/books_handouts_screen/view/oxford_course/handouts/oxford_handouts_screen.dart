import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/books/books_parts.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/lelts_course/handouts/upload_handouts.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/handouts/edit_handouts.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/handouts/upload_handouts.dart';
import 'package:e_learning_dathboard/admin_screens/open_pdf/open_pdf.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OxfordHandoutsScreen extends StatefulWidget {
  final String title;
  const OxfordHandoutsScreen({super.key,required this.title});

  @override
  State<OxfordHandoutsScreen> createState() => _OxfordHandoutsScreenState();
}

class _OxfordHandoutsScreenState extends State<OxfordHandoutsScreen> {

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getOxfordCourses(section: 'books');
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit=AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: ColorManager.black,
                size:  MediaQuery.of(context).size.height*0.03,
              ),
            ),
            title: Text(
              widget.title,
              style: TextStyle(
                color: ColorManager.black,
                fontSize:  MediaQuery.of(context).size.height*0.025,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: ColorManager.white,
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.redAccent,
              onPressed: (){
               customPushNavigator(context, UploadOxfordHandouts(section: 'books'));
              },
              child: Icon(
                Icons.upload_file_outlined,
                color: ColorManager.white,
              )
          ),

          body: Padding(
            padding: EdgeInsets.only(top:  MediaQuery.of(context).size.height*0.01,
                left:  MediaQuery.of(context).size.height*0.02,
                right:  MediaQuery.of(context).size.height*0.02,
                bottom:  MediaQuery.of(context).size.height*0.02
            ),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),

                state is GetOxfordCoursesLoadingState || state is DeleteOxfordCoursesLoadingState?
                const Center(child: CircularProgressIndicator(),):
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          customPushNavigator(context, OpenPdf(
                            pdfUrl:cubit.oxfordCoursesList[index].url
                            ,title: cubit.oxfordCoursesList[index].title,
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.022),
                            color: ColorManager.primary,
                          ),
                          height: MediaQuery.of(context).size.height*0.2,
                          child:Padding(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.01),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
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
                                          cubit.oxfordCoursesList[index].title,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.height*0.022,
                                              color: ColorManager.white
                                          ),
                                          maxLines: 2,
                                        ),
                                      )
                                    ]
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                     IconButton(
                                         onPressed: (){
                                           cubit.deleteOxfordCourses(
                                               section: 'books',
                                               uId: cubit.oxfordCoursesList[index].uId,
                                           );
                                         },
                                         icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: MediaQuery.of(context).size.height*0.03,
                                         )
                                     ),
                                    SizedBox(width: MediaQuery.of(context).size.height*0.005,),
                                    IconButton(
                                        onPressed: (){
                                          customPushNavigator(context, EditOxfordHandouts(
                                            uId: cubit.oxfordCoursesList[index].uId,
                                            title: cubit.oxfordCoursesList[index].title,
                                            url: cubit.oxfordCoursesList[index].url,
                                            section: 'books',
                                          ));
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: ColorManager.white,
                                          size: MediaQuery.of(context).size.height*0.03,
                                        )
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ) ,
                        ),
                      );
                    },
                    separatorBuilder: (context,index){
                      return SizedBox(height: MediaQuery.of(context).size.height*0.01,);
                    },
                    itemCount: cubit.oxfordCoursesList.length,
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
