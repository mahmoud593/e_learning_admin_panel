import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class OpenVideo extends StatefulWidget {
  const OpenVideo({super.key});

  @override
  State<OpenVideo> createState() => _OpenVideoState();

}

class _OpenVideoState extends State<OpenVideo> {
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
      appBar: AppBar(
        leading: CloseButton(),
      ),
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height*0.03
          ),
          child: controller.value.isInitialized
              ? AspectRatio(
                aspectRatio: controller.value.aspectRatio/1.5,
                child: VideoPlayer(controller)

          )
              : Container(),
        )
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            controller.value.isPlaying
                ? controller.pause()
                : controller.play();
          });
        },
        child: Icon(
        controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),

    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
