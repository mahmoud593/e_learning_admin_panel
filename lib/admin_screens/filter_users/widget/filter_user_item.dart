// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:m2m/Data/model/user_model.dart';
// import 'package:m2m/Presentation/styles/app_size_config.dart';
// import 'package:m2m/Presentation/styles/color_manager.dart';
// import 'package:m2m/Presentation/widgets/text_manager.dart';
// import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
// import 'package:m2m/business_logic/app_cubit/app_states.dart';
//
// class FilterUserItem extends StatefulWidget {
//   final int index;
//   final UserModel userModel;
//   const FilterUserItem({Key? key,required this.index,required this.userModel}) : super(key: key);
//
//   @override
//   State<FilterUserItem> createState() => _FilterUserItemState();
// }
//
// class _FilterUserItemState extends State<FilterUserItem> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit,AppStates>(
//       builder: (context,state){
//         var cubit=AppCubit.get(context);
//         return Container(
//           margin: EdgeInsets.symmetric(
//             horizontal: SizeConfig.height*.02,
//           ),
//           child:SizedBox(
//             height: SizeConfig.height*.19,
//             child: Material(
//               elevation: 2,
//               color: ColorManager.primary.withOpacity(.7),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Container(
//                 padding: EdgeInsets.only(
//                   left: SizeConfig.height*.02,
//                   right: SizeConfig.height*.02,
//                   top: SizeConfig.height*.02,
//                   bottom: SizeConfig.height*.02,
//                 ),
//
//                 decoration: BoxDecoration(
//                   color: ColorManager.black.withOpacity(.8),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//
//                         // name
//                         Expanded(
//                           child: Text(widget.userModel.username,
//                             style: textManager(
//                                 color: ColorManager.white,
//                                 fontWeight: FontWeight.w500
//                             ),
//                           ),
//                         ),
//
//                         // select icon
//                         GestureDetector(
//                             onTap: (){
//                               setState(() {
//                                 cubit.isUserSelected[widget.index] = !cubit.isUserSelected[widget.index];
//                               });
//                               if(cubit.isUserSelected[widget.index]==true){
//                                 cubit.usersId.add(widget.userModel.uId);
//                               }
//                               else{
//                                 cubit.usersId.remove(widget.userModel.uId);
//                               }
//                             },
//                             child: cubit.isUserSelected[widget.index]==false? SvgPicture.asset('assets/images/un_checked_remember_icon.svg',color: ColorManager.primary,height: SizeConfig.height*.023,)
//                                 :SvgPicture.asset('assets/images/checked_remember_me_icon.svg',color: ColorManager.primary,height: SizeConfig.height*.023,)
//                         )
//
//
//                       ],
//                     ),
//
//                     SizedBox(height:SizeConfig.height*.01,),
//                     Row(
//                       children: [
//
//                         // government
//                         Expanded(
//                           child: Text(widget.userModel.government,
//                             style: textManager(
//                                 color: ColorManager.white,
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: SizeConfig.height*.02
//                             ),
//                           ),
//                         ),
//
//                         // code
//                         Text('2155',
//                           style: textManager(
//                               color: ColorManager.primary,
//                               fontWeight: FontWeight.w700,
//                               fontSize: SizeConfig.height*.025
//                           ),
//                         ),
//
//                       ],
//                     ),
//                     SizedBox(height:SizeConfig.height*.01,),
//
//                     // Package
//
//                     Row(
//                       children: [
//
//                         Text('Package ',
//                           style: textManager(
//                               color: ColorManager.white,
//                               fontWeight: FontWeight.w400,
//                               fontSize: SizeConfig.height*.02
//                           ),
//                         ),
//
//                         SizedBox(width: SizeConfig.height*.03,),
//
//                         Text('${widget.userModel.package.packageId} \$',
//                           style: textManager(
//                               color: ColorManager.primary,
//                               fontWeight: FontWeight.w700,
//                               fontSize: SizeConfig.height*.025
//                           ),
//                         ),
//
//
//                       ],
//                     ),
//
//                     SizedBox(height:SizeConfig.height*.01,),
//
//                     // skills
//                     Align(
//                       alignment: AlignmentDirectional.topStart,
//                       child:Row(
//                         children: [
//
//                           //user skill 1
//                           if(widget.userModel.userSkill1!='')
//                             Text('${widget.userModel.userSkill1} -',
//                             style: textManager(
//                                 color: ColorManager.white,
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: SizeConfig.height*.02
//                             )),
//
//                           //user skill 2
//                           if(widget.userModel.userSkill2!='')
//                             Text('${widget.userModel.userSkill2} -',
//                                 style: textManager(
//                                     color: ColorManager.white,
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: SizeConfig.height*.02
//                                 )),
//
//                           //user skill 3
//                           if(widget.userModel.userSkill3!='')
//                             Text('${widget.userModel.userSkill3} -',
//                                 style: textManager(
//                                     color: ColorManager.white,
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: SizeConfig.height*.02
//                                 )),
//
//                           //user skill 4
//                           if(widget.userModel.userSkill4!='')
//                             Text('${widget.userModel.userSkill4} -',
//                                 style: textManager(
//                                     color: ColorManager.white,
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: SizeConfig.height*.02
//                                 )),
//
//                           //user skill 5
//                           if(widget.userModel.userSkill5!='')
//                             Text('${widget.userModel.userSkill5} -',
//                                 style: textManager(
//                                     color: ColorManager.white,
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: SizeConfig.height*.02
//                                 )),
//
//                           //user skill 6
//                           if(widget.userModel.userSkill6!='')
//                             Text('${widget.userModel.userSkill6} -',
//                                 style: textManager(
//                                     color: ColorManager.white,
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: SizeConfig.height*.02
//                                 )),
//
//                           //user skill 7
//                           if(widget.userModel.userSkill7!='')
//                             Text('${widget.userModel.userSkill7} -',
//                                 style: textManager(
//                                     color: ColorManager.white,
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: SizeConfig.height*.02
//                                 )),
//
//                           //user skill 8
//                           if(widget.userModel.userSkill8!='')
//                             Text('${widget.userModel.userSkill8} -',
//                                 style: textManager(
//                                     color: ColorManager.white,
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: SizeConfig.height*.02
//                                 )),
//
//                         ],
//                       )
//                       ),
//
//
//
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//         );
//
//       },
//       listener: (context,state){
//
//       },
//     );
//   }
// }