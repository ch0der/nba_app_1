import 'package:flutter/material.dart';
import 'package:nba_app/PlayerInfo.dart';
import 'package:nba_app/blocs/gameDetailsBloc.dart';

import 'package:nba_app/models/index.dart';
import 'dart:math'as math;

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


  body() {
    PlayerInfo player;
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            height: 150,
          ),
          _columnHeaders(homeList1),
          Column(
            children: <Widget>[
              Container(
                height: screenSize(context).height * (1 / 3),
                child: Theme(
                  data: Theme.of(context).copyWith(
                      dividerColor: Colors.blueAccent,
                      selectedRowColor: Colors.orange),
                  child: tableBuilder(homeList1,Colors.green),
                ),
              ),
            ],
          ),
          Container(
            height: 25,
          ),
          _columnHeaders(awayList1),
          Container(
            child: tableBuilder(awayList1,Colors.amberAccent),
          ),
        ],
      ),
    );
  }
  // -----------------------------------------------------------------------------------------------------------------------------------------------------------
  // -----------------------------------------------------------------------------------------------------------------------------------------------------------
  // -----------------------------------------------------------------------------------------------------------------------------------------------------------
  // -----------------------------------------------------------------------------------------------------------------------------------------------------------
  // -------------------------------------------------------------Main Body Divider-------------------------------------------------------------------------
  // -----------------------------------------------------------------------------------------------------------------------------------------------------------
  // -----------------------------------------------------------------------------------------------------------------------------------------------------------
  // -----------------------------------------------------------------------------------------------------------------------------------------------------------



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

  _columnHeaders(List _list) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        width: screenSize(context).width * .8,
        height: 30,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: sortName(_list, 'Player'),
            ),
            Expanded(
              flex: 1,
              child: sortPoints(_list, 'Pts'),
            ),
            Expanded(child: sortAssists(_list, 'Ast')),
            Expanded(child: sortRebounds(_list, 'Reb')),
            Expanded(child: sortPlusMin(_list, '+/-')),
            Expanded(child: sortAssists(_list, 'Ast')),
            Expanded(child: sortAssists(_list, 'Ast')),
          ],
        ),
      ),
    );
  }

  homeColumns() {
    return Row(
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
        Expanded(child: sortRebounds(homeList1, 'Reb')),
        Expanded(child: sortPlusMin(homeList1, '+/-')),
        Expanded(child: sortAssists(homeList1, 'Ast')),
        Expanded(child: sortAssists(homeList1, 'Ast')),
      ],
    );
  }


  sortName(List<PlayerInfo> _list, String str) {
    return Container(
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
        child: Text(str),
      ),
    );
  }

  sortPoints(List<PlayerInfo> _list, String str) {
    return Container(
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

  sortRebounds(List<PlayerInfo> _list, String str) {
    return Container(
      child: GestureDetector(
        onTap: () {
          if (rebSort == true) {
            setState(() {
              _list.sort((a, b) => b.totReb.compareTo(a.totReb));
              rebSort = false;
            });
          } else if (rebSort == false) {
            setState(() {
              _list.sort((a, b) => a.totReb.compareTo(b.totReb));
              rebSort = true;
            });
          }
        },
        child: Center(child: Text(str)),
      ),
    );
  }

  sortPlusMin(List<PlayerInfo> _list, String str) {
    return Container(
      child: GestureDetector(
        onTap: () {
          if (plusMinSort == true) {
            setState(() {
              _list.sort((a, b) => b.plusMinus.compareTo(a.plusMinus));
              plusMinSort = false;
            });
          } else if (plusMinSort == false) {
            setState(() {
              _list.sort((a, b) => a.plusMinus.compareTo(b.plusMinus));
              plusMinSort = true;
            });
          }
        },
        child: Center(child: Text(str)),
      ),
    );
  }

  tableBuilder(List<PlayerInfo>_list,Color color1){
    
    int listSize = _list.length;
    return SingleChildScrollView(
   child: Container(
     width: screenSize(context).width*.8,
     height: screenSize(context).height * (1 / 3),
     child: ListView.builder(
       padding: EdgeInsets.only(top: 0),
         itemCount: listSize,
         itemBuilder: (BuildContext context, int index){
           if(listSize != null){
             bool test = index.isOdd;
             return Container(
               height: 30,
               color: test == true ? Colors.white70 : color1.withOpacity(.3),
               child: Row(
                 children: <Widget>[
                   Expanded(flex: 2,
                       child: Text("${_list[index].playerId}")),
                   Expanded(child: Center(child: Text("${_list[index].points}"))),
                   Expanded(child: Center(child: Text("${_list[index].assists}"))),
                   Expanded(child: Center(child: Text("${_list[index].totReb}"))),
                   Expanded(child: Center(child: Text("${_list[index].plusMinus}"))),
                   Expanded(child: Center(child: Text("${_list[index].min}"))),
                   Expanded(child: Center(child: Text("${_list[index].pos}"))),
                 ],

               ),
             );
           } else return Container(
             height: 30,
             color: Colors.orange,
           );

         }
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

