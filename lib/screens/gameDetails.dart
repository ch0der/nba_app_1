import 'package:flutter/material.dart';
import 'package:nba_app/PlayerInfo.dart';
import 'package:nba_app/animations/score_animation.dart';
import 'package:nba_app/blocs/gameDetailsBloc.dart';

import 'package:nba_app/library.dart';
import 'package:nba_app/models/index.dart';
import 'package:nba_app/models/liveScoreJsonData/liveGameData01.dart';
import 'package:nba_app/blocs/live_scores_bloc.dart';
import 'dart:async';

class GameDetailScreen extends StatefulWidget {
  GameDetailScreen({this.gameId, this.homeId, this.awayId,this.playerDetailsList});

  final String gameId;
  final String homeId;
  final String awayId;
  final List playerDetailsList;

  @override
  _GameDetailScreenState createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  final bloc2 = GameDetailsBloc();
  final bloc3 = AdditionalGameDetails();
  SliverPersistentHeaderDelegate _test;
  List<PlayerStats> players;
  List testList;
  bool ascending = true;
  bool assistBool = true;

  @override
  void initState() {
    super.initState();
    bloc2.fetchPost2(widget.gameId);
    bloc3.fetchPost2(widget.gameId);
  }

  void dispose() {
    super.dispose();
    bloc2.dispose();
    bloc3.dispose();
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
          if (snapshot.hasData) {
            List<dynamic> dataList;
            int quarter;
            dataList = snapshot.data.game;
            List<dynamic> vTeam = dataList[0]['vTeam']['score']['linescore'];
            return Container(
              child: Row(
                children: <Widget>[
                  Text(vTeam[0]),
                  Text(vTeam[1]),
                  Text(vTeam[2]),
                  Text(vTeam[3]),
                ],
              ),
            );
          } else
            return Container();
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
            ],
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate: _Delegate(
              child: Container(
                height: 200,
                child: _table(widget.homeId),
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
                child: _testTable(),
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
  List getPlayers(List list) {
        return list.map(
          (index) => PlayerStats(
          id: index['playerId'],
          pts: index['pos'],
          ast: index['assists'],
          reb: index['totReb'],
          plusMin: index['plusMinus']),
    )
        .toList();
  }



  _table(String team) {
    return Container(
      child: StreamBuilder<LiveGame1>(
        stream: bloc2.dataScores,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> dataList;
            dataList = snapshot.data.statistics;
            List homeList2 =
                dataList.where((index1) => index1['teamId'] == team).toList();

            testList = homeList2;


            players = getPlayers(testList);
            print(players[3].pts);
            return RefreshIndicator(
              onRefresh: () async {
                await bloc2.fetchPost2(widget.gameId);
              },
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      DataTable(
                        sortAscending: ascending,
                        sortColumnIndex: 0,
                        horizontalMargin: 24,
                        dataRowHeight: 40,
                        columnSpacing: 1,
                        columns: [
                          DataColumn(
                            onSort: (i,b){
                              onSortColumn(b);
                            },
                            label: Text('PlayerID'),
                          ),
                          DataColumn(
                              onSort: (i,b){
                                onSortColumn(ascending);
                                setState(() {
                                  ascending = !ascending;
                                });

                              },
                              label: Text('PTS')),
                          DataColumn(label: Text('AST')),
                          DataColumn(label: Text('REB')),
                          DataColumn(label: Align(child: Text('+/-'))),
                        ],
                        rows: players.map((player) => DataRow(

                            cells: [
                              DataCell(
                                  Text(player.id)
                              ),
                              DataCell(
                                  Text((player.pts))
                              ),
                              DataCell(
                                  Text(player.ast)
                              ),
                              DataCell(
                                  Text(player.reb)
                              ),
                              DataCell(
                                  Text(player.plusMin)
                              ),
                            ]
                        )).toList(),
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
  onSortColumn(bool sort){
    List<PlayerInfo> _list = widget.playerDetailsList;
    if(sort == true){
      _list.sort((a,b)=> a.assists.compareTo(b.assists));
      setState(() {
        sort = false;
      });
    } else if(sort == false){
     _list.sort((a,b)=> b.assists.compareTo(a.assists));
      setState(() {
        sort = true;
      });
    }
    print(sort);
  }
  _testTable(){

    List<PlayerInfo> playerList = widget.playerDetailsList;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DataTable(
              sortAscending: ascending,
              sortColumnIndex: 1,
              horizontalMargin: 24,
              dataRowHeight: 30,
              columnSpacing: 2,
              columns: [
                DataColumn(
                  onSort: (i,b){
                    onSortColumn(b);
                  },
                  label: Text('PlayerID'),
                ),
                DataColumn(
                    numeric: true,
                    onSort: (i,b){
                      if(ascending == true){
                        playerList.sort((a,b)=> a.points.compareTo(b.points));
                        setState(() {
                          ascending = false;
                        });
                      } else
                      if(ascending == false){
                        playerList.sort((a,b)=> b.points.compareTo(a.points));
                        setState(() {
                          ascending = true;
                        });
                      }
                      print(ascending);

                    },
                    label: Text('PTS')),
                DataColumn(
                  numeric: true,
                  onSort: (i,b){

                    if(assistBool== true){
                      playerList.sort((a,b)=> a.assists.compareTo(b.assists));
                      setState(() {
                        assistBool = false;
                      });
                    } else if(assistBool == false){
                      playerList.sort((a,b)=> b.assists.compareTo(a.assists));
                      setState(() {
                        assistBool = true;
                      });
                    }

                  },

                    label: Text('AST')),
                DataColumn(
                    numeric: true,
                    label: Text('REB')),
                DataColumn(
                    numeric: true,
                    label: Align(child: Text('+/-'))),
                DataColumn(
                    label: Text('MIN')),
                DataColumn(
                    numeric: true,
                    label: Text('POS')),
              ],
              rows: playerList.map((player) => DataRow(

                  cells: [
                    DataCell(
                        Text(player.playerId)
                    ),
                    DataCell(
                        Text('${player.points}')
                    ),
                    DataCell(
                        Text('${player.assists}'),
                    ),
                    DataCell(
                        Text(player.totReb)
                    ),
                    DataCell(
                        Text(player.plusMinus)
                    ),
                    DataCell(
                        Align(alignment: Alignment.centerRight,
                            child: Text(player.min))
                    ),
                    DataCell(
                        Text(player.pos)
                    ),
                  ]
              )).toList(),
            ),
          ],
        ),
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

class PlayerStats {
  String id;
  String pts;
  String ast;
  String reb;
  String plusMin;

  PlayerStats({this.id, this.pts, this.ast, this.reb, this.plusMin});
}
