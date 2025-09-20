import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/lelts_course/tracks/edit_ilets_track.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/lelts_course/tracks/upload_tracks.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/tracks/edit_track.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class IeltsTracksScreen extends StatefulWidget {
  const IeltsTracksScreen({super.key});

  @override
  State<IeltsTracksScreen> createState() => _TracksScreenState();
}

class _TracksScreenState extends State<IeltsTracksScreen> {
  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getIeltsCourses(section: 'tracks');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Tracks',
            style: TextStyle(
              color: ColorManager.black,
              fontSize: MediaQuery.sizeOf(context).height * .025,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              customPushNavigator(context, UploadTracks(section: 'tracks'));
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
                  'Upload Track',
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
                            margin: const EdgeInsets.all(10),
                            padding: EdgeInsets.symmetric(
                                vertical:
                                MediaQuery.sizeOf(context).height * 0.02,
                                horizontal:
                                MediaQuery.sizeOf(context).height * 0.02),
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
                                      const Icon(Icons.audio_file),
                                      Text(cubit.ieltsCoursesList[index].title,
                                          style: TextStyle(
                                            color: ColorManager.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: MediaQuery.sizeOf(context)
                                                .height *
                                                0.022,
                                          )),
                                      const Spacer(),
                                      IconButton(
                                          onPressed:()async{
                                            final courseTitle = 'IELTS Course';
                                            final lectureName = cubit.ieltsCoursesList[index].title;
                                            final bookImageUrl = 'https://img.freepik.com/free-photo/english-books-with-red-background_23-2149440458.jpg?w=360&t=st=1703150045~exp=1703150645~hmac=38549c832725cef0920fc52fc2a15442b0f41c825fb24c92f7c44122af614ddd';
                                            final courseUrl = cubit.ieltsCoursesList[index].url;

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

                                            await Share.share(message);
                                          } ,
                                          icon: Icon(Icons.share,
                                            color: ColorManager.primary,
                                            size: MediaQuery.of(context).size.height*0.03,
                                          )
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.03,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height:
                                      MediaQuery.sizeOf(context).height *
                                          0.06,
                                      width: MediaQuery.sizeOf(context).height *
                                          0.06,
                                      decoration: BoxDecoration(
                                        color: ColorManager.primary,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          AppCubit.get(context).ieltsTracksBool[index]==0 ?
                                          AppCubit.get(context).audioPlayerFunction(
                                            index: index,
                                              url: cubit.ieltsCoursesList[index].url).then((value) {
                                            setState(() {
                                              AppCubit.get(context).ieltsTracksBool[index]=1;
                                            });
                                          }) : AppCubit.get(context).ieltsTracksBool[index] == 2 ?
                                          AppCubit.get(context).audioPlayerFunction(
                                              index: index,
                                              url: cubit.ieltsCoursesList[index].url).then((value) {
                                            setState(() {
                                              AppCubit.get(context).ieltsTracksBool[index]=1;
                                            });
                                          }) : AppCubit.get(context).player.pause().then((value) {
                                            setState(() {
                                              AppCubit.get(context).ieltsTracksBool[index]=2;
                                            });
                                          });
                                        },
                                        icon: Icon(
                                          AppCubit.get(context).ieltsTracksBool[index]!=1 ?
                                          Icons.play_arrow_sharp : Icons.stop,
                                          color: ColorManager.white,
                                          size: MediaQuery.sizeOf(context).height * 0.03,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: (){
                                            cubit.deleteIeltsCourses(
                                              section: 'tracks',
                                              uId: cubit.ieltsCoursesList[index].uId,
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
                                            customPushNavigator(context, EditIeltsTrack(
                                              uId: cubit.ieltsCoursesList[index].uId,
                                              title: cubit.ieltsCoursesList[index].title,
                                              url: cubit.ieltsCoursesList[index].url,
                                              section: 'tracks',
                                            ));
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: ColorManager.primary,
                                            size: MediaQuery.of(context).size.height*0.03,
                                          )
                                      ),
                                    ],
                                  )
                                ]),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.01,
                          );
                        },
                        itemCount: cubit.ieltsCoursesList.length),
                  );
                })));
  }
}
