import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/lelts_course/ielts_course.dart';
import 'package:e_learning_dathboard/admin_screens/books_handouts_screen/view/oxford_course/oxford_course.dart';
import 'package:e_learning_dathboard/admin_screens/placement_tests/view/placement_test_items.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/constants/constants.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigate_to.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:flutter/material.dart';

class PlacementsScreen extends StatelessWidget {
  const PlacementsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: ColorManager.black,
            size:  MediaQuery.of(context).size.height*0.03,
          ),
        ),
        title: Text(
          'Placement Tests',
          style: TextStyle(
            color: ColorManager.black,
            fontSize:  MediaQuery.of(context).size.height*0.025,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: ColorManager.white,
      ),
      body: Padding(
        padding: EdgeInsets.only(top:  MediaQuery.of(context).size.height*0.01,left:  MediaQuery.of(context).size.height*0.02,right:  MediaQuery.of(context).size.height*0.02, bottom:  MediaQuery.of(context).size.height*0.02),
        child: Column(
          children: [
            SizedBox(height:  MediaQuery.of(context).size.height*0.015),

            Expanded(
              child: ListView.separated(
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: ()async{
                      if(index == 0){
                        await AppCubit.get(context).getPlacementTests(courseName: 'oxford');
                        navigateTo(context,  PlacementTestItems(title: 'Oxford\n Placement Test', section: 'oxford'));
                      }else if(index == 1){
                        await AppCubit.get(context).getPlacementTests(courseName: 'cambridge');
                        navigateTo(context,  PlacementTestItems(title: 'Cambridge\n Placement Test', section: 'cambridge'));
                      }else{
                        await AppCubit.get(context).getPlacementTests(courseName: 'ielts');
                        navigateTo(context,  PlacementTestItems(title: 'Ielts\n Placement Test', section: 'ielts'));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular( MediaQuery.of(context).size.height*0.022),
                        color: ColorManager.primary,
                      ),
                      height:  MediaQuery.of(context).size.height*0.15,


                      child:Padding(
                        padding: EdgeInsets.all( MediaQuery.of(context).size.height*0.01),
                        child: Row(
                            children: [

                              /// image
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal:  MediaQuery.of(context).size.height*.01,
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                height:  MediaQuery.of(context).size.height*0.1,
                                width:  MediaQuery.of(context).size.height*.1,
                                decoration: BoxDecoration(
                                  color: ColorManager.white.withOpacity(.9),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: 'https://img.freepik.com/free-vector/hand-drawn-flat-design-stack-books-illustration_23-2149341898.jpg?w=740&t=st=1704621629~exp=1704622229~hmac=d1b415f8eafa39a4da38000cad51e9cf8d867f79599909273bb7a0ed5ef44052',
                                  progressIndicatorBuilder:  (context, url,downloadProgress) {
                                    return const Center(child: CircularProgressIndicator(),);
                                  },
                                  errorWidget: (context, url, error) {
                                    return const Image(image: AssetImage('assets/images/bookshelf.png'));
                                  },
                                ),
                              ),


                              /// sized box
                              SizedBox(width:  MediaQuery.of(context).size.height*0.02,),


                              /// text
                              Expanded(
                                child: Text(
                                  coursesNamesMaterial[index],
                                  style: TextStyle(
                                      fontSize:  MediaQuery.of(context).size.height*0.025,
                                      color: ColorManager.white
                                  ),
                                  maxLines: 2,
                                ),
                              )
                            ]
                        ),
                      ) ,
                    ),
                  );
                },
                separatorBuilder: (context,index){
                  return SizedBox(height:  MediaQuery.of(context).size.height*0.01,);
                },
                itemCount: coursesNames.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
