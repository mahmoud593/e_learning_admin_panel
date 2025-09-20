import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/speaking/oxford_speaking_tabs/oxford_video_screen/play_video_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/speaking/oxford_speaking_tabs/oxford_video_screen/upload_oxford_video.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/speaking/oxford_speaking_tabs/oxford_video_screen/view_comments_screen.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:typed_data';

class OxfordVideoScreen extends StatefulWidget {
  const OxfordVideoScreen({super.key});

  @override
  State<OxfordVideoScreen> createState() => _OxfordVideoScreenState();
}

class _OxfordVideoScreenState extends State<OxfordVideoScreen> {
  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getOxfordVideoSpeakingCourses();
  }

  Future<Uint8List?> generateThumbnail(String videoUrl) async {
    try {
      final uint8list = await VideoThumbnail.thumbnailData(
        video: videoUrl,
        imageFormat: ImageFormat.PNG,
        maxWidth: 256,
        quality: 50,
      );
      return uint8list;
    } catch (e) {
      debugPrint("❌ Error generating thumbnail: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          customPushNavigator(context,  VideoOxfordUploadScreen());
        },
        label: Row(
          children: [
            Icon(Icons.upload, size: MediaQuery.sizeOf(context).height * 0.03),
            SizedBox(width: MediaQuery.sizeOf(context).height * 0.01),
            Text(
              'Upload Video',
              style: TextStyle(fontSize: MediaQuery.sizeOf(context).height * 0.02),
            ),
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: () => AppCubit.get(context).pausePlayer(context),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);

            if (state is GetOxfordCoursesLoadingState) {
              return Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            }

            return ListView.separated(
              itemCount: cubit.oxfordVideoCoursesList.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              itemBuilder: (context, index) {
                final video = cubit.oxfordVideoCoursesList[index];

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
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ✅ Thumbnail
                        FutureBuilder<Uint8List?>(
                          future: generateThumbnail(video.url),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Container(
                                height: 200,
                                color: Colors.grey[200],
                                child: const Center(child: CircularProgressIndicator()),
                              );
                            }
                            if (snapshot.hasError || snapshot.data == null) {
                              return Container(
                                height: 200,
                                width: double.infinity,
                                color: Colors.grey[300],
                                child: const Icon(Icons.broken_image, size: 50),
                              );
                            }
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.memory(
                                  snapshot.data!,
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    customPushNavigator(
                                      context,
                                      VideoPlayerScreen(
                                        videoUrl: video.url,
                                        videoTitle: video.title,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: const Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                        // ✅ Title & Share
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.02),
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
                          child: Row(
                            children: [
                              Icon(Icons.video_collection_rounded,
                                  color: ColorManager.primary,
                                  size: MediaQuery.sizeOf(context).height * 0.025),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  video.title,
                                  style: TextStyle(
                                    color: ColorManager.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: MediaQuery.sizeOf(context).height * 0.022,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  final message = '''
📚 *New Learning Opportunity!*
Course: Oxford Course
🎓 Lecture: ${video.title}

Discover more about this course:
${video.url}
''';
                                  await Share.share(message);
                                },
                                icon: Icon(Icons.share_rounded, color: ColorManager.primary),
                                tooltip: 'مشاركة',
                              ),
                            ],
                          ),
                        ),

                        // ✅ Actions (Delete & Comments)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.sizeOf(context).height * 0.02,
                            vertical: MediaQuery.sizeOf(context).height * 0.015,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Delete button
                              IconButton(
                                onPressed: () {
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
                                            cubit.deleteOxfordVideoSpeakingCourses(uId: video.uId);
                                          },
                                          child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.delete_rounded, color: Colors.red),
                                tooltip: 'حذف',
                              ),

                              // Comments button
                              IconButton(
                                onPressed: () {
                                  cubit.getOxfordVideoComments(uId: video.uId).then((value) {
                                    customPushNavigator(
                                      context,
                                      StudentCommentsScreen(videoTitle: video.title, videoUid: video.uId),
                                    );
                                  });
                                },
                                icon: Icon(Icons.comment_rounded, color: ColorManager.primary),
                                tooltip: 'عرض التعليقات',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
