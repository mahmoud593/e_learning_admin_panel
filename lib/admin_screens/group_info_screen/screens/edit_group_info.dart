import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/constants/constants.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/default_button.dart';
import 'package:e_learning_dathboard/widgets/default_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditGroupInfo extends StatefulWidget {
  const EditGroupInfo({super.key,required this.section,required this.uId,
    required this.courseName,required this.count,
    required this.startDate,required this.endDate,
    required this.startTime,required this.endTime,
    required this.status
  });
  final String section;
  final String uId;
  final String courseName;
  final String count;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final bool status;

  @override
  State<EditGroupInfo> createState() => _EditGroupInfoState();
}

class _EditGroupInfoState extends State<EditGroupInfo> {
  TextEditingController countController = TextEditingController();

  TextEditingController statusController = TextEditingController();

  TextEditingController courseNameController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    courseNameController.text=widget.courseName;
    countController.text=widget.count;
    AppCubit.get(context).startDateController.text=widget.startDate;
    AppCubit.get(context).startTimeController.text=widget.startTime;
    AppCubit.get(context).endDateController.text=widget.endDate;
    AppCubit.get(context).endTimeController.text=widget.endTime;
    AppCubit.get(context).switchValue=widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Group',style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.sizeOf(context).height*0.025
          ),),
        ),
        body: BlocConsumer<AppCubit,AppStates>(
            listener: (context, state){
              if(state is UpdateGroupsSuccessState){
                Navigator.pop(context);
                countController.text='';
                courseNameController.text='';
                statusController.text='';
                AppCubit.get(context).startTimeController.text='';
                AppCubit.get(context).startDateController.text='';
                AppCubit.get(context).endTimeController.text='';
                AppCubit.get(context).endDateController.text='';
                AppCubit.get(context).switchValue=false;

              }
            },
            builder: (context, state) {
              var cubit = AppCubit.get(context);
              return ModalProgressHUD(
                inAsyncCall: state is UpdateGroupsLoadingState,
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

                          Text('Course Name',style: TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.sizeOf(context).height*0.025
                          ),),

                          SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),

                          DefaultFormField(
                              validText: 'Please enter course name',
                              hint: 'Enter Course Name',
                              controller: courseNameController,
                              textInputType: TextInputType.text
                          ),

                          SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),


                          Text('Count',style: TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.sizeOf(context).height*0.025
                          ),),

                          SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),

                          DefaultFormField(
                              validText: 'Please enter count',
                              hint: 'Enter Count',
                              controller: countController,
                              textInputType: TextInputType.number
                          ),

                          SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),

                          Text('Start Date',style: TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.sizeOf(context).height*0.025
                          ),),

                          SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),

                          GestureDetector(
                            onTap: (){
                              showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(Duration(days: 356)),
                              ).then((value) {
                                cubit.addStartDate(value: DateFormat('yyyy-MM-dd').format(value!));
                              });
                            },
                            child: DefaultFormField(
                                enabled: false,
                                validText: 'Please Enter Start Date',
                                hint: 'Enter Start Date',
                                controller: cubit.startDateController,
                                textInputType: TextInputType.text
                            ),
                          ),

                          SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),

                          Text('End Time',style: TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.sizeOf(context).height*0.025
                          ),),

                          SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),

                          GestureDetector(
                            onTap: (){
                              showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(Duration(days: 356)),
                              ).then((value) {
                                cubit.addEndDate(value: DateFormat('yyyy-MM-dd').format(value!));
                              });
                            },
                            child: DefaultFormField(
                                enabled: false,
                                validText: 'Please Enter End Date',
                                hint: 'Enter End Date',
                                controller: cubit.endDateController,
                                textInputType: TextInputType.text
                            ),
                          ),

                          SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),



                          SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),

                          Text('Start Time',style: TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.sizeOf(context).height*0.025
                          ),),

                          SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),

                          GestureDetector(
                            onTap: (){
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                cubit.addStartTime(
                                    value: DateFormat.jm().format(
                                      DateTime(0, 0, 0, value!.hour, value.minute),
                                    ));
                              });
                            },
                            child: DefaultFormField(
                                enabled: false,
                                validText: 'Please Enter Start Time',
                                hint: 'Enter Start Time',
                                controller: cubit.startTimeController,
                                textInputType: TextInputType.text
                            ),
                          ),

                          SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),


                          SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),

                          Text('End Time',style: TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.sizeOf(context).height*0.025
                          ),),

                          SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),

                          GestureDetector(
                            onTap: (){
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                cubit.addEndTime(
                                    value: DateFormat.jm().format(
                                      DateTime(0, 0, 0, value!.hour, value.minute),
                                    ));
                              });
                            },
                            child: DefaultFormField(
                                enabled: false,
                                validText: 'Please Enter End Time',
                                hint: 'Enter End Time',
                                controller: cubit.endTimeController,
                                textInputType: TextInputType.text
                            ),
                          ),

                          SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),

                          Row(
                              children: [
                                Text('Status',style: TextStyle(
                                    color: Colors.black,
                                    fontSize: MediaQuery.sizeOf(context).height*0.025
                                ),),

                                SizedBox(width:  MediaQuery.sizeOf(context).height*0.02,),

                                Switch(
                                    value: cubit.switchValue,
                                    onChanged: (value){
                                      cubit.addSwitchValue(value: value);
                                    }
                                )

                              ]
                          ),


                          DefaultButton(
                            color: ColorManager.primary,
                            text: 'Edit',
                            onPressed: (){
                                cubit.updateGroups(
                                  section: widget.section,
                                  count: int.parse(countController.text),
                                  courseName: courseNameController.text,
                                  endDate: cubit.endDateController.text,
                                  endTime: cubit.endTimeController.text,
                                  startDate: cubit.startDateController.text,
                                  startTime: cubit.startTimeController.text,
                                  status: cubit.switchValue,
                                  uId: widget.uId,
                                );
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
