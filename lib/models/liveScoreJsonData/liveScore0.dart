import 'package:json_annotation/json_annotation.dart';
import "liveScore01.dart";
part 'liveScore0.g.dart';

@JsonSerializable()
class LiveScore0 {
    LiveScore0();

    late String seasonYear;
    late String league;
    late String gameId;
    late String seasonStageId;
    late String statusNum;
    late String startTimeUTC;
    late String endTimeUTC;
    late String arena;
    late String city;
    late String country;
    late String clock;
    late String gameDuration;
    late String currentPeriod;
    late String halftime;
    late String endOfPeriod;
    late String seasonStage;
    late String statusShortGame;
    late String statusGame;
    late LiveScore01 vTeam;
    late LiveScore01 hTeam;
    
    factory LiveScore0.fromJson(Map<String,dynamic> json) => _$LiveScore0FromJson(json);
    Map<String, dynamic> toJson() => _$LiveScore0ToJson(this);
}
