import 'package:e_learning_dathboard/admin_screens/certificates/screens/upload_certificate_screen.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageCertificateScreen extends StatefulWidget {
  const ManageCertificateScreen({super.key});

  @override
  State<ManageCertificateScreen> createState() => _ManageCertificateScreenState();
}

class _ManageCertificateScreenState extends State<ManageCertificateScreen> {

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getCertificates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Certificate',style: TextStyle(
          color: Colors.black,
          fontSize: MediaQuery.sizeOf(context).height*0.025
        ),),
      ),
      body: BlocBuilder<AppCubit,AppStates>(
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return state is GetCertificateLoadingState?
          Center(child: CupertinoActivityIndicator(),) :
          Column(
            children: [
              Expanded(
                child: GridView.count(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1/1.2,
                    crossAxisCount: 2,
                    children: List.generate(cubit.certificates.length, (index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12) ,
                          border: Border.all(
                            color: Colors.black,
                            width: 1
                          ),
                          image: DecorationImage(
                             fit: BoxFit.cover,
                            image: NetworkImage(cubit.certificates[index].certificateImage),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment:  CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                  onPressed: (){
                                    cubit.deleteCertificates(uId: cubit.certificates[index].uId);
                                  },
                                  icon: Icon(Icons.delete,color: ColorManager.red,)
                              ),
                            ),
                            Spacer(),
                            Container(
                              decoration:BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(11),
                                  bottomLeft: Radius.circular(11),
                                ) ,
                              ) ,
                              padding: EdgeInsets.all(12) ,
                              child: Text(cubit.certificates[index].certificateName,
                                style:TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.sizeOf(context).height*0.014
                              ),),
                            ),
                          ],
                        ),
                      );
                    })
                ),
              )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.primary,
        onPressed: (){
          customPushNavigator(context,  UploadCertificateScreen());
        },
        child: Container(
          padding:  EdgeInsets.all(12),
          child: Icon(Icons.add,color: Colors.white,),
        ),
      ),
    );
  }
}
