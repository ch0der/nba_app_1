import 'package:json_annotation/json_annotation.dart';
import "liveScore01.dart";
part 'liveScore0.g.dart';

@JsonSerializable()
class LiveScore0 {
    LiveScore0();

    String seasonYear;
    String league;
    String gameId;
    String seasonStageId;
    String statusNum;
    String startTimeUTC;
    String endTimeUTC;
    String arena;
    String city;
    String country;
    String clock;
    String gameDuration;
    String currentPeriod;
    String halftime;
    String EndOfPeriod;
    String seasonStage;
    String statusShortGame;
    String statusGame;
    LiveScore01 vTeam;
    LiveScore01 hTeam;
    
    factory LiveScore0.fromJson(Map<String,dynamic> json) => _$LiveScore0FromJson(json);
    Map<String, dynamic> toJson() => _$LiveScore0ToJson(this);
}
