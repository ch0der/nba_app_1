import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nba_app/models/index.dart';
import 'package:nba_app/models/live_game_details/liveGame1.dart';
import 'package:rxdart/rxdart.dart';

class GameDetailsBloc{

  final _data = BehaviorSubject<LiveGame1>();


  Stream<LiveGame1> get dataScores => _data.stream;

  Function(LiveGame1)get addData => _data.sink.add;

  dispose(){

    _data.close();
  }


  GameDetailsBloc();
  
  getInfo(String info){
    
  }
  fetcher(){

  }

  Future<LiveGame1> fetchPost2(String uniqueID) async {
    String myPath = "statistics/players/gameId/$uniqueID";

    final response = await http
        .get(Uri.https("api-nba-v1.p.rapidapi.com", myPath), headers: {
      "x-rapidapi-host": "api-nba-v1.p.rapidapi.com",
      "x-rapidapi-key": "6e137c5c98mshcfe3870862cc847p12a327jsn818c1cb513dd"
    });

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.

      var info = json.decode(response.body);

      _data.sink.add(LiveGame1.fromJson(info['api']));

      print(info['api']['statistics'][0]);

      return LiveGame1.fromJson(info['api']);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

}
class AdditionalGameDetails{

  final _data = BehaviorSubject<Quarters0>();


  Stream<Quarters0> get dataScores => _data.stream;

  Function(Quarters0)get addData => _data.sink.add;

  dispose(){

    _data.close();
  }


  AdditionalGameDetails();


  Future<Quarters0> fetchPost2(String uniqueID) async {
    String myPath = "gameDetails/$uniqueID";

    final response = await http
        .get(Uri.https("api-nba-v1.p.rapidapi.com", myPath), headers: {
      "x-rapidapi-host": "api-nba-v1.p.rapidapi.com",
      "x-rapidapi-key": "6e137c5c98mshcfe3870862cc847p12a327jsn818c1cb513dd"
    });

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.

      var info = json.decode(response.body);

      _data.sink.add(Quarters0.fromJson(info['api']));

      print(info['api']['statistics'][0]);

      return Quarters0.fromJson(info['api']);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

}