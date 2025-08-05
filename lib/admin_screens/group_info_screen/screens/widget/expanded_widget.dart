
import 'package:e_learning_dathboard/admin_screens/group_info_screen/screens/show_group_details_screen.dart';
import 'package:e_learning_dathboard/constants/cache_helper.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class ExpansionFaqWidget extends StatelessWidget {
  final String title;
  final List<String> data;
  final String courseName;

  const ExpansionFaqWidget({
    super.key,
    required this.title,
    required this.data,
    required this.courseName,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      header: Padding(
        padding: EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.005),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: ColorManager.white,
          ),
          textAlign: TextAlign.start,
        ),
      ),
      collapsed: Container(),
      expanded: Padding(
        padding: EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.01),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height*0.065,
          child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    print('////////////');
                    //Pay by class
                    print('${data[index]}');
                    //Online
                      print(title);
                      print(courseName);
                      // Save the selected type and payType in CashHelper
                     CashHelper.saveData(key: 'type', value: title);
                      CashHelper.saveData(key: 'payType', value: data[index]);
                      print(CashHelper.getData(key: 'type'));
                      print(CashHelper.getData(key: 'payType'));
                      customPushNavigator(context, ShowGroupDetailsScreen(courseName: courseName,type:title,payType: data[index] ,));

                  },
                  child: Text(
                    data[index],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.white,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.015,
                );
              },
              itemCount: data.length),
        ),
      ),
      theme: ExpandableThemeData(
        tapHeaderToExpand: true,
        iconColor: ColorManager.white,
        iconPadding: EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.005),
      ),
    );
  }
}
