import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nba_app/models/index.dart';
import 'package:nba_app/models/live_game_details/liveGame1.dart';
import 'package:rxdart/rxdart.dart';
import 'package:nba_app/API_KEY.dart' show API_KEY;


class GameDetailsBloc {
  final _data = BehaviorSubject<LiveGame1>();

  Stream<LiveGame1> get dataScores => _data.stream;


  Function(LiveGame1) get addData => _data.sink.add;

  dispose() {
    _data.close();
  }

  GameDetailsBloc();


  Future<LiveGame1> fetchPost2(String uniqueID) async {
    String myPath = "statistics/players/gameId/$uniqueID";

    final response = await http
        .get(Uri.https(API_KEY, myPath), headers: {
      "x-rapidapi-host": API_KEY,
      "x-rapidapi-key": "REDACTED"
    });

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.

      var info = json.decode(response.body);

      _data.sink.add(LiveGame1.fromJson(info['api']));


      return LiveGame1.fromJson(info['api']);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
  Future<LiveGame1> fetchPost3(String uniqueID) async {
    String myPath = "statistics/players/gameId/$uniqueID";

    final response = await http
        .get(Uri.https(API_KEY, myPath), headers: {
      "x-rapidapi-host": API_KEY,
      "x-rapidapi-key": "REDACTED"
    });

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.

      var info = json.decode(response.body);

      print( info['api']);



      return LiveGame1.fromJson(info['api']);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

}

class AdditionalGameDetails {
  final _data = BehaviorSubject<Quarters0>();

  Stream<Quarters0> get dataScores => _data.stream;

  Function(Quarters0) get addData => _data.sink.add;

  dispose() {
    _data.close();
  }

  AdditionalGameDetails();

  Future<Quarters0> fetchPost2(String uniqueID) async {
    String myPath = "gameDetails/$uniqueID";

    final response = await http
        .get(Uri.https(API_KEY, myPath), headers: {
      "x-rapidapi-host": API_KEY,
      "x-rapidapi-key": "REDACTED"
    });

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.

      var info = json.decode(response.body);

      _data.sink.add(Quarters0.fromJson(info['api']));

      return Quarters0.fromJson(info['api']);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}

class PlayerNames{

  final playerData = BehaviorSubject<Map<String,dynamic>>();

  Stream<Map<String,dynamic>> get playerNames => playerData.stream;
  Function(Map<String,dynamic>)get addData => playerData.sink.add;

  dispose(){
    playerData.close();
  }

  PlayerNames(){
    fetchNames();
  }
}

Future fetchNames() async {
}

