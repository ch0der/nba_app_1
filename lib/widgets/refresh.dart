import 'package:flutter/material.dart';

class Refresh extends StatelessWidget{
  final Widget child;  // instance variable

  Refresh({required this.child}); // Constructor... requires u to pass in a 'child' now
  Widget build(context){

    return RefreshIndicator(
      child: child,   // child #1 refers to child of RefreshIndicator, child #2 means we want to pass in the above child as the child
      onRefresh: () async {

      },
    );
  }
}