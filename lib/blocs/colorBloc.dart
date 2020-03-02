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
      "ATL" : Color.fromRGBO(225, 68, 52, 1),
      "BOS" : Color.fromRGBO(0,122,51,1),
      "BKN" : Color.fromRGBO(0, 0, 0, 1),
      "PHI" : Color.fromRGBO(0,107,182,1),
      "CHA" : Color.fromRGBO(29,17,96,1),
      "CHI" : Color.fromRGBO(206,17,65,1),
      "MEM" : Color.fromRGBO(93,118,169,1),
      "SAC" : Color.fromRGBO(91,43,130,1),
      "HOU" : Color.fromRGBO(206,17,65,1),
      "GSW" : Color.fromRGBO(29,66,138,1),
      
      
    };

    colorData.sink.add(TeamColors(colors[home],colors[away]));
    return TeamColors(colors[home],colors[away]);



  }
  ColorsBloc();

}