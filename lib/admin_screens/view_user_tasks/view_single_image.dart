// import 'package:flutter/material.dart';
// import 'package:m2m/Presentation/styles/app_size_config.dart';
// import 'package:m2m/Presentation/styles/color_manager.dart';
// import 'package:photo_view/photo_view.dart';
//
// class ViewSingleImageScreen extends StatelessWidget {
//   final String image;
//   const ViewSingleImageScreen({Key? key, required this.image}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: SizeConfig.height,
//       width: SizeConfig.width,
//       color: ColorManager.white,
//       child: Expanded(
//         child: PhotoView(
//           imageProvider: NetworkImage(image),
//           initialScale: PhotoViewComputedScale.contained,
//           backgroundDecoration: BoxDecoration(
//             color: ColorManager.grey,
//           ),
//         ),
//       ),
//     );
//   }
// }
