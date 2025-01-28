
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:flutter/material.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: WillPopScope(
          onWillPop: ()=> AppCubit.get(context).pausePlayer(context),
          child: ListView.separated(
              itemBuilder: (context,index){
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height*0.02,
                      horizontal: MediaQuery.of(context).size.height*0.02
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.08,
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
                            Text('Audio ${index+1}',style: TextStyle(
                              color: ColorManager.black,
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height*0.02,
                            )),
                            const Spacer(),
                            Container(
                              height: MediaQuery.of(context).size.height*0.04,
                              width: MediaQuery.of(context).size.height*0.04,
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
                                  size: MediaQuery.of(context).size.height*0.019
                                  ,
                                ),
                              ),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.height*0.05,),
                          ],
                        ),

                      ]
                  ),
                );
              },
              separatorBuilder: (context,index){
                return SizedBox(height: MediaQuery.of(context).size.height*0.01,);
              },
              itemCount: 2
          ),
        )
    );
  }
}
