import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nba_app/models/index.dart';
import 'package:nba_app/models/liveScoreJsonData/liveGameData01.dart';
import 'package:nba_app/blocs/live_scores_bloc.dart';

class ScorePage extends StatefulWidget {
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {

 liveTest(){
    return LiveScore0(

    );
 }

  final bloc = LiveScoreBloc();

  @override
  void initState() {
    super.initState();
    bloc.fetchPost2();
  }

  @override
  Widget build(BuildContext context) {
    double textHeight = 45;
    double scoreSpacing = 15;

    return Scaffold(
      bottomSheet: (Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        color: Colors.orange.withOpacity(.5),
      )),

      drawer: (Container(
        height: MediaQuery.of(context).size.height,
        width: 200,
        color: Colors.red,
        child: Text('sxfsdfsdfsdfsdfs'),
      )),
      appBar: AppBar(
       title: Center(child: Text('SCORES'),),

      ),
      body: Center(
        child: StreamBuilder<LiveGameData01>(
          stream: bloc.dataScores,
          builder: (context, snapshot) {
            List<dynamic> dataList;
            if (snapshot.hasData) {
             dataList = snapshot.data.games;



              return ListView.separated(
                separatorBuilder: (BuildContext context, int index) => Container(height: 15,) ,
                itemCount: dataList == null ? 0 : dataList.length,
                itemBuilder: (BuildContext context, int index) {
                 String quarter = dataList[index]['currentPeriod'];
                 String awayLogo = 'assets/team_logos/${dataList[index]['vTeam']['nickName']}.png';
                 String homeLogo = 'assets/team_logos/${dataList[index]['hTeam']['nickName']}.png';
                 String trailBlazers = 'assets/team_logos/Trail Blazers';

                 Widget _halfTime(halftime){
                   if(halftime =="1"){
                     return Text(
                       "halftime",
                       style: TextStyle(
                           fontFamily: 'Alatsi',
                           fontSize: textHeight),
                     );
                   } else {
                     return Text(
                       dataList[index]['clock'],
                       style: TextStyle(
                           fontFamily: 'Alatsi',
                           fontSize: textHeight),
                     );
                   }
                 }

                  return Center(
                    child: Container(
                        width: screenSize(context).width * .9,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
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
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Q ${quarter.replaceAll('/4','')}",
                                    style: TextStyle(
                                        fontFamily: 'Alatsi',
                                        fontSize: textHeight),
                                  ),
                                  Container(
                                    width: 20,
                                  ),
                                  Text(
                                    dataList[index]['vTeam']['shortName'],
                                    style: TextStyle(
                                        fontFamily: 'Alatsi',
                                        fontSize: textHeight),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 75,
                                    width: 75,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(awayLogo),
                                      )
                                    ),
                                  ),
                                  Text(
                              dataList[index]['vTeam']['score']['points'],
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
                                    dataList[index]['hTeam']['score']['points'],
                                    style: TextStyle(
                                        fontFamily: 'Alatsi',
                                        fontSize: textHeight),
                                  ),
                                  Container(
                                    height: 75,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(homeLogo),
                                        ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Container(
                                child: _halfTime(dataList[index]['halftime']),

                              ),

                            ),
                          ],
                        )),
                  );
                },
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
