import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/books/books_parts.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/cambridg_course/handouts/edit_handouts.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/cambridg_course/handouts/upload_handouts.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/lelts_course/handouts/upload_handouts.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/handouts/edit_handouts.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/handouts/upload_handouts.dart';
import 'package:e_learning_dathboard/admin_screens/open_pdf/open_pdf.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CambridgeMarkedAssignmentScreen extends StatefulWidget {
  final String title;
  const CambridgeMarkedAssignmentScreen({super.key,required this.title});

  @override
  State<CambridgeMarkedAssignmentScreen> createState() => _CambridgeHandoutsScreenState();
}

class _CambridgeHandoutsScreenState extends State<CambridgeMarkedAssignmentScreen> {

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getCambridgeCourses(section: 'mockExams',type: 'markedAssignments');
  }

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
                customPushNavigator(context, UploadCambridgeHandouts(section: 'mockExams',type: 'markedAssignments',));
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

                state is GetIeltsCoursesLoadingState?
                const Center(child: CircularProgressIndicator(),):
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          customPushNavigator(context, OpenPdf(
                            isImage: cubit.cambridgeCoursesList[index].isImage,
                            pdfUrl:cubit.cambridgeCoursesList[index].url
                            ,title: cubit.cambridgeCoursesList[index].title,
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
                                          horizontal: MediaQuery.of(context).size.height * .01,
                                        ),
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        height: MediaQuery.of(context).size.height * 0.1,
                                        width: MediaQuery.of(context).size.height * .1,
                                        decoration: BoxDecoration(
                                          color: ColorManager.white.withOpacity(.9),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: cubit.cambridgeCoursesList[index].url,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                          const Center(child: CupertinoActivityIndicator()),
                                          errorWidget: (context, url, error) {
                                            // حل مشكلة setState() داخل build
                                            WidgetsBinding.instance.addPostFrameCallback((_) {
                                              cubit.cambridgeCoursesList[index].isImage = false;
                                            });
                                            return SfPdfViewer.network(
                                              cubit.cambridgeCoursesList[index].url,
                                              canShowScrollStatus: false,      // يخفي رقم الصفحة
                                              canShowPaginationDialog: false,  // يمنع نافذة إدخال صفحة
                                              canShowScrollHead: false,        // يخفي scroll head
                                            );
                                          },
                                        ),
                                      ),


                                      /// sized box
                                      SizedBox(width: MediaQuery.of(context).size.height*0.02,),


                                      /// text
                                      Expanded(
                                        child: Text(
                                          cubit.cambridgeCoursesList[index].title,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.height*0.022,
                                              color: ColorManager.white
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed:()async{
                                            final courseTitle = 'Cambridge Course';
                                            final lectureName = cubit.oxfordCoursesList[index].title;
                                            final bookImageUrl = 'https://img.freepik.com/free-photo/english-books-with-red-background_23-2149440458.jpg?w=360&t=st=1703150045~exp=1703150645~hmac=38549c832725cef0920fc52fc2a15442b0f41c825fb24c92f7c44122af614ddd';
                                            final courseUrl = cubit.oxfordCoursesList[index].url;

                                            final message = '''
📚 *New Learning Opportunity!*
Course: $courseTitle
🎓 Lecture: $lectureName

Discover more about this course:
$courseUrl

📖 Book cover:
$bookImageUrl

Download the app now and explore all our courses:
📱 iOS: https://apps.apple.com/eg/app/english-with-dr-mohamed-ismail/id6740339979  
🤖 Android: https://play.google.com/store/apps/details?id=com.drismail.drismail
''';

                                            await Share.share(message);                                             } ,
                                          icon: Icon(Icons.share,
                                            color: ColorManager.white,
                                            size: MediaQuery.of(context).size.height*0.03,
                                          )
                                      )
                                    ]
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: (){
                                          cubit.deleteCambridgeCourses(
                                            type: 'markedAssignments',
                                            section: 'mockExams',
                                            uId: cubit.cambridgeCoursesList[index].uId,
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
                                          customPushNavigator(context, EditCambridgeHandouts(
                                            type: 'markedAssignments',
                                            uId: cubit.cambridgeCoursesList[index].uId,
                                            title: cubit.cambridgeCoursesList[index].title,
                                            url: cubit.cambridgeCoursesList[index].url,
                                            section: 'mockExams',
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
                    itemCount: cubit.cambridgeCoursesList.length,
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
