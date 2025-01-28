
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/user_request_item.dart';


class UserRequest extends StatefulWidget {
  const UserRequest({Key? key}) : super(key: key);

  @override
  State<UserRequest> createState() => _UserRequestState();
}

class _UserRequestState extends State<UserRequest> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit=AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
            title: Text('Student Request',
              style: TextStyle(
                  color: ColorManager.black,
                  fontWeight: FontWeight.w500,
                  fontSize: MediaQuery.sizeOf(context).height*.025
              ),),
            titleSpacing: 0,

          ),

          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(height: MediaQuery.of(context).size.height*.01,),

                  // user request item
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                        return const UserRequestItem();
                      },
                      separatorBuilder: (context,index){
                        return SizedBox(height: MediaQuery.of(context).size.height*.0,);
                      },
                      itemCount: 10,
                  ),

                ],
              ),
            )

          ),
        );

      },
    );
  }
}
