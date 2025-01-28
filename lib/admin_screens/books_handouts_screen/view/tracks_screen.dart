

import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';

class TracksScreen extends StatefulWidget {
  const TracksScreen({super.key});

  @override
  State<TracksScreen> createState() => _TracksScreenState();
}

class _TracksScreenState extends State<TracksScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:  Text('Tracks',style: TextStyle(
          color: ColorManager.black,
          fontSize: MediaQuery.sizeOf(context).height*.025,
          fontWeight: FontWeight.w600,
        ),),
      ),
      body: WillPopScope(
        onWillPop: ()=> AppCubit.get(context).pausePlayer(context),
        child: Container(
          child: ListView.separated(
              itemBuilder: (context,index){
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.sizeOf(context).height*0.02,
                      horizontal: MediaQuery.sizeOf(context).height*0.02
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                                Icons.audio_file
                            ),
                            Text('Listen Sound of Tracks',style: TextStyle(
                              color: ColorManager.black,
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.sizeOf(context).height*0.022,
                            )),
                          ],
                        ),
                        SizedBox(height: MediaQuery.sizeOf(context).height*0.03,),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: MediaQuery.sizeOf(context).height*0.06,
                            width: MediaQuery.sizeOf(context).height*0.06,
                            decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: IconButton(
                              onPressed: (){
                                // AppCubit.get(context).test==''?
                                // AppCubit.get(context).audioPlayerFunction(url: 'https://firebasestorage.googleapis.com/v0/b/elearningapp-4adde.appspot.com/o/mixkit-classic-alarm-995.wav?alt=media&token=abb9b36e-0992-4df5-a818-b0fe1cbc8cff').then((value) {
                                //   setState(() {
                                //     AppCubit.get(context).test='1';
                                //   });
                                // }) :
                                // AppCubit.get(context).test=='0'?
                                // AppCubit.get(context).player.resume().then((value) {
                                //   setState(() {
                                //     AppCubit.get(context).test='1';
                                //   });
                                // }):
                                // AppCubit.get(context).player.pause().then((value) {
                                //   setState(() {
                                //     AppCubit.get(context).test='0';
                                //   });
                                // });

                              },
                              icon:  Icon(
                                AppCubit.get(context).test=='0'|| AppCubit.get(context).test==''? Icons.play_arrow_sharp:Icons.stop,
                                color: ColorManager.white,
                                size: MediaQuery.sizeOf(context).height*0.03,
                              ),
                            ),
                          ),
                        ),

                      ]
                  ),
                );
              },
              separatorBuilder: (context,index){
                return SizedBox(height: MediaQuery.sizeOf(context).height*0.01,);
              },
              itemCount: 3
          ),
        ),
      )
    );
  }
}
