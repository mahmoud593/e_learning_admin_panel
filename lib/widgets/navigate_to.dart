import 'package:flutter/material.dart';

Future navigateTo( context,Widget widget){

  return Navigator.push(context, MaterialPageRoute(builder: (_){
     return widget;
  }));

}

Future navigateAndRemove( context,Widget widget ,){

  return Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
    return widget;
  }));

}