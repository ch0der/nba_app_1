import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

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
    String myPath = "/games/date/2020-02-02";
    Map<String, String> parms1 = {"lastname": "Paul"};

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

