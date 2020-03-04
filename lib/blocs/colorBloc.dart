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

  fetchColors(String home,String home2,String away,String away2){


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
      "LAL" : Color.fromRGBO(253,185,39,1),
      "LAC" : Color.fromRGBO(200,16,46, 1),
      "IND" : Color.fromRGBO(253,187,48, 1),
      "DEN" : Color.fromRGBO(13,34,64, 1),
      "DAL" : Color.fromRGBO(0,83,188, 1),
      "MIN" : Color.fromRGBO(12,35,64, 1),
      "NOP" : Color.fromRGBO(0,22,65, 1),
      "NYK" : Color.fromRGBO(0,107,182, 1),
      "OKC" : Color.fromRGBO(0,125,195, 1),
      "ORL" : Color.fromRGBO(0,125,197, 1),
      "PHX" : Color.fromRGBO(29,17,96, 1),
      "POR" : Color.fromRGBO(224,58,62, 1),
      "TOR" : Color.fromRGBO(206,17,65, 1),
      "SAS" : Color.fromRGBO(6,25,34, 1),
      "UTA" : Color.fromRGBO(0,43,92, 1),
      "WAS" : Color.fromRGBO(0,43,92, 1),

      "MIL2" : Color.fromRGBO(240,235,210, 1),
      "DET2" : Color.fromRGBO(29,66,138, 1),
      "MIA2" : Color.fromRGBO(6,25,34, 1),
      "ATL2" : Color.fromRGBO(38,40,42, 1),
      "BOS2" : Color.fromRGBO(150,56,33,1),
      "BKN2" : Color.fromRGBO(255,255,255, 1),
      "PHI2" : Color.fromRGBO(237,23,76,1),
      "CHA2" : Color.fromRGBO(0,120,140,1),
      "CHI2" : Color.fromRGBO(6,25,34,1),
      "MEM2" : Color.fromRGBO(18,23,63,1),
      "SAC2" : Color.fromRGBO(99,113,122,1),
      "HOU2" : Color.fromRGBO(6,25,34,1),
      "GSW2" : Color.fromRGBO(255,199,44,1),
      "CLE2" : Color.fromRGBO(4,30,66,1),
      "LAL2" : Color.fromRGBO(85,37,130,1),
      "LAC2" : Color.fromRGBO(29,66,148, 1),
      "IND2" : Color.fromRGBO(0,45,98, 1),
      "DEN2" : Color.fromRGBO(255,198,39, 1),
      "DAL2" : Color.fromRGBO(0,43,92, 1),
      "MIN2" : Color.fromRGBO(120,190,32, 1),
      "NOP2" : Color.fromRGBO(225,58,62, 1),
      "NYK2" : Color.fromRGBO(245,132,38, 1),
      "OKC2" : Color.fromRGBO(239,59,36, 1),
      "ORL2" : Color.fromRGBO(196,206,211, 1),
      "PHX2" : Color.fromRGBO(229,95,32, 1),
      "POR2" : Color.fromRGBO(6,25,34, 1),
      "TOR2" : Color.fromRGBO(6,25,34, 1),
      "SAS2" : Color.fromRGBO(196,206,211, 1),
      "UTA2" : Color.fromRGBO(0,71,27, 1),
      "WAS2" : Color.fromRGBO(227,24,55, 1),

      
      
    };

    colorData.sink.add(TeamColors(colors[home],colors[home2],colors[away],colors[away2]));
    TeamColors _colors = TeamColors(colors[home],colors[home2],colors[away],colors[away2]);
    print(_colors.awayColor2);
    return _colors;





  }
  ColorsBloc();

}