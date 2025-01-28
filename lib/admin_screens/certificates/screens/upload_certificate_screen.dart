import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/default_button.dart';
import 'package:e_learning_dathboard/widgets/default_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadCertificateScreen extends StatelessWidget {
   UploadCertificateScreen({super.key});

  TextEditingController certificateNameController = TextEditingController();
  TextEditingController certificateLinkController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Certificate',style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.sizeOf(context).height*0.025
        ),),
      ),
      body: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){
          if(state is UploadCertificateSuccessState){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return ModalProgressHUD(
            inAsyncCall: state is UploadCertificateLoadingState,
            progressIndicator: CupertinoActivityIndicator(),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(12),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),

                      Text('Certificate Name',style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.sizeOf(context).height*0.025
                      ),),

                      SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),

                      DefaultFormField(
                          maxLines: 3,
                          validText: 'Enter Certificate Name',
                          hint: 'Enter Certificate Name',
                          controller: certificateNameController,
                          textInputType: TextInputType.text
                      ),

                      SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),


                      SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),

                      Text('Certificate Link',style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.sizeOf(context).height*0.025
                      ),),

                      SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),

                      DefaultFormField(
                          maxLines: 3,
                          validText: 'Enter Certificate Link',
                          hint: 'Enter Certificate Link',
                          controller: certificateLinkController,
                          textInputType: TextInputType.text
                      ),

                      SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),

                      Text('Upload Certificate',style: TextStyle(
                          color: ColorManager.primary,
                          fontSize: MediaQuery.sizeOf(context).height*0.025
                      ),),

                      SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),

                      GestureDetector(
                        onTap: (){
                          cubit.getCertificateImage();
                        },
                        child: Container(
                            width: double.infinity,
                            height:  MediaQuery.sizeOf(context).height*0.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[200]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                cubit.uploadedCertificateImage!=null ?
                                Image(
                                  fit: BoxFit.cover,
                                  height:  MediaQuery.sizeOf(context).height*0.15,
                                  image: FileImage(cubit.uploadedCertificateImage!),
                                ):Image(
                                  height:  MediaQuery.sizeOf(context).height*0.15,
                                  image: AssetImage('assets/images/certificate.png'),
                                )
                              ],
                            )
                        ),
                      ),

                      SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),

                      DefaultButton(
                        color: ColorManager.primary,
                        text: 'Upload',
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                             cubit.uploadCertificateImage(
                                 certificateName: certificateNameController.text,
                                 certificateLink: certificateLinkController.text
                             );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      )
    );
  }
}
