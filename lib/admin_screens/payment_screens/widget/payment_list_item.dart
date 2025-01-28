import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/data/models/payment_model.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/text_manager.dart';
import 'package:flutter/material.dart';


class PaymentListItem extends StatelessWidget {
  const PaymentListItem({super.key, required this.paymentModel});

  final PaymentModel paymentModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
          MediaQuery.of(context).size.height*.02
      ),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(
            MediaQuery.of(context).size.height*.02,
          ),
          decoration: BoxDecoration(
            color: ColorManager.secondDarkColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/student.png'),
                    radius: 35,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.height*.01,),
                  Expanded(
                    child: Text(
                      paymentModel.userName.toString(),
                      style: textManager(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              rowData(title: 'Email', data: paymentModel.userEmail.toString(),context: context),

              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              rowData(title: 'Parent Name', data: paymentModel.parentName.toString(),context: context),

              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              rowData(title: 'Parent Phone', data:  paymentModel.parentPhone.toString(),context: context),


            ],
          ),
        ),
      ),
    );
  }

  Widget rowData ({required String title , required String data,required BuildContext context}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '$title : ',
          style: textManager(color: ColorManager.white),
          overflow: TextOverflow.ellipsis,
        ),

        Expanded(
          child: Text(
            data,
            style: textManager(color: Colors.white,fontSize: MediaQuery.of(context).size.height*.02),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

}
