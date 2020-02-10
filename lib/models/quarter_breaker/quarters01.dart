import 'package:json_annotation/json_annotation.dart';

part 'quarters01.g.dart';

@JsonSerializable()
class Quarters01 {
    Quarters01();

    String seasonYear;
    String league;
    String gameId;
    String startTimeUTC;
    String endTimeUTC;
    String arena;
    String city;
    String country;
    String clock;
    String gameDuration;
    String timesTied;
    String leadChanges;
    String currentPeriod;
    String halftime;
    String EndOfPeriod;
    String seasonStage;
    String statusShortGame;
    String statusGame;
    Map<String,dynamic> vTeam;
    Map<String,dynamic> hTeam;
    List officials;
    
    factory Quarters01.fromJson(Map<String,dynamic> json) => _$Quarters01FromJson(json);
    Map<String, dynamic> toJson() => _$Quarters01ToJson(this);
}
