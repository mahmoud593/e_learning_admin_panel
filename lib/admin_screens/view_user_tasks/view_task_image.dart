// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:m2m/Data/core/local/cash_helper.dart';
// import 'package:m2m/Data/model/upload_task_model.dart';
// import 'package:m2m/Presentation/screens/admin_screens/view_user_tasks/widget/grid_image_widget.dart';
// import 'package:m2m/Presentation/styles/app_size_config.dart';
// import 'package:m2m/Presentation/styles/color_manager.dart';
// import 'package:m2m/Presentation/styles/icon_broken.dart';
// import 'package:m2m/Presentation/widgets/default_button.dart';
// import 'package:m2m/business_logic/app_localization.dart';
// import 'package:m2m/business_logic/tasks_cubit/tasks_cubit.dart';
// import 'package:m2m/business_logic/tasks_cubit/tasks_states.dart';
//
// class ViewTaskImagesScreen extends StatelessWidget {
//   final UploadTaskModel taskModel;
//   const ViewTaskImagesScreen({Key? key,  required this.taskModel}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<TasksCubit,TasksStates>(
//       listener: (context,state){},
//       builder: (context,state){
//         var cubit = TasksCubit.get(context);
//
//         return Scaffold(
//           appBar: AppBar(
//             title: Text(
//               AppLocalizations.of(context)!.translate('uploadTaskImage').toString(),
//               style: TextStyle(
//                 fontSize: SizeConfig.headline2Size,
//                 fontWeight: FontWeight.bold,
//                 color: ColorManager.black,
//               ),
//             ),
//             centerTitle: true,
//             leading: IconButton(
//               icon: CashHelper.getData(key: CashHelper.languageKey).toString()=='en'?Icon(
//                 IconBroken.Arrow___Left_2,
//                 color: ColorManager.black,
//               ):Icon(
//                 IconBroken.Arrow___Right_2,
//                 color: ColorManager.black,
//               ),
//               onPressed: (){
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//           body: Padding(
//             padding: EdgeInsets.symmetric(
//               vertical :SizeConfig.height*0.02,
//               horizontal :SizeConfig.height*0.03,
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//
//                 // image grid view
//                 Expanded(
//                   child: GridView.builder(
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                     ),
//                     itemBuilder: (context,index){
//                       return GridImageWidget(image: taskModel.taskImages[index],);
//                     },
//                     itemCount: taskModel.taskImages.length,
//                   ),
//                 ),
//
//                 // upload task button
//                 state is ConfirmTaskLoadingState?
//                 const CircularProgressIndicator(
//                   color: ColorManager.primary,
//                 ):DefaultButton(
//                   text: AppLocalizations.of(context)!.translate('accept').toString(),
//                   color: ColorManager.secondDarkColor,
//                   onPressed: (){
//                     cubit.confirmTask(taskModel: taskModel, context: context);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
