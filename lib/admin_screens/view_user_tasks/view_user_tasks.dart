// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:m2m/Data/core/local/cash_helper.dart';
// import 'package:m2m/Data/model/user_model.dart';
// import 'package:m2m/Presentation/screens/admin_screens/view_user_tasks/widget/view_tasks_list_item.dart';
// import 'package:m2m/Presentation/styles/app_size_config.dart';
// import 'package:m2m/Presentation/styles/color_manager.dart';
// import 'package:m2m/Presentation/styles/icon_broken.dart';
// import 'package:m2m/business_logic/app_localization.dart';
// import 'package:m2m/business_logic/tasks_cubit/tasks_cubit.dart';
// import 'package:m2m/business_logic/tasks_cubit/tasks_states.dart';
//
// class ViewUserTasksScreen extends StatelessWidget {
//   const ViewUserTasksScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context)=>TasksCubit()..getUsersWhoUploadedTasks(),
//       child: BlocConsumer<TasksCubit,TasksStates>(
//         listener: (context, state){},
//         builder: (context, state){
//
//           var cubit = TasksCubit.get(context);
//           List<UserModel> users = cubit.userWhoUploadedTasks;
//
//           return Scaffold(
//             appBar: AppBar(
//               title: Text(
//                 AppLocalizations.of(context)!.translate('viewUserTasks').toString(),
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
//             body: Column(
//               children: [
//                 Expanded(
//                   child: state is GetUsersWhoUploadedTaskSuccessState ? ListView.separated(
//                     itemBuilder: (context,index)=>ViewTasksListItem(userModel: users[index]),
//                     separatorBuilder: (context,index)=>Container(),
//                     itemCount: users.length,
//                   ) : const Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
