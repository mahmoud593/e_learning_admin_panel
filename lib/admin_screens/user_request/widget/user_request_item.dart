
import 'package:e_learning_dathboard/admin_screens/user_request/confirm_user_request.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigate_to.dart';
import 'package:e_learning_dathboard/widgets/text_manager.dart';
import 'package:flutter/material.dart';


class UserRequestItem extends StatelessWidget {


  const UserRequestItem({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        navigateTo(context, const ConfirmUserRequest());
      },
      child: Container(
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.height*.02,
          right: MediaQuery.of(context).size.height*.02,
          bottom: MediaQuery.of(context).size.height*.02,
        ),
        child: Material(
          elevation: 2,
          color: ColorManager.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.height*.02,
              right: MediaQuery.of(context).size.height*.02,
              top: MediaQuery.of(context).size.height*.02,
              bottom: MediaQuery.of(context).size.height*.02,
            ),

            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:const NetworkImage('https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1666607282~exp=1666607882~hmac=c2d5e7d678d67c2e43919b2ef95e2a00d82246b7615497516faace3cee271ca8'),
                      radius: MediaQuery.of(context).size.height*.03,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.height*.01,),
                    Expanded(
                      child: Text('Mahmoud Reda',
                        style: textManager(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
