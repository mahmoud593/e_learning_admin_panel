// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:m2m/Data/model/upload_task_model.dart';
// import 'package:m2m/Presentation/screens/admin_screens/view_user_tasks/view_task_image.dart';
// import 'package:m2m/Presentation/styles/app_size_config.dart';
// import 'package:m2m/Presentation/styles/color_manager.dart';
// import 'package:m2m/Presentation/widgets/navigate_to.dart';
// import 'package:m2m/business_logic/app_localization.dart';
//
// class TaskViewWidget extends StatelessWidget {
//   final int index;
//   final UploadTaskModel taskModel;
//   const TaskViewWidget({Key? key, required this.index, required this.taskModel}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  InkWell(
//       onTap: ()=>navigateAndRemove(context, ViewTaskImagesScreen(taskModel: taskModel)),
//       child: Padding(
//         padding: EdgeInsets.all(
//           SizeConfig.height*0.02,
//         ),
//         child: Container(
//           padding: EdgeInsets.all(
//             SizeConfig.height*0.02,
//           ),
//           decoration: BoxDecoration(
//             color: ColorManager.secondDarkColor,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Text(
//             "${AppLocalizations.of(context)!.translate('task').toString()} ${index+1}",
//             style: GoogleFonts.roboto(
//               fontSize: SizeConfig.headline3Size,
//               color: ColorManager.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
