import 'package:flutter/material.dart';
import 'package:nba_app/animations/score_animation.dart';
import 'package:nba_app/blocs/gameDetailsBloc.dart';

import 'package:nba_app/library.dart';
import 'package:nba_app/models/index.dart';
import 'package:nba_app/models/liveScoreJsonData/liveGameData01.dart';
import 'package:nba_app/blocs/live_scores_bloc.dart';
import 'dart:async';

class GameDetailScreen extends StatefulWidget {
  GameDetailScreen({this.gameId});

  final String gameId;

  @override
  _GameDetailScreenState createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  final bloc2 = GameDetailsBloc();
  final bloc3 = AdditionalGameDetails();
  SliverPersistentHeaderDelegate _test;

  @override
  void initState() {
    super.initState();
    bloc2.fetchPost2(widget.gameId);
    bloc3.fetchPost2(widget.gameId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body());
  }

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  quarterPoints() {
    return Container(
      child: StreamBuilder<Quarters0>(
        stream: bloc3.dataScores,
        builder: (context, snapshot) {
          List<dynamic> dataList;
          if (snapshot.hasData){
            int quarter;
            dataList = snapshot.data.game;
            List<dynamic> vTeam = dataList[0]['vTeam']['score']['linescore'];
            return Container(
              child: Row(
                children: <Widget>[
                  Text(dataList[0]['vTeam']['score']['linescore'][0]),
                  Text(vTeam[1]),
                  Text(vTeam[2]),
                  Text(vTeam[3]),

                ],
              ),
              
            );
          }else return Container();
          
        },
        
      ),
    );
  }

  body() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          expandedHeight: 50,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Test'),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              quarterPoints(),
              Container(
                height: 100,
                width: 200,
                color: Colors.orange,
              ),
              Container(
                height: 100,
                width: 200,
                color: Colors.blue,
              ),
              Container(
                height: 100,
                width: 200,
                color: Colors.orange,
              ),
              Container(
                height: 100,
                width: 200,
                color: Colors.blue,
              ),
              Container(
                height: 100,
                width: 200,
                color: Colors.orange,
              ),
              Container(
                height: 100,
                width: 200,
                color: Colors.blue,
              ),
            ],
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate: _Delegate(
              child: Container(
                height: 200,
                child: _table(),
              ),
              maxHeight: 200,
              minHeight: 50),
        ),
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate: _Delegate(
              child: Container(
                height: 200,
                child: _table(),
              ),
              maxHeight: 200,
              minHeight: 50),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                height: 15,
                width: 200,
              ),
              Container(
                height: 100,
                width: 200,
                color: Colors.blue,
              ),
              Container(
                height: 100,
                width: 200,
                color: Colors.orange,
              ),
              Container(
                height: 100,
                width: 200,
                color: Colors.blue,
              ),
              Container(
                height: 100,
                width: 200,
                color: Colors.orange,
              ),
              Container(
                height: 400,
                width: 200,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _table() {
    return Container(
      child: StreamBuilder<LiveGame1>(
        stream: bloc2.dataScores,
        builder: (context, snapshot) {
          List<dynamic> dataList;
          if (snapshot.hasData) {
            dataList = snapshot.data.statistics;
            return RefreshIndicator(
              onRefresh: () async {
                await bloc2.fetchPost2(widget.gameId);
              },
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      DataTable(
                        horizontalMargin: 24,
                        dataRowHeight: 40,
                        columnSpacing: 1,
                        columns: [
                          DataColumn(
                            label: Text('PlayerID'),
                          ),
                          DataColumn(label: Text('PTS')),
                          DataColumn(label: Text('AST')),
                          DataColumn(label: Text('REB')),
                          DataColumn(label: Align(child: Text('+/-'))),
                        ],
                        rows: dataList
                            .map(
                              (index) => DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      index['playerId'],
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      index['points'],
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      index['assists'],
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      index['totReb'],
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        index['plusMinus'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class _Delegate extends SliverPersistentHeaderDelegate {
  _Delegate(
      {@required this.child,
      @required this.maxHeight,
      @required this.minHeight});

  double minHeight;
  double maxHeight;

  Widget child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  double get maxExtent {
    return maxHeight;
  }

  @override
  double get minExtent {
    return minHeight;
  }
}
