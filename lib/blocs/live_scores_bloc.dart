import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:nba_app/models/index.dart';
import 'package:nba_app/models/liveScoreJsonData/liveGameData01.dart';
import 'package:rxdart/rxdart.dart';

class LiveScoreBloc{

  final _data = BehaviorSubject<LiveGameData01>();


  Stream<LiveGameData01> get dataScores => _data.stream;

  Function(LiveGameData01)get addData => _data.sink.add;

  dispose(){

    _data.close();
  }


  LiveScoreBloc(){
    fetchPost2();
  }

  Future<LiveGameData01> fetchPost2() async {
    String myPath = "/games/date/2020-02-21";
    String livePath = "/games/live/";
    final response = await http
        .get(Uri.https("api-nba-v1.p.rapidapi.com", myPath), headers: {
      "x-rapidapi-host": "api-nba-v1.p.rapidapi.com",
      "x-rapidapi-key": "6e137c5c98mshcfe3870862cc847p12a327jsn818c1cb513dd"
    });

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.

      var info = json.decode(response.body);

      _data.sink.add(LiveGameData01.fromJson(info['api']));

      return LiveGameData01.fromJson(info['api']);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

}
class LiveStandingsBloc {

  final standingsData = BehaviorSubject<Map<String,dynamic>>();


  Stream<Map<String,dynamic>> get dataScores => standingsData.stream;

  Function(Map<String,dynamic>)get addData => standingsData.sink.add;

  dispose(){

    standingsData.close();
  }


  LiveStandingsBloc(){
    fetchStandings();
  }


  Future fetchStandings() async {
    String myPath = "/standings/standard/2019/";

    final response = await http
        .get(Uri.https("api-nba-v1.p.rapidapi.com", myPath), headers: {
      "x-rapidapi-host": "api-nba-v1.p.rapidapi.com",
      "x-rapidapi-key": "6e137c5c98mshcfe3870862cc847p12a327jsn818c1cb513dd"
    });

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.

      var info = json.decode(response.body);

      Map<String,dynamic> testList = {
          "standings":{
            "IND": "${info['api']['standings'][11]['win']}-${info['api']['standings'][11]['loss']}",
            "MIL": "${info['api']['standings'][10]['win']}-${info['api']['standings'][10]['loss']}",
            "LAC": "${info['api']['standings'][21]['win']}-${info['api']['standings'][21]['loss']}",
            "OKC": "${info['api']['standings'][28]['win']}-${info['api']['standings'][28]['loss']}",
            "DEN": "${info['api']['standings'][25]['win']}-${info['api']['standings'][25]['loss']}",
            "LAL": "${info['api']['standings'][23]['win']}-${info['api']['standings'][23]['loss']}",
            "ORL": "${info['api']['standings'][0]['win']}-${info['api']['standings'][0]['loss']}",
            "CHA": "${info['api']['standings'][1]['win']}-${info['api']['standings'][1]['loss']}",
            "MIA": "${info['api']['standings'][2]['win']}-${info['api']['standings'][2]['loss']}",
            "WAS": "${info['api']['standings'][3]['win']}-${info['api']['standings'][3]['loss']}",
            "ATL": "${info['api']['standings'][4]['win']}-${info['api']['standings'][4]['loss']}",
            "TOR": "${info['api']['standings'][5]['win']}-${info['api']['standings'][5]['loss']}",
            "PHI": "${info['api']['standings'][6]['win']}-${info['api']['standings'][6]['loss']}",
            "BOS": "${info['api']['standings'][7]['win']}-${info['api']['standings'][7]['loss']}",
            "BKN": "${info['api']['standings'][8]['win']}-${info['api']['standings'][8]['loss']}",
            "NYK": "${info['api']['standings'][9]['win']}-${info['api']['standings'][9]['loss']}",
            "DET": "${info['api']['standings'][12]['win']}-${info['api']['standings'][12]['loss']}",
            "CHI": "${info['api']['standings'][13]['win']}-${info['api']['standings'][13]['loss']}",
            "CLE": "${info['api']['standings'][14]['win']}-${info['api']['standings'][14]['loss']}",
            "HOU": "${info['api']['standings'][15]['win']}-${info['api']['standings'][15]['loss']}",
            "SAS": "${info['api']['standings'][16]['win']}-${info['api']['standings'][16]['loss']}",
            "MEM": "${info['api']['standings'][17]['win']}-${info['api']['standings'][17]['loss']}",
            "NOP": "${info['api']['standings'][18]['win']}-${info['api']['standings'][18]['loss']}",
            "DAL": "${info['api']['standings'][19]['win']}-${info['api']['standings'][19]['loss']}",
            "GSW": "${info['api']['standings'][20]['win']}-${info['api']['standings'][20]['loss']}",
            "SAC": "${info['api']['standings'][22]['win']}-${info['api']['standings'][22]['loss']}",
            "PHX": "${info['api']['standings'][24]['win']}-${info['api']['standings'][24]['loss']}",
            "POR": "${info['api']['standings'][26]['win']}-${info['api']['standings'][26]['loss']}",
            "UTA": "${info['api']['standings'][27]['win']}-${info['api']['standings'][27]['loss']}",
            "MIN": "${info['api']['standings'][29]['win']}-${info['api']['standings'][29]['loss']}",


          },
      };
      print(testList);
      standingsData.sink.add(testList);


    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

}

// pacers 15
// bucks 21
// clippers 16
// okc 25
// nugs 9
// lakers 17
//
//
//
