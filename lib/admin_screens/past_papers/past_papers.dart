import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning_dathboard/admin_screens/past_papers/past_papers_month.dart';
import 'package:e_learning_dathboard/constants/constants.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:flutter/material.dart';

class PastPapers extends StatelessWidget {
  const PastPapers({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorManager.white,

      /// appbar
      appBar: AppBar(
        title: Text(
          'Past Papers (Free)',style: TextStyle(
          fontSize: MediaQuery.of(context).size.height*0.025,
          color: ColorManager.black
          ,),
        ),
      ),

      ///body
      body: Column(
          children: [

            ///listview
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index){


                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (_){
                          return PastPapersMonth(
                            title:pastPapersString[index],
                            mainIndex: index,
                          );
                        }));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.height*.02,
                            vertical: MediaQuery.of(context).size.height*.01
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.022),
                          color: ColorManager.primary,
                        ),
                        height: MediaQuery.of(context).size.height*0.15,


                        child:Row(
                            children: [

                              /// image
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.height*.02,
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                height: MediaQuery.of(context).size.height*0.1,
                                width: MediaQuery.of(context).size.height*.1,
                                decoration: BoxDecoration(
                                  color: ColorManager.white.withOpacity(.9),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: pastPapersImages[index],
                                  progressIndicatorBuilder:  (context, url,downloadProgress) {
                                    return const Center(child: CircularProgressIndicator(),);
                                  },
                                  errorWidget: (context, url, error) {
                                    return const Image(image: AssetImage('assets/images/bookshelf.png'));
                                  },
                                ),
                              ),


                              /// sized box
                              SizedBox(width: MediaQuery.of(context).size.height*0.02,),


                              /// text
                              Text(pastPapersString[index],style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height*0.025,
                                  color: ColorManager.white
                              ),)
                            ]
                        ) ,
                      ),
                    );
                  },
                  separatorBuilder: (context, index){
                    return SizedBox(height: MediaQuery.of(context).size.height*0.01,);
                  },
                  itemCount: pastPapersImages.length
              ),
            ),

          ]
      ),
    );
  }
}
