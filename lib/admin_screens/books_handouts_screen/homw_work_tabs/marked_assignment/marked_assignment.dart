import 'package:flutter/material.dart';

class MarkedAssignmentScreen extends StatelessWidget {
  const MarkedAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all( MediaQuery.sizeOf(context).height*0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Marked Assignments',
                style: TextStyle(
                    fontSize:  MediaQuery.sizeOf(context).height*0.025,
                    fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
