// import 'package:flutter/material.dart';
// import 'package:m2m/Data/model/payment_model.dart';
// import 'package:m2m/Data/model/admin_task_model.dart';
// import 'package:m2m/Data/model/upload_task_model.dart';
// import 'package:m2m/Data/model/user_model.dart';
// import 'package:m2m/Presentation/screens/admin_screens/payment_screens/confirm_payment_screen.dart';
// import 'package:m2m/Presentation/screens/admin_screens/view_user_tasks/view_tasks_screen.dart';
// import 'package:m2m/Presentation/styles/app_size_config.dart';
// import 'package:m2m/Presentation/styles/assets_manager.dart';
// import 'package:m2m/Presentation/styles/color_manager.dart';
// import 'package:m2m/Presentation/widgets/navigate_to.dart';
// import 'package:m2m/Presentation/widgets/text_manager.dart';
//
// class ViewTasksListItem extends StatelessWidget {
//   final UserModel userModel;
//   const ViewTasksListItem({Key? key, required this.userModel}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: ()=>navigateAndRemove(context, ViewTasksScreen(uId: userModel.uId)),
//       child: Padding(
//         padding: EdgeInsets.all(
//             SizeConfig.height*.02
//         ),
//         child: Material(
//           elevation: 2,
//           borderRadius: BorderRadius.circular(12),
//           child: Container(
//             padding: EdgeInsets.all(
//               SizeConfig.height*.02,
//             ),
//             decoration: BoxDecoration(
//               color: ColorManager.secondDarkColor,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     userModel.profileImage =="null"? const CircleAvatar(
//                       backgroundImage: AssetImage(AssetsManager.userImage),
//                       radius: 35,
//                     ) : CircleAvatar(
//                       backgroundImage: NetworkImage(userModel.profileImage.toString()),
//                       radius: 35,
//                     ),
//                     SizedBox(width: SizeConfig.height*.01,),
//                     Expanded(
//                       child: Text(
//                         userModel.username.toString(),
//                         style: textManager(color: Colors.white),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: SizeConfig.height*.02,),
//                 rowData(title: 'Phone', data:  userModel.phone.toString()),
//
//                 SizedBox(height: SizeConfig.height*.02,),
//                 rowData(title: 'Package Name', data: userModel.package.packageName.toString()),
//
//                 SizedBox(height: SizeConfig.height*.02,),
//                 rowData(title: 'Package Id', data: userModel.package.packageId.toString()),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget rowData ({required String title , required String data}){
//     return Row(
//       children: [
//         Text(
//           '$title : ',
//           style: textManager(color: ColorManager.primary),
//           overflow: TextOverflow.ellipsis,
//         ),
//
//         Expanded(
//           child: Text(
//             data,
//             style: textManager(color: Colors.white,fontSize: SizeConfig.height*.02),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
//
// }
