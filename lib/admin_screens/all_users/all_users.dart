
import 'package:e_learning_dathboard/admin_screens/all_users/single_user.dart';
import 'package:e_learning_dathboard/admin_screens/all_users/widget/user_item.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigate_to.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AllUser extends StatefulWidget {

  const AllUser({Key? key,required this.verified}) : super(key: key);
  final bool verified;

  @override
  State<AllUser> createState() => _AllUserState();
}

class _AllUserState extends State<AllUser> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppCubit.get(context).getAllOfficialStudents();


  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=AppCubit.get(context);
        Size size=MediaQuery.of(context).size;

        return Scaffold(

          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
            title: Text(widget.verified? 'Students Requests' :'All Students',
              style: TextStyle(
                  color: ColorManager.black,
                  fontWeight: FontWeight.w500,
                  fontSize: size.height*.027
              ),),
            titleSpacing: 0,

          ),


          body: SafeArea(
            child: state is GetAllStudentsLoadingState? Center(child: CupertinoActivityIndicator(),) : Column(
              children: [


                SizedBox(height: MediaQuery.of(context).size.height*.02,),
                 Expanded(
                   child: ListView.separated(
                       itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
                              navigateTo(context, SingleUser(
                                  studentModel:  widget.verified?
                                  cubit.notVerifiedStudents[index] : cubit.officialStudents[index],
                                  isVerified: widget.verified
                              ),
                              );
                            },
                            child:  UserItem(studentModel:

                            widget.verified? cubit.notVerifiedStudents[index] : cubit.officialStudents[index]),
                          );
                       },
                       separatorBuilder: (context,index){
                         return SizedBox(height: MediaQuery.of(context).size.height*.02,);
                       },
                       itemCount: widget.verified? cubit.notVerifiedStudents.length : cubit.officialStudents.length
                   ),
                 ),
              ],
            )
          ),
        );
      },
    );
  }
}
