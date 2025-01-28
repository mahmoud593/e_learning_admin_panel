// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
// import 'package:m2m/Data/core/local/cash_helper.dart';
// import 'package:m2m/Data/model/upload_task_model.dart';
// import 'package:m2m/Presentation/screens/admin_screens/view_user_tasks/view_user_tasks.dart';
// import 'package:m2m/Presentation/screens/admin_screens/view_user_tasks/widget/task_item_widget.dart';
// import 'package:m2m/Presentation/styles/app_size_config.dart';
// import 'package:m2m/Presentation/styles/color_manager.dart';
// import 'package:m2m/Presentation/styles/icon_broken.dart';
// import 'package:m2m/Presentation/widgets/default_button.dart';
// import 'package:m2m/Presentation/widgets/navigate_to.dart';
// import 'package:m2m/business_logic/app_localization.dart';
// import 'package:m2m/business_logic/tasks_cubit/tasks_cubit.dart';
// import 'package:m2m/business_logic/tasks_cubit/tasks_states.dart';
//
// class ViewTasksScreen extends StatelessWidget {
//   final String uId;
//   const ViewTasksScreen({Key? key, required this.uId}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context)=>TasksCubit()..getUsersUploadedTasks(userId: uId),
//       child: BlocConsumer<TasksCubit,TasksStates>(
//         listener: (context, state){},
//         builder: (context, state){
//
//           var cubit = TasksCubit.get(context);
//           List<UploadTaskModel> userTask = cubit.userUploadedTasks;
//
//           return Scaffold(
//             appBar: AppBar(
//               title: Text(
//                 AppLocalizations.of(context)!.translate('userTasks').toString(),
//                 style: TextStyle(
//                   fontSize: SizeConfig.headline2Size,
//                   fontWeight: FontWeight.bold,
//                   color: ColorManager.black,
//                 ),
//               ),
//               centerTitle: true,
//               leading: IconButton(
//                 icon: CashHelper.getData(key: CashHelper.languageKey).toString()=='en'?Icon(
//                   IconBroken.Arrow___Left_2,
//                   color: ColorManager.black,
//                 ):Icon(
//                   IconBroken.Arrow___Right_2,
//                   color: ColorManager.black,
//                 ),
//                 onPressed: (){
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//             body: cubit.userUploadedTasks.isNotEmpty ?
//             Column(
//               children: [
//                 Expanded(
//                   child: state is GetUserUploadedTaskSuccessState? ListView.separated(
//                     itemBuilder: (context,index){
//                       return TaskViewWidget(index: index, taskModel: userTask[index],);
//                     },
//                     separatorBuilder: (context,index)=>Container(),
//                     itemCount: userTask.length,
//                   ): const Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 ),
//               ],
//             ):
//             Container(
//               height: SizeConfig.height,
//               color: ColorManager.white,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: SizeConfig.height*0.03,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Lottie.asset("assets/images/empty.json"),
//                     SizedBox(
//                       height: SizeConfig.height*0.02,
//                     ),
//                     Text(
//                       AppLocalizations.of(context)!.translate('userTasksIsEmpty').toString(),
//                       style: GoogleFonts.roboto(
//                         fontSize: SizeConfig.headline3Size,
//                         color: ColorManager.secondDarkColor,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(
//                       height: SizeConfig.height*0.1,
//                     ),
//                     DefaultButton(
//                       text: AppLocalizations.of(context)!.translate('backToHome').toString(),
//                       onPressed: ()=>navigateAndRemove(context, const ViewUserTasksScreen()),
//                       color: ColorManager.secondDarkColor,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
