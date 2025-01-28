import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/data/models/payment_model.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/default_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class ConfirmPaymentScreen extends StatelessWidget {
  final PaymentModel paymentModel;
  const ConfirmPaymentScreen({super.key, required this.paymentModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){
        if(state is VerifiyUserSuccessState){
          Navigator.pop(context);
        }
        if(state is DeletePaymentsSuccessState){
          Navigator.pop(context);
        }
      },
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Confirm Payment',
              style: TextStyle(
                fontSize: MediaQuery.sizeOf(context).height*0.02,
                fontWeight: FontWeight.bold,
                color: ColorManager.black,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: ColorManager.black,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
          body: ModalProgressHUD(
            inAsyncCall: state is VerifiyUserLoadingState || state is DeletePaymentsLoadingState,
            progressIndicator: CupertinoActivityIndicator(),
            child: Padding(
              padding: EdgeInsets.all(
                MediaQuery.sizeOf(context).height*0.02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // uploaded image widget
                  Expanded(
                    child: Container(
                      height: MediaQuery.sizeOf(context).height*0.7,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: ColorManager.secondDarkColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: ColorManager.white,
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image(
                          image: NetworkImage(paymentModel.image.toString()),
                          fit: BoxFit.fill,
                          height: double.maxFinite,
                          width: double.maxFinite,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height*0.02,
                  ),

                  // upload button
                  DefaultButton(
                    text:'Confirm',
                    onPressed: (){
                      AppCubit.get(context).verifiyUserPaid(userId: paymentModel.userId,paymentId: paymentModel.paymentId);
                    },
                    color: ColorManager.primary,
                  ),

                  SizedBox(
                    height: MediaQuery.sizeOf(context).height*0.02,
                  ),

                  DefaultButton(
                    text:'Delete',
                    onPressed: (){
                      AppCubit.get(context).deletePaymentImage(uId: paymentModel.paymentId);
                    },
                    color: ColorManager.red,
                  ),
                ],
              ),
            ),
          ),

        );
      },
    );
  }
}
