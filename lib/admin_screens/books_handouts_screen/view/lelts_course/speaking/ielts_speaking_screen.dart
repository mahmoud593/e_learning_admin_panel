
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/speaking_tabs/audioScreen/audio.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/speaking_tabs/pdf/pdf.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/speaking_tabs/videoes/videoes.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/lelts_course/speaking/ielts_speaking_tabs/audioScreen/audio.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/lelts_course/speaking/ielts_speaking_tabs/pdf/pdf.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:flutter/material.dart';

class IeltsSpeakingScreen extends StatelessWidget {
  const IeltsSpeakingScreen({super.key});

  static bool pinned = true;
  static bool snap = false;
  static bool floating = false;
  static var searchController = TextEditingController();
  static var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          /// appbar
          appBar: AppBar(
              title: Text('Speaking',
                  style: TextStyle(
                    fontSize:  MediaQuery.sizeOf(context).height*0.025,
                    color: ColorManager.black
                  )),
              backgroundColor: ColorManager.white,
              titleSpacing: 0.0,
              bottom: TabBar(
                  indicatorColor: ColorManager.primary,
                  unselectedLabelColor: ColorManager.grey,
                  labelColor: ColorManager.primary,
                  tabs: [
                    Tab(
                        child: Text('Audio',
                            style: TextStyle(
                              fontSize:  MediaQuery.sizeOf(context).height*0.02,
                            ))),
                    Tab(
                        child: Text('PDF',
                            style: TextStyle(
                              fontSize:  MediaQuery.sizeOf(context).height*0.02,
                            ))),
                  ])),

          /// tabview
          body:TabBarView(
            children: [
              IeltsAudioScreen(),
              IeltsPdfSpeakerScreen(),
            ],
          )),
    );
  }
}
