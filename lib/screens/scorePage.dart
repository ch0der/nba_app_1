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
import 'package:intl/intl.dart';

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
  DefaultTabController _defaultTabController;
  final DateTime now = DateTime.now();


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

    TextStyle styleOne = TextStyle(fontSize:  textHeight,fontFamily: 'Alatsi');

    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(73, 92, 117, 1),
          title:  TabBar(
            indicatorColor: Colors.orange,
            tabs: <Widget>[
              Tab(child: tabTab(now.subtract(Duration(days: 1))),),
              Tab(child: tabTab(now)),
              Tab(child: tabTab(now.add(Duration(days: 1))),),
            ],
          ),

        ),
        drawer: (Container(
          height: MediaQuery.of(context).size.height,
          width: 200,
          color: Colors.grey[50],
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
                dateInfo();

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
                              String awy = 'assets/team_logos/${dataList[index]['vTeam']['nickName']}.png';
                              String home =  'assets/team_logos/${dataList[index]['hTeam']['nickName']}.png';

                              String awayLogo =
                               awy.contains(' ') ? 'assets/team_logos/TrailBlazers.png' : awy;

                              String homeLogo =
                                 home.contains(' ') ? 'assets/team_logos/TrailBlazers.png' : home;
                              return Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    filter1(),
                                    Opacity(
                                      opacity: .5,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          filter2(dataList,index),

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
                                          onPressed(index,homeLogo,awayLogo);
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "Q${quarter.replaceAll('/4', '')}".replaceAll('Q5', 'OT').replaceAll('Q6', '2OT'),
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
                                                  ), //spaces info to the right
                                                  logoColumn(dataList, index, iconSize, awayLogo, 'vTeam'),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Container()), // SPACER
                                                  scoreInfo(dataList, index, textHeight, 'vTeam',styleOne),
                                                  Container(
                                                    width: scoreSpacing,
                                                  ),
                                                  Text(
                                                    '-',
                                                    style: styleOne,
                                                  ),
                                                  Container(
                                                    width: scoreSpacing,
                                                  ),
                                                  scoreInfo(dataList, index, textHeight, 'hTeam',styleOne),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Container()),
                                                  logoColumn(dataList, index, iconSize, homeLogo, 'hTeam'),
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
                                                        dataList[index]['clock'],33),
                                                  ),
                                                  dataList[index]['clock'].toString().isNotEmpty ? ScoreAnimation : Container(),
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
      ),
    );
  }
  dateInfo(){
    DateTime now = DateTime.now();
    DateTime yest = now.subtract(Duration(days: 1));
    DateTime tmrw = now.add(Duration(days: 1));

    return Row(
      children: <Widget>[
        Text("Scores:"),
        Container(width: 15,),
        Text(DateFormat('EEE').format(yest).toString()),
        Container(width: 15,),
        Text(DateFormat('EEE').format(now).toString(),style: TextStyle(color: Colors.lightGreenAccent[400]),),
        Container(width: 15,),
        Text(DateFormat('EEE').format(tmrw).toString()),
      ],
    );

  }
  tabTab(DateTime time){
    return Center(
      child: Text(
        DateFormat('EEE,\nMMM d').format(time).toString()
      ),
    );
  }

  filter1(){
    return    Container(
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
    );
  }
  filter2(List _list, int index){
    return  ShaderMask(
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
          containerImage( "assets/collages/${_list[index]['vTeam']['shortName']}away.jpg"),
          containerImage("assets/collages/${_list[index]['hTeam']['shortName']}home.jpg"),
        ],
      ),
    );
  }
  logoColumn(List _list, int index,double iconSize,String logo,String awayOrHome){
    return Column(
      children: <Widget>[
        Text(
          _list[index][awayOrHome]
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
                  logo),
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
              '${_list[index][awayOrHome]['shortName']}'];
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
    );
  }
  scoreInfo(List _list, int index,double _size,String homeOrAway,TextStyle _style){
   return Text(
    _list[index][homeOrAway]
      ['score']['points'],
      style: _style
    );
  }
  onPressed(int index,String hLogo,String aLogo){
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
            homeLogo: hLogo,
            awayLogo: aLogo,
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
