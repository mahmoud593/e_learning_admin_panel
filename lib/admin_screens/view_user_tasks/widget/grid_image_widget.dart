// import 'package:flutter/material.dart';
// import 'package:m2m/Presentation/screens/admin_screens/view_user_tasks/view_single_image.dart';
// import 'package:m2m/Presentation/styles/app_size_config.dart';
// import 'package:m2m/Presentation/styles/color_manager.dart';
// import 'package:m2m/Presentation/widgets/navigate_to.dart';
//
// class GridImageWidget extends StatelessWidget {
//   final String image;
//   const GridImageWidget({Key? key, required this.image}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: ()=>navigateTo(context, ViewSingleImageScreen(image: image)),
//       child: Padding(
//         padding: EdgeInsets.all(
//           SizeConfig.height*0.01,
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: ColorManager.lightGrey2,
//           ),
//           child: Material(
//             borderRadius: BorderRadius.circular(10),
//             clipBehavior: Clip.antiAliasWithSaveLayer,
//             child: Image(
//               image: NetworkImage(image),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
