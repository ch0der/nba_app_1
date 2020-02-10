import 'package:json_annotation/json_annotation.dart';

part 'liveGameDetails.g.dart';

@JsonSerializable()
class LiveGameDetails {
    LiveGameDetails();

    String gameId;
    String teamId;
    String points;
    String pos;
    String min;
    String fgm;
    String fga;
    String fgp;
    String ftm;
    String fta;
    String ftp;
    String tpm;
    String tpa;
    String tpp;
    String offReb;
    String defReb;
    String totReb;
    String assists;
    String pFouls;
    String steals;
    String turnovers;
    String blocks;
    String plusMinus;
    String playerId;
    
    factory LiveGameDetails.fromJson(Map<String,dynamic> json) => _$LiveGameDetailsFromJson(json);
    Map<String, dynamic> toJson() => _$LiveGameDetailsToJson(this);
}
