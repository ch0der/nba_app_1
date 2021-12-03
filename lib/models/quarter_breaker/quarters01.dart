import 'package:json_annotation/json_annotation.dart';

part 'quarters01.g.dart';

@JsonSerializable()
class Quarters01 {
    Quarters01();

    late String seasonYear;
    late String league;
    late String gameId;
    late String startTimeUTC;
    late String endTimeUTC;
    late String arena;
    late String city;
    late String country;
    late String clock;
    late String gameDuration;
    late String timesTied;
    late String leadChanges;
    late String currentPeriod;
    late String halftime;
    late String endOfPeriod;
    late String seasonStage;
    late String statusShortGame;
    late String statusGame;
    late Map<String,dynamic> vTeam;
    late Map<String,dynamic> hTeam;
    late List officials;
    
    factory Quarters01.fromJson(Map<String,dynamic> json) => _$Quarters01FromJson(json);
    Map<String, dynamic> toJson() => _$Quarters01ToJson(this);
}
