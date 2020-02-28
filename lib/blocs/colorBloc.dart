import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:nba_app/teamColors.dart';


class ColorsBloc{
  final colorData = BehaviorSubject<TeamColors>();
  Stream<TeamColors> get teamColors => colorData.stream;

  dispose(){
    colorData.close();
  }

  fetchColors(String away,String home){

    Map<String,Color> colors = {
      "MIL" : Color.fromRGBO(0, 71, 27, 1),
      "DET" : Color.fromRGBO(200, 16, 46, 1),
      "MIA" : Color.fromRGBO(152, 0, 46, 1),
      "ATL" : Color.fromRGBO(225, 68, 52, 1)
      
    };

    colorData.sink.add(TeamColors(colors[home],colors[away]));
    return TeamColors(colors[home],colors[away]);



  }
  ColorsBloc();

}