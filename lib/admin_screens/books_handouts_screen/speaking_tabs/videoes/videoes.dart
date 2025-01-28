
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/speaking_tabs/videoes/open_video.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();

}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController controller;


  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/elearningapp-4adde.appspot.com/o/pexels_videos_4409%20(360p).mp4?alt=media&token=ca044baa-0387-4c38-9941-0db7b059c303'))
      ..initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
            itemBuilder: (context, index){
              return InkWell(
                onTap: (){

                  customPushNavigator(context, const OpenVideo());

                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height*0.3,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height*0.03
                    ),
                    child: controller.value.isInitialized
                        ? AspectRatio(
                          aspectRatio:controller.value.aspectRatio,
                          child: VideoPlayer(controller
                        ),
                    )
                        : Container(),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index){
              return SizedBox(height: MediaQuery.of(context).size.height*0.02,);
            },
            itemCount: 4
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    dispose();
  }
}
