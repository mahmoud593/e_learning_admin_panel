import 'package:e_learning_dathboard/admin_screens/group_info_screen/screens/widget/expanded_widget.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:flutter/material.dart';

class OnlineFaceScreen extends StatelessWidget {
   OnlineFaceScreen({super.key, required this.courseName,});
   final String courseName;

   List<String> coursesType = [
    "Online",
    "Face to Face",
  ];

   List<String> payType = [
    "Pay by course",
    "Pay by class",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context,index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal:MediaQuery.sizeOf(context).height*0.02),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).height*0.02, vertical: MediaQuery.sizeOf(context).height*0.02,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(MediaQuery.sizeOf(context).height*0.02),
                        color: ColorManager.primary,
                      ),
                      alignment: Alignment.center,

                      child: ExpansionFaqWidget(
                        title: coursesType[index],
                        data: payType,
                        courseName: courseName,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context,index)=> SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),
                itemCount: coursesType.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
