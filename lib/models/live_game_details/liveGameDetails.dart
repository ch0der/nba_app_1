import 'package:json_annotation/json_annotation.dart';

part 'liveGameDetails.g.dart';

@JsonSerializable()
class LiveGameDetails {
    LiveGameDetails();

    late String gameId;
    late String teamId;
    late String points;
    late String pos;
    late String min;
    late String fgm;
    late String fga;
    late String fgp;
    late String ftm;
    late String fta;
    late String ftp;
    late String tpm;
    late String tpa;
    late String tpp;
    late String offReb;
    late String defReb;
    late String totReb;
    late String assists;
    late String pFouls;
    late String steals;
    late String turnovers;
    late String blocks;
    late String plusMinus;
    late String playerId;
    
    factory LiveGameDetails.fromJson(Map<String,dynamic> json) => _$LiveGameDetailsFromJson(json);
    Map<String, dynamic> toJson() => _$LiveGameDetailsToJson(this);
}
