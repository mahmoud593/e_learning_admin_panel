import 'package:e_learning_dathboard/admin_screens/payment_screens/confirm_payment_screen.dart';
import 'package:e_learning_dathboard/admin_screens/payment_screens/widget/payment_list_item.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PaymentRequestsScreen extends StatefulWidget {
  const PaymentRequestsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentRequestsScreen> createState() => _PaymentRequestsScreenState();
}

class _PaymentRequestsScreenState extends State<PaymentRequestsScreen> {

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getPaymentImage();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Requests',
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
          return state is GetPaymentsImagesLoadingState?
          Center(child: CupertinoActivityIndicator(),) :
          Column(
            children: [
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return GestureDetector(
                        onTap: (){
                          customPushNavigator(context, ConfirmPaymentScreen(
                              paymentModel: cubit.paymentsImage[index],
                          ));
                        },
                        child: PaymentListItem(paymentModel: cubit.paymentsImage[index],)
                    );
                  },
                  separatorBuilder: (context,index){
                    return Container();
                  },
                  itemCount: cubit.paymentsImage.length,
                ),
              )
            ],
          );
        },
      )
    );
  }
}
