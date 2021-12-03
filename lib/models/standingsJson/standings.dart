import 'package:json_annotation/json_annotation.dart';

part 'standings.g.dart';

@JsonSerializable()
class Standings {
    Standings();

    late String league;
    late String teamId;
    late String win;
    late String loss;
    late String gamesBehind;
    late String lastTenWin;
    late String lastTenLoss;
    late String streak;
    late String seasonYear;
    late Map<String,dynamic> conference;
    late Map<String,dynamic> division;
    late String winPercentage;
    late String lossPercentage;
    late Map<String,dynamic> home;
    late Map<String,dynamic> away;
    late String winStreak;
    late String tieBreakerPoints;
    
    factory Standings.fromJson(Map<String,dynamic> json) => _$StandingsFromJson(json);
    Map<String, dynamic> toJson() => _$StandingsToJson(this);
}
