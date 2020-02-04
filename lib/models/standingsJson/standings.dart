import 'package:json_annotation/json_annotation.dart';

part 'standings.g.dart';

@JsonSerializable()
class Standings {
    Standings();

    String league;
    String teamId;
    String win;
    String loss;
    String gamesBehind;
    String lastTenWin;
    String lastTenLoss;
    String streak;
    String seasonYear;
    Map<String,dynamic> conference;
    Map<String,dynamic> division;
    String winPercentage;
    String lossPercentage;
    Map<String,dynamic> home;
    Map<String,dynamic> away;
    String winStreak;
    String tieBreakerPoints;
    
    factory Standings.fromJson(Map<String,dynamic> json) => _$StandingsFromJson(json);
    Map<String, dynamic> toJson() => _$StandingsToJson(this);
}
