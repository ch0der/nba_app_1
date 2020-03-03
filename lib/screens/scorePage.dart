import 'package:flutter/material.dart';
import 'package:nba_app/PlayerInfo.dart';
import 'package:nba_app/animations/score_animation.dart';
import 'package:nba_app/blocs/gameDetailsBloc.dart';

import 'package:nba_app/library.dart';
import 'package:nba_app/models/index.dart';
import 'package:nba_app/models/liveScoreJsonData/liveGameData01.dart';
import 'package:nba_app/blocs/live_scores_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nba_app/widgets/shaderContainer.dart';

class ScorePage extends StatefulWidget {
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  final bloc = LiveScoreBloc();
  final scoreBloc = LiveStandingsBloc();
  final quarterBloc = AdditionalGameDetails();
  final playerBloc = GameDetailsBloc();
  List<PlayerInfo> someList;
  Future scoreFuture;
  final double boxHeight = 175;
  List scoreList;

  @override
  void initState() {
    super.initState();
    bloc.fetchPost2();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
    scoreBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double textHeight = 45;
    double scoreSpacing = 15;
    double iconSize = 60;

    return Scaffold(
      appBar: AppBar(
        title: Text('SCORES'),
      ),
      drawer: (Container(
        height: MediaQuery.of(context).size.height,
        width: 200,
        color: Colors.red,
        child: Text('sxfsdfsdfsdfsdfs'),
      )),
      body: Center(
        child: StreamBuilder<LiveGameData01>(
          stream: bloc.dataScores,
          builder: (context, snapshot) {
            List<dynamic> dataList;
            if (snapshot.hasData) {
              dataList = snapshot.data.games;
              scoreList = dataList;

              return Container(
                child: (snapshot.data.games.length > 0
                    ? RefreshIndicator(
                        onRefresh: () async {
                          await bloc.fetchPost2();
                        },
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.only(bottom: 15),
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                            height: 15,
                          ),
                          itemCount: dataList == null ? 0 : dataList.length,
                          itemBuilder: (BuildContext context, int index) {
                            String quarter = dataList[index]['currentPeriod'];

                            String awayLogo =
                                'assets/team_logos/${dataList[index]['vTeam']['nickName']}.png';

                            String homeLogo =
                                'assets/team_logos/${dataList[index]['hTeam']['nickName']}.png';

                            return Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Container(
                                    width: screenSize(context).width * .9,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.95),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 20,
                                          spreadRadius: 2.5,
                                          offset: Offset(10, 10),
                                        ),
                                      ],
                                    ),
                                    height: boxHeight,
                                  ),
                                  Opacity(
                                    opacity: .5,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        ShaderMask(
                                          shaderCallback: (Rect bounds) {
                                            return LinearGradient(
                                              tileMode: TileMode.mirror,
                                              colors: [Colors.white.withOpacity(.7), Colors.grey[50],Colors.grey[50],Colors.white.withOpacity(.7)],
                                              stops: [
                                                0.0,
                                                .4,
                                                .6,
                                                1,
                                              ],
                                            ).createShader(bounds);
                                          },
                                          blendMode: BlendMode.srcATop,
                                          child: Row(
                                            children: <Widget>[
                                              containerImage( "assets/collages/${dataList[index]['vTeam']['shortName']}away.jpg"),
                                        containerImage("assets/collages/${dataList[index]['hTeam']['shortName']}home.jpg"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: screenSize(context).width,
                                    height: boxHeight,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                    child: FlatButton(

                                      onPressed: (){
                                        onPressed(index);
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  "Q ${quarter.replaceAll('/4', '')}",
                                                  style: TextStyle(
                                                      fontFamily: 'Alatsi',
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  width: 15,
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      dataList[index]['vTeam']
                                                          ['shortName'],
                                                      style: TextStyle(
                                                          fontFamily: 'Alatsi',
                                                          fontSize: 15),
                                                    ),
                                                    Container(
                                                      height: iconSize,
                                                      width: iconSize,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              awayLogo),
                                                        ),
                                                      ),
                                                    ),
                                                    StreamBuilder(stream: scoreBloc.dataScores,
                                                      builder:
                                                          (context, snapshot2) {
                                                        String record;
                                                        if (snapshot2.hasData) {
                                                          record = snapshot2
                                                                      .data[
                                                                  'standings'][
                                                              '${dataList[index]['vTeam']['shortName']}'];
                                                          return (Container(
                                                            child: Text(
                                                              '($record)',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ));
                                                        } else {
                                                          return Container();
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: Container()),
                                                Text(
                                                  dataList[index]['vTeam']
                                                      ['score']['points'],
                                                  style: TextStyle(
                                                      fontFamily: 'Alatsi',
                                                      fontSize: textHeight),
                                                ),
                                                Container(
                                                  width: scoreSpacing,
                                                ),
                                                Text(
                                                  '-',
                                                  style: TextStyle(
                                                      fontFamily: 'Alatsi',
                                                      fontSize: textHeight),
                                                ),
                                                Container(
                                                  width: scoreSpacing,
                                                ),
                                                Text(
                                                  dataList[index]['hTeam']
                                                      ['score']['points'],
                                                  style: TextStyle(
                                                      fontFamily: 'Alatsi',
                                                      fontSize: textHeight),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: Container()),
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      dataList[index]['hTeam']
                                                          ['shortName'],
                                                      style: TextStyle(
                                                          fontFamily: 'Alatsi',
                                                          fontSize: 15),
                                                    ),
                                                    _logoContainer(
                                                        iconSize, homeLogo),
                                                    StreamBuilder(
                                                      stream:
                                                          scoreBloc.dataScores,
                                                      builder:
                                                          (context, snapshot2) {
                                                        String record;
                                                        if (snapshot2.hasData) {
                                                          record = snapshot2
                                                                      .data[
                                                                  'standings'][
                                                              '${dataList[index]['hTeam']['shortName']}'];
                                                          return (Container(
                                                            child: Text(
                                                              '($record)',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ));
                                                        } else {
                                                          return Container();
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: 15,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Center(
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  child: _halfTime(
                                                      dataList[index]
                                                          ['halftime'],
                                                      dataList[index]['clock'],
                                                      33),
                                                ),
                                                ScoreAnimation(),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : Container(
                        child: Text('Endpoint Outage'),
                      )),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
  onPressed(int index){
    String awayLogo =
        'assets/team_logos/${scoreList[index]['vTeam']['nickName']}.png';

    String homeLogo =
        'assets/team_logos/${scoreList[index]['hTeam']['nickName']}.png';
    final Future<LiveGame1> future = playerBloc.fetchPost2(scoreList[index]['gameId']);
    future.then((resp) {
      someList = resp.statistics
          .map((index1) => PlayerInfo(
          gameId: index1['gameId'],
          min: index1['min'],
          teamId: index1['teamId'],
          points: "${index1['points']}".isNotEmpty ? int.parse(index1['points']) : 0,
          pos: index1['pos'],
          fgm: index1['fgm'],
          fga: index1['fga'],
          fta: index1['fta'],
          fgp: index1['fgp'],
          ftm: index1['ftm'],
          ftp: index1['ftp'],
          defReb: index1['defReb'],
          offReb: index1['offReb'],
          blocks: index1['blocks'],
          totReb: "${index1['totReb']}".isNotEmpty ? int.parse(index1['totReb']): 0,
          playerId: index1['playerId'],
          pFouls: index1['pFouls'],
          plusMinus: "${index1['plusMinus']}".isNotEmpty ? int.parse(index1['plusMinus']) : 0,
          tpa: index1['tpa'],
          tpm: index1['tpm'],
          tpp: index1['tpp'],
          turnovers: index1['turnovers'],
          assists: "${index1['assists']}".isNotEmpty ? int.parse(index1['assists']): 0,
          steals: index1['steals']))
          .toList();
    });
    future.then((resp2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GameDetailScreen(
            gameId: scoreList[index]['gameId'],
            homeId: scoreList[index]['hTeam']['teamId'],
            awayId: scoreList[index]['vTeam']['teamId'],
            playerDetailsList: someList,
            homeLogo: homeLogo,
            awayLogo: awayLogo,
            homeFullName: scoreList[index]['hTeam']['fullName'],
            awayFullName: scoreList[index]['vTeam']['fullName'],
            homeNickname: scoreList[index]['hTeam']['nickName'],
            awayNickname: scoreList[index]['vTeam']['nickName'],
            homeShort: scoreList[index]['hTeam']['shortName'],
            awayShort: scoreList[index]['vTeam']['shortName'],
          ),
          // Pass the arguments as part of the RouteSettings. The
          // DetailScreen reads the arguments from these settings.
          settings: RouteSettings(),
        ),
      );
    });

  }

  containerImage(String image){
    return  Container(
      width: screenSize(context).width *.45,
      height: boxHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
              image),
        ),
      ),
    );
  }

  Future<LiveGame1> fetchPost4(String uniqueID) async {
    String myPath = "statistics/players/gameId/$uniqueID";

    final response = await http
        .get(Uri.https("api-nba-v1.p.rapidapi.com", myPath), headers: {
      "x-rapidapi-host": "api-nba-v1.p.rapidapi.com",
      "x-rapidapi-key": "6e137c5c98mshcfe3870862cc847p12a327jsn818c1cb513dd"
    });

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.

      var info = json.decode(response.body);

      print(info['api']);

      return LiveGame1.fromJson(info['api']);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Container _logoContainer(double size, String logo) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(logo),
      )),
    );
  }

  shaderContainer(String imageString, double stop2) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
      ),
      width: screenSize(context).width * .45,
      height: boxHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
        child: ShaderMask(
          child: Image(
            image: AssetImage(imageString),
          ),
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              tileMode: TileMode.mirror,
              colors: [Colors.white.withOpacity(.7), Colors.white],
              stops: [
                0.0,
                stop2,
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
        ),
      ),
    );
  }

  buildBody() {
    return Column(
      children: <Widget>[
        Container(
          height: 100,
        ),
        listTileContainer(),
      ],
    );
  }

  Widget _halfTime(halftime, String index1, double height) {
    if (halftime == "1") {
      return Text(
        "halftime",
        style: TextStyle(fontFamily: 'Alatsi', fontSize: 20),
      );
    } else {
      return Text(
        index1,
        style: TextStyle(fontFamily: 'Alatsi', fontSize: height),
      );
    }
  }

  listTileContainer() {
    return Center(
      child: Container(
          width: screenSize(context).width * .9,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1),
              bottom: BorderSide(width: 1),
              left: BorderSide(width: 1),
              right: BorderSide(width: 1),
            ),
          ),
          height: boxHeight,
          child: Column(
            children: <Widget>[
              gameTimeContainer(),
              scoreContainer(),
            ],
          )),
    );
  }

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  scoreContainer() {
    double textHeight = 45;
    double scoreSpacing = 15;

    return Center(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '127',
              style: TextStyle(fontFamily: 'Alatsi', fontSize: textHeight),
            ),
            Container(
              width: scoreSpacing,
            ),
            Text(
              '-',
              style: TextStyle(fontFamily: 'Alatsi', fontSize: textHeight),
            ),
            Container(
              width: scoreSpacing,
            ),
            Text(
              '136',
              style: TextStyle(fontFamily: 'Alatsi', fontSize: textHeight),
            ),
          ],
        ),
      ),
    );
  }

  gameTimeContainer() {
    double textHeight = 20;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Q4',
            style: TextStyle(fontFamily: 'Alatsi', fontSize: textHeight),
          ),
          Container(
            width: 20,
          ),
          Text(
            '03:49',
            style: TextStyle(fontFamily: 'Alatsi', fontSize: textHeight),
          ),
        ],
      ),
    );
  }
}
