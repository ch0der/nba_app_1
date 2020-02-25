import 'package:flutter/material.dart';
import 'package:nba_app/PlayerInfo.dart';
import 'package:nba_app/blocs/gameDetailsBloc.dart';

import 'package:nba_app/models/index.dart';

class GameDetailScreen extends StatefulWidget {
  GameDetailScreen(
      {this.gameId, this.homeId, this.awayId, this.playerDetailsList});

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
  List testList;
  bool ascending = true;
  bool assistBool = true;
  List<PlayerInfo> homeList1;
  List<PlayerInfo> awayList1;
  bool pointsSort = true;
  bool assistsSort = true;
  bool rebSort = true;
  bool plusMinSort = true;
  double sortWidth = 50;

  @override
  void initState() {
    super.initState();
    List<PlayerInfo> players = widget.playerDetailsList;
    homeList1 =
        players.where((index) => index.teamId == widget.homeId).toList();
    awayList1 =
        players.where((index) => index.teamId == widget.awayId).toList();
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
    PlayerInfo player;
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            height: 150,
          ),
          _columnHeaders(),
          Column(
            children: <Widget>[
              Container(
                height: screenSize(context).height * (1 / 3),
                child: _testTable(homeList1),
              ),
            ],
          ),
          Container(
            height: screenSize(context).height * (1 / 3),
            child: _testTable(awayList1),
          ),
        ],
      ),
    );
  }

  _columnHeaders() {
    return Center(
      child: Container(
        width: screenSize(context).width * .8,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: sortPoints(homeList1, 'Player'),
            ),
            Expanded(
              flex: 1,
              child: sortPoints(homeList1, 'Pts'),
            ),

            Expanded(child: sortAssists(homeList1, 'Ast')),
            Expanded(child: sortAssists(homeList1, 'Ast')),
            Expanded(child: sortAssists(homeList1, 'Ast')),
            Expanded(child: sortAssists(homeList1, 'Ast')),
            Expanded(child: sortAssists(homeList1, 'Ast')),
          ],
        ),
      ),
    );
  }


  testSort(List<PlayerInfo> _list, bool point2s, Function fn) {
    return RaisedButton(
      onPressed: () {
        fn(_list);
      },
      child: Container(
        height: 40,
        width: 40,
        child: Text('points'),
      ),
    );
  }

  onSortColumn(bool sort, List _list1) {
    List<PlayerInfo> _list = _list1;
    if (sort == true) {
      _list.sort((a, b) => b.assists.compareTo(a.assists));
      setState(() {
        sort = false;
      });
    } else if (sort == false) {
      _list.sort((a, b) => a.assists.compareTo(b.assists));
      setState(() {
        sort = true;
      });
    }
  }

  sort(List<PlayerInfo> _list) {
    _list.sort((a, b) => a.points.compareTo(b.points));
    setState(() {
      homeList1 = _list;
    });
  }

  sortPoints(List<PlayerInfo> _list, String str) {
    return Container(
      height: 20,
      child: GestureDetector(
        onTap: () {
          if (pointsSort == true) {
            setState(() {
              _list.sort((a, b) => b.points.compareTo(a.points));
              pointsSort = false;
            });
          } else if (pointsSort == false) {
            setState(() {
              _list.sort((a, b) => a.points.compareTo(b.points));
              pointsSort = true;
            });
          }
        },
        child: Center(child: Text(str)),
      ),
    );
  }
  sortAssists(List<PlayerInfo> _list, String str) {
    return Container(
      color: Colors.orange,
      height: 20,
      child: GestureDetector(
        onTap: () {
          if (assistsSort == true) {
            setState(() {
              _list.sort((a, b) => b.assists.compareTo(a.assists));
              assistsSort = false;
            });
          } else if (assistsSort == false) {
            setState(() {
              _list.sort((a, b) => a.assists.compareTo(b.assists));
              assistsSort = true;
            });
          }
        },
        child: Center(child: Text(str)),
      ),
    );
  }

  _testTable(List<PlayerInfo> _list) {
    return Center(
      child: Container(
        width: screenSize(context).width * .8,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DataTable(
                headingRowHeight: 0,
                horizontalMargin: 24,
                dataRowHeight: 30,
                columnSpacing: 2,
                columns: [
                  DataColumn(
                    label: Container(
                      width: 20,
                      height: 1,
                    ),
                  ),
                  DataColumn(
                      numeric: true,
                      label: Container(
                        width: 20,
                        height: 1,
                      )),
                  DataColumn(
                      numeric: true,
                      onSort: (i, b) {
                        if (assistBool == true) {
                          _list.sort((a, b) => a.assists.compareTo(b.assists));
                          setState(() {
                            assistBool = false;
                          });
                        } else if (assistBool == false) {
                          _list.sort((a, b) => b.assists.compareTo(a.assists));
                          setState(() {
                            assistBool = true;
                          });
                        }
                      },
                      label: Container(
                        width: 20,
                        height: 1,
                      )),
                  DataColumn(
                      numeric: true,
                      label: Container(
                        width: 20,
                        height: 1,
                      )),
                  DataColumn(
                      numeric: true,
                      label: Container(
                        width: 20,
                        height: 1,
                      )),
                  DataColumn(
                      label: Container(
                    width: 20,
                    height: 1,
                  )),
                  DataColumn(
                      numeric: true,
                      label: Container(
                        width: 20,
                        height: 1,
                      )),
                ],
                rows: _list
                    .map((player) => DataRow(cells: [
                          DataCell(Text(player.playerId)),
                          DataCell(Text('${player.points}')),
                          DataCell(
                            Text('${player.assists}'),
                          ),
                          DataCell(Text(player.totReb)),
                          DataCell(Text(player.plusMinus)),
                          DataCell(Align(
                              alignment: Alignment.centerRight,
                              child: Text(player.min))),
                          DataCell(Text(player.pos)),
                        ]))
                    .toList(),
              ),
            ],
          ),
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

class DataHeader extends StatefulWidget {
  DataHeader({this.bool1, this.list, this.header, this.numSort, this.numSort2});

  final bool bool1;
  final List list;
  final String header;
  final Function numSort;
  final Function numSort2;

  @override
  _DataHeaderState createState() => _DataHeaderState();
}

class _DataHeaderState extends State<DataHeader> {
  bool _test;
  Function _num1;
  Function _num2;
  List _list;

  @override
  void initState() {
    super.initState();
    _test = widget.bool1;
    _num1 = widget.numSort;
    _num2 = widget.numSort2;
    _list = widget.list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 20,
      child: RaisedButton(
        onPressed: () {
          _num1();
        },
        child: Text(widget.header),
      ),
    );
  }
}
