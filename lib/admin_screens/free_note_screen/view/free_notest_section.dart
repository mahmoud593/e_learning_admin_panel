//
// import 'package:e_learning_dathboard/admin_screens/free_note_screen/view/material_screen.dart';
// import 'package:e_learning_dathboard/constants/constants.dart';
// import 'package:e_learning_dathboard/widgets/navigate_to.dart';
// import 'package:flutter/material.dart';
//
// import '../../../styles/color_manager.dart';
//
// class FreeNoteSectionScreen extends StatelessWidget {
//   const FreeNoteSectionScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: InkWell(
//           onTap: ()=>Navigator.pop(context),
//           child: Icon(
//             Icons.arrow_back,
//             color: ColorManager.black,
//             size: MediaQuery.of(context).size.height*0.03,
//           ),
//         ),
//         title: Text(
//           'Free Notes Section',
//           style: TextStyle(
//             color: ColorManager.black,
//             fontSize: MediaQuery.of(context).size.height*0.025,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         backgroundColor: ColorManager.white,
//       ),
//       body: Padding(
//         padding: EdgeInsets.only(
//             left: MediaQuery.of(context).size.height*0.02,
//             right: MediaQuery.of(context).size.height*0.02,
//             bottom: MediaQuery.of(context).size.height*0.02
//         ),
//         child: Column(
//           children: [
//
//             Expanded(
//               child: ListView.separated(
//                 itemBuilder: (context,index){
//                   return GestureDetector(
//                     onTap: (){
//                       if(index==0){
//                         navigateTo(context,  const MaterialScreen(
//                           title: 'Pdf',
//                           image: 'assets/images/pdf.png',
//                         ));
//                       }
//                       else if(index==1){
//                         navigateTo(context,  const MaterialScreen(
//                           title: 'Audio',
//                           image: 'assets/images/audio.png',
//                         ));
//                       }
//                       else{
//                         navigateTo(context,  const MaterialScreen(
//                           title: 'Video',
//                           image: 'assets/images/video.png',
//                         ));
//                       }
//
//                     },
//                     child: Container(
//                       height: MediaQuery.of(context).size.height*0.1,
//                       width: MediaQuery.of(context).size.width,
//                       alignment: Alignment.center,
//
//                       decoration: BoxDecoration(
//                         color: ColorManager.primary,
//                         borderRadius: BorderRadius.circular(
//                             MediaQuery.of(context).size.height*0.02
//                         ),
//                       ),
//
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.02),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               freeMaterialsSections[index],
//                               style: TextStyle(
//                                 color: ColorManager.white,
//                                 fontSize: MediaQuery.of(context).size.height*0.02,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             Icon(
//                               Icons.arrow_forward,
//                               color: ColorManager.white,
//                               size: MediaQuery.of(context).size.height*0.03,
//                             ),
//                           ],
//                         ),
//                       ),
//
//                     ),
//                   );
//                 },
//                 separatorBuilder: (context,index){
//                   return SizedBox(height: MediaQuery.of(context).size.height*0.01,);
//                 },
//                 itemCount: freeMaterialsSections.length,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
