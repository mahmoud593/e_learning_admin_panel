import 'package:e_learning_dathboard/admin_screens/group_info_screen/screens/add_group_screen.dart';
import 'package:e_learning_dathboard/admin_screens/group_info_screen/screens/widget/group_list_item.dart';
import 'package:e_learning_dathboard/admin_screens/payment_screens/confirm_payment_screen.dart';
import 'package:e_learning_dathboard/admin_screens/payment_screens/widget/payment_list_item.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShowGroupDetailsScreen extends StatefulWidget {
  const ShowGroupDetailsScreen({Key? key,required this.courseName}) : super(key: key);
  final String courseName;

  @override
  State<ShowGroupDetailsScreen> createState() => _PaymentRequestsScreenState();
}

class _PaymentRequestsScreenState extends State<ShowGroupDetailsScreen> {

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getAllGroups(courseName: widget.courseName);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text(
            '${(widget.courseName.toUpperCase())} Groups',
            style: TextStyle(
              fontSize: MediaQuery.sizeOf(context).height*0.02,
              fontWeight: FontWeight.bold,
              color: ColorManager.black,
            ),
          ),
          leading: IconButton(
            icon:Icon(
              Icons.arrow_back,
              color: ColorManager.black,
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocBuilder<AppCubit,AppStates>(
          builder: (context, state) {
            var cubit=AppCubit.get(context);
            return state is GetGroupsLoadingState?
            Center(child: CupertinoActivityIndicator(),) :
            Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return GroupListItem(groupModel: cubit.groups[index],section: widget.courseName,);
                    },
                    separatorBuilder: (context,index){
                      return Container();
                    },
                    itemCount: cubit.groups.length,
                  ),
                )
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ColorManager.primary,
            onPressed: (){
               customPushNavigator(context, AddGroupScreen(section: widget.courseName,));
            },
            child: Icon(Icons.add,color: Colors.white,),
        ),
    );
  }
}
