import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning_dathboard/admin_screens/certificates/screens/edit_certificate_screen.dart';
import 'package:e_learning_dathboard/admin_screens/certificates/screens/open_image.dart';
import 'package:e_learning_dathboard/admin_screens/certificates/screens/upload_certificate_screen.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews',style: TextStyle(
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
                flex: 1,
                child: ListView.separated(
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          customPushNavigator(context, FullScreenImageScreen(
                            imageUrl: cubit.reviews[index].reviewImage,
                          ));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left:  MediaQuery.sizeOf(context).height*0.02,
                              right:  MediaQuery.sizeOf(context).height*0.02
                          ),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12) ,
                            border: Border.all(
                                color: Colors.black,
                                width: 1
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment:  CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(cubit.reviews[index].userImage),
                                  ),
                                  SizedBox(width: MediaQuery.sizeOf(context).height*0.01,),
                                  Text(
                                    cubit.reviews[index].userName,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: MediaQuery.sizeOf(context).height*0.02
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),
                              Text(cubit.reviews[index].review,
                                style:TextStyle(
                                    color: ColorManager.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: MediaQuery.sizeOf(context).height*0.014
                                ),),
                              SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),
                              CachedNetworkImage(
                                imageUrl: cubit.reviews[index].reviewImage,
                                fit: BoxFit.cover,
                                placeholder: (_,url) => Center(child: CupertinoActivityIndicator()),
                                errorWidget: (context, url, error) => Center(child: const Icon(Icons.error)),
                              ),
                              SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),
                              Align(
                                alignment: Alignment.topRight,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                      onPressed: (){
                                        cubit.deleteReviews(uId: cubit.reviews[index].uId);
                                      },
                                      icon: Icon(Icons.delete,color: ColorManager.red,)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context,index){
                      return SizedBox(height:  MediaQuery.sizeOf(context).height*0.01,);
                    },
                    itemCount: cubit.reviews.length
                )
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),
            ],
          );
        },
      ),
    );
  }
}
