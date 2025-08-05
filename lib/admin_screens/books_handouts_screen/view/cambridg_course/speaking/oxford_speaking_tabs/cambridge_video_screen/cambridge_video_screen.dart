import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/cambridg_course/speaking/oxford_speaking_tabs/cambridge_video_screen/combridge_comments_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/cambridg_course/speaking/oxford_speaking_tabs/cambridge_video_screen/upload_cambridge_video.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/lelts_course/speaking/ielts_speaking_tabs/ielts_video_screen/upload_ielts_video.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/lelts_course/speaking/ielts_speaking_tabs/pdf/upload_ielts_speacking.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/lelts_course/tracks/upload_tracks.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/speaking/edit_oxford_speacking.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/speaking/oxford_speaking_tabs/oxford_pdf/upload_oxford_speacking.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/speaking/oxford_speaking_tabs/oxford_video_screen/play_video_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/speaking/oxford_speaking_tabs/oxford_video_screen/upload_oxford_video.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class CambridgeVideoScreen extends StatefulWidget {
  const CambridgeVideoScreen({super.key});

  @override
  State<CambridgeVideoScreen> createState() => _TracksScreenState();
}

class _TracksScreenState extends State<CambridgeVideoScreen> {
  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getCambridgeVideoSpeakingCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              customPushNavigator(context, VideoCambridgeUploadScreen());
            },
            label: Row(
              children: [
                Icon(
                  Icons.upload,
                  size: MediaQuery.sizeOf(context).height * 0.03,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).height * 0.01,
                ),
                Text(
                  'Upload Video',
                  style: TextStyle(
                      fontSize: MediaQuery.sizeOf(context).height * 0.02),
                )
              ],
            )
        ),
        body: WillPopScope(
            onWillPop: () => AppCubit.get(context).pausePlayer(context),
            child: BlocConsumer<AppCubit,AppStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  var cubit = AppCubit.get(context);
                  return state is GetIeltsCoursesLoadingState?
                  Center(child: CircularProgressIndicator(color: ColorManager.primary,),) :
                  Container(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Header section with gradient background
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          ColorManager.primary.withOpacity(0.1),
                                          ColorManager.primary.withOpacity(0.05),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    padding: EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.02),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Title and share section
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: ColorManager.primary.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Icon(
                                                Icons.video_collection_rounded,
                                                color: ColorManager.primary,
                                                size: MediaQuery.sizeOf(context).height * 0.025,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    cubit.cambridgeVideoCoursesList[index].title,
                                                    style: TextStyle(
                                                      color: ColorManager.black,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: MediaQuery.sizeOf(context).height * 0.022,
                                                      height: 1.3,
                                                    ),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.8),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: IconButton(
                                                onPressed: () async {
                                                  await Share.share(
                                                    'شاهد هذا الفيديو : ${cubit.cambridgeVideoCoursesList[index].title} \n ${cubit.cambridgeVideoCoursesList[index].url}',
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.share_rounded,
                                                  color: ColorManager.primary,
                                                  size: MediaQuery.of(context).size.height * 0.025,
                                                ),
                                                tooltip: 'مشاركة',
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: MediaQuery.sizeOf(context).height * 0.025),

                                        // Play button section
                                        Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              customPushNavigator(
                                                context,
                                                VideoPlayerScreen(
                                                  videoUrl: cubit.cambridgeVideoCoursesList[index].url,
                                                  videoTitle: cubit.cambridgeVideoCoursesList[index].title,
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: MediaQuery.sizeOf(context).height * 0.07,
                                              width: MediaQuery.sizeOf(context).height * 0.07,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    ColorManager.primary,
                                                    ColorManager.primary.withOpacity(0.8),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                                borderRadius: BorderRadius.circular(35),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: ColorManager.primary.withOpacity(0.3),
                                                    blurRadius: 12,
                                                    offset: const Offset(0, 4),
                                                  ),
                                                ],
                                              ),
                                              child: Icon(
                                                Icons.play_arrow_rounded,
                                                color: ColorManager.white,
                                                size: MediaQuery.sizeOf(context).height * 0.035,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Action buttons section
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: MediaQuery.sizeOf(context).height * 0.02,
                                      vertical: MediaQuery.sizeOf(context).height * 0.015,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Delete button
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              // Show confirmation dialog
                                              showDialog(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                  title: const Text('Delete Video'),
                                                  content: const Text('Are you sure you want to delete this video?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () => Navigator.pop(context),
                                                      child: const Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        cubit.deleteCambridgeVideoSpeakingCourses(
                                                          uId: cubit.cambridgeVideoCoursesList[index].uId,
                                                        );
                                                      },
                                                      child: const Text('Delete',style: TextStyle(color: Colors.red),),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.delete_rounded,
                                              color: Colors.red,
                                              size: MediaQuery.of(context).size.height * 0.025,
                                            ),
                                            tooltip: 'حذف',
                                          ),
                                        ),

                                        Spacer(),

                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              // Show confirmation dialog
                                              cubit.getcambridgeVideoComments(uId:  cubit.cambridgeVideoCoursesList[index].uId, ).then((value) {
                                                customPushNavigator(context, CombridgeCommentsScreen(videoTitle: cubit.cambridgeVideoCoursesList[index].title,videoUid:cubit.cambridgeVideoCoursesList[index].uId ,));
                                              });
                                            },
                                            icon: Icon(
                                              Icons.comment_rounded,
                                              color: ColorManager.primary,
                                              size: MediaQuery.of(context).size.height * 0.025,
                                            ),
                                            tooltip: 'عرض التعليقات',
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.01,
                          );
                        },
                        itemCount: cubit.cambridgeVideoCoursesList.length),
                  );
                })));
  }
}
