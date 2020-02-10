import 'package:flutter/material.dart';
import 'package:nba_app/animations/score_animation.dart';
import 'package:nba_app/blocs/gameDetailsBloc.dart';

import 'package:nba_app/library.dart';
import 'package:nba_app/models/index.dart';
import 'package:nba_app/models/liveScoreJsonData/liveGameData01.dart';
import 'package:nba_app/blocs/live_scores_bloc.dart';

class ScorePage extends StatefulWidget {
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  final bloc = LiveScoreBloc();
  final scoreBloc = LiveStandingsBloc();

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
      drawer: (Container(
        height: MediaQuery.of(context).size.height,
        width: 200,
        color: Colors.red,
        child: Text('sxfsdfsdfsdfsdfs'),
      )),
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        title: Text('NBA SCORES'),
      ),
      body: Center(
        child: StreamBuilder<LiveGameData01>(
          stream: bloc.dataScores,
          builder: (context, snapshot) {
            List<dynamic> dataList;
            if (snapshot.hasData) {
              dataList = snapshot.data.games;

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
                                    height: 200,
                                  ),
                                  Opacity(
                                    opacity: .5,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              bottomLeft: Radius.circular(8),
                                            ),
                                          ),
                                          width:
                                              screenSize(context).width * .45,
                                          height: 200,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              bottomLeft: Radius.circular(8),
                                            ),
                                            child: ShaderMask(
                                              child: Image(
                                                image: AssetImage(
                                                    "assets/collages/${dataList[index]['vTeam']['shortName']}away.jpg"),
                                              ),
                                              shaderCallback: (Rect bounds) {
                                                return LinearGradient(
                                                  tileMode: TileMode.mirror,
                                                  colors: [
                                                    Colors.white
                                                        .withOpacity(.7),
                                                    Colors.white
                                                  ],
                                                  stops: [
                                                    0.0,
                                                    .7,
                                                  ],
                                                ).createShader(bounds);
                                              },
                                              blendMode: BlendMode.srcATop,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width:
                                              screenSize(context).width * .45,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8),
                                              bottomRight: Radius.circular(8),
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8),
                                              bottomRight: Radius.circular(8),
                                            ),
                                            child: ShaderMask(
                                              child: Image(
                                                image: AssetImage(
                                                    "assets/collages/${dataList[index]['hTeam']['shortName']}home.jpg"),
                                              ),
                                              shaderCallback: (Rect bounds) {
                                                return LinearGradient(
                                                  tileMode: TileMode.mirror,
                                                  colors: [
                                                    Colors.white
                                                        .withOpacity(.7),
                                                    Colors.white
                                                  ],
                                                  stops: [
                                                    0.0,
                                                    .85,
                                                  ],
                                                ).createShader(bounds);
                                              },
                                              blendMode: BlendMode.srcATop,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: null,
                                    onLongPress: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GameDetailScreen(gameId: dataList[index]['gameId'],),
                                          // Pass the arguments as part of the RouteSettings. The
                                          // DetailScreen reads the arguments from these settings.
                                          settings: RouteSettings(
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: screenSize(context).width * .9,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
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
                                                    StreamBuilder(
                                                      stream:
                                                          scoreBloc.dataScores,
                                                      builder:
                                                          (context, snapshot2) {
                                                        List<dynamic>
                                                            standingsList;
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
                                                        List<dynamic>
                                                            standingsList;
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
                        child: Text('API ERROR'),
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

  Color _color(String team) {
    String test = team;

    switch (test) {
      case "LAL":
        {
          return Color.fromRGBO(255, 249, 82, 1);
        }
        break;
      case "SAS":
        {
          return Colors.black;
        }
        break;
      case "HOU":
        {
          return Colors.red;
        }
        break;
      case "POR":
        {
          return Colors.deepOrange;
        }
        break;
    }
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
          height: 200,
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
