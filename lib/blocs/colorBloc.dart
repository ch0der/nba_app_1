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
      "CLE" : Color.fromRGBO(134,0,56,1),
      "LAL" : Color.fromRGBO(85,37,130,1),
      "LAC" : Color.fromRGBO(200,16,46, 1),
      "IND" : Color.fromRGBO(253,187,48, 1),
      "DEN" : Color.fromRGBO(13,34,64, 1),
      "DAL" : Color.fromRGBO(0,83,188, 1),
      "MIN" : Color.fromRGBO(120,190,32, 1),
      "NOP" : Color.fromRGBO(180,151,90, 1),
      "NYK" : Color.fromRGBO(0,107,182, 1),
      "OKC" : Color.fromRGBO(0,125,195, 1),
      "ORL" : Color.fromRGBO(0,125,197, 1),
      "PHX" : Color.fromRGBO(229,95,32, 1),
      "POR" : Color.fromRGBO(224,58,62, 1),
      "TOR" : Color.fromRGBO(6,25,34, 1),
      "SAS" : Color.fromRGBO(6,25,34, 1),
      "UTA" : Color.fromRGBO(0,43,92, 1),
      "WAS" : Color.fromRGBO(0,43,92, 1),
      
      
    };

    colorData.sink.add(TeamColors(colors[home],colors[away]));
    return TeamColors(colors[home],colors[away]);



  }
  ColorsBloc();

}