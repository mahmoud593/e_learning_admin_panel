import 'package:e_learning_dathboard/admin_screens/admin_home/widget/admin_home_item.dart';
import 'package:e_learning_dathboard/admin_screens/all_users/all_users.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/books_handouts.dart';
import 'package:e_learning_dathboard/admin_screens/certificates/screens/manage_certificate_screen.dart';
import 'package:e_learning_dathboard/admin_screens/free_note_screen/view/free_note_screen.dart';
import 'package:e_learning_dathboard/admin_screens/group_info_screen/screens/group_info_screen.dart';
import 'package:e_learning_dathboard/admin_screens/placement_tests/view/placements_screen.dart';
import 'package:e_learning_dathboard/widgets/navigate_to.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/app_cubit/app_cubit.dart';
import '../../business_logic/app_cubit/app_states.dart';
import '../../styles/color_manager.dart';
import '../payment_screens/payment_requests_screen.dart';


class AdminHome extends StatelessWidget {

  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List onTaps = [
       ()=>navigateTo(context, const AllUser(verified: false,)),
       ()=>navigateTo(context, const AllUser(verified: true,)),
       ()=>navigateTo(context, const BooksAndHandoutsScreen()),
       ()=>navigateTo(context, const FreeNoteScreen()),
       ()=>navigateTo(context, const GroupInfoScreen()),
       ()=>navigateTo(context, const PlacementsScreen()),
       ()=>navigateTo(context, const PaymentRequestsScreen()),
       ()=>navigateTo(context, const ManageCertificateScreen()),
    ];

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Admin Home',style: TextStyle(
                color: ColorManager.black,
                fontSize:  MediaQuery.of(context).size.height*.03
            ),
            )
          ),
          body: Column(
            children: [
              // title

              SizedBox(height:  MediaQuery.of(context).size.height*.015,),

              // list of features
              Expanded(
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context,index){
                      return AdminHomeItem(index: index, onTap: onTaps[index],);
                    },
                    separatorBuilder: (context,index){
                      return SizedBox(height:  MediaQuery.of(context).size.height*.03,);
                    },
                    itemCount: onTaps.length,
                ),
              ),
              SizedBox(height:  MediaQuery.of(context).size.height*.02,),
            ],
          ),
        );

        },
    );
  }
}
