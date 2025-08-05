
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:flutter/material.dart';

import '../../../widgets/text_manager.dart';

class AdminHomeItem extends StatelessWidget {
  static List titleName=[
    'Manage Students',
    'Students Requests',
    'Books & Handouts',
    'Notes Free',
    'Groups Info',
    'Placement Test',
    'Payments Orders',
    'Manage Certificates',
    'Review Students',
  ];

  static List imageName=[
    'https://img.freepik.com/free-photo/group-students-posing-table_23-2147666543.jpg?w=740&t=st=1703239807~exp=1703240407~hmac=42db32dd56219a9e38ad81062553673eed8942fb9e4bb7e70463d5815056c94e',
    'https://img.freepik.com/premium-vector/hand-drawn-study-abroad-illustration_23-2150310003.jpg?w=740',
    'https://img.freepik.com/free-photo/literature-concept_23-2147690493.jpg?w=360&t=st=1703239852~exp=1703240452~hmac=c2dff7464d31a38595b602ace9086c2e92deedfb91a9452c12cc28012f50065b',
    'https://img.freepik.com/free-vector/hand-drawn-book-infographics_23-2148663634.jpg?w=740&t=st=1703239931~exp=1703240531~hmac=b6bd0ab61b81c918e2108de0d106d32c8caa34b644b67f65a530ad01548f6e64',
  ];

  final int index;
  final VoidCallback onTap;
  const AdminHomeItem({Key? key,required this.index, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        height:  MediaQuery.of(context).size.height*.14,
        padding: EdgeInsets.all(
          MediaQuery.of(context).size.height*.02,
        ),
        margin: EdgeInsets.symmetric(
          horizontal:  MediaQuery.of(context).size.height*.02,
        ),
        decoration: BoxDecoration(
            color: ColorManager.primary,
            border: Border.all(
                color: ColorManager.primary
            ),
            borderRadius: BorderRadius.circular( MediaQuery.of(context).size.height*.02),
        ),
        // test
        child: Text(titleName[index],
          style: textManager(
              color: ColorManager.white,
              fontWeight: FontWeight.w500,
              fontSize:  MediaQuery.of(context).size.height*.025
          ),
        ),


      ),
    );
  }
}
