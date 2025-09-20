
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/homw_work_tabs/assignmentScreen/assginments.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/homw_work_tabs/marked_assignment/marked_assignment.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/homw_work_tabs/marks/marks_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/cambridg_course/mock_exams/cambridge_marked_assignment_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/cambridg_course/mock_exams/cambridge_mock_exams_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/home_work/assignment_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/home_work/marked_assignment_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/mock_exams/oxford_home_work_screen.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/mock_exams/oxford_marked_assigmnet_mock_screen.dart';
import 'package:e_learning_dathboard/admin_screens/placement_tests/view/placement_mark_screen.dart';
import 'package:e_learning_dathboard/admin_screens/placement_tests/view/placement_test_items.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:flutter/material.dart';

class PlacemnetTestTabs extends StatelessWidget {
  const PlacemnetTestTabs({super.key, required this.title, required this.section});

  final String title;
  final String section;

  static bool pinned = true;
  static bool snap = false;
  static bool floating = false;
  static var searchController = TextEditingController();
  static var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        /// appbar
          appBar: AppBar(
              title: Text('Placement Tests',
                  style: TextStyle(
                      fontSize:  MediaQuery.of(context).size.height*0.03,
                      color: ColorManager.black
                  )),
              backgroundColor: ColorManager.white,
              titleSpacing: 0.0,
              bottom: TabBar(
                  indicatorColor: ColorManager.primary,
                  unselectedLabelColor: ColorManager.grey,
                  labelColor: ColorManager.primary,
                  tabs: [
                    Tab(
                        child: Text('Placement Tests',
                            style: TextStyle(
                              fontSize:  MediaQuery.sizeOf(context).height*0.02,
                            ))),
                    Tab(
                        child: Text('Marked Assignment',
                            style: TextStyle(
                              fontSize:  MediaQuery.sizeOf(context).height*0.02,
                            ))),

                  ])),

          /// tabview
          body:  TabBarView(
            children: [
              PlacementTestItems(title: title, section: section,type: 'file',),
              PlacementMarkScreen(title: title, section: section,type: 'marks' ,),
            ],
          )),
    );
  }
}
