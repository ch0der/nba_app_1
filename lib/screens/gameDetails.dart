import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nba_app/PlayerInfo.dart';
import 'package:nba_app/blocs/gameDetailsBloc.dart';

import 'package:nba_app/models/index.dart';
import 'dart:math' as math;
import 'package:parallax_image/parallax_image.dart';

class GameDetailScreen extends StatefulWidget {
  GameDetailScreen(
      {this.gameId, this.homeId, this.awayId, this.playerDetailsList,this.homeLogo,this.awayLogo,this.awayFullName,this.homeFullName});

  final String gameId;
  final String homeId;
  final String awayId;
  final List playerDetailsList;
  final String homeLogo;
  final String awayLogo;
  final String homeFullName;
  final String awayFullName;

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
  String asset = 'assets/collages/details/';
  ScrollController _controllerScroll;
  ScrollPhysics _physics;
  final Color colorBar = Color.fromRGBO(150, 200, 10, 1);

  @override
  void initState() {
    super.initState();
    List<PlayerInfo> players = widget.playerDetailsList;
    homeList1 =
        players.where((index) => index.teamId == widget.homeId).toList();
    awayList1 =
        players.where((index) => index.teamId == widget.awayId).toList();
    _controllerScroll = ScrollController();
    _physics = ScrollPhysics();
  }

  void dispose() {
    super.dispose();
    bloc2.dispose();
    bloc3.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MIL vs. TOR',style: TextStyle(color: Colors.grey[50]),),

        backgroundColor: colorBar,
      ),

        body: body());
  }

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  body() {
    PlayerInfo player;
    return Center(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              teamHeader(widget.awayLogo,widget.awayFullName),
              _columnHeaders(awayList1),
              backgroundImage(Colors.red, '${asset}LALdet.jpg',
                  tableBuilder(awayList1, Colors.red)),
              Container(
                height: 25,
              ),
              teamHeader(widget.homeLogo,widget.homeFullName),
              _columnHeaders(homeList1),
              Container(
                width: screenSize(context).width * .8,
                height: screenSize(context).height * (1*.3),
                child: PageView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          child: backgroundImage(Colors.green, '${asset}NOPdet.jpg',
                              tableBuilder(homeList1, Colors.green)),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          child: backgroundImage(Colors.green, '${asset}NOPdet.jpg',
                              tableBuilder(homeList1, Colors.green)),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ],
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
  backgroundImages() {
    String asset = 'assets/collages/details/';
    return Column(
      children: <Widget>[],
    );
  }
  teamHeader(String logo,String name){
    return Row(
      children: <Widget>[
        Container(
          width: 15,
        ),
        _logoContainer(60,logo ),
        Container(
          width: 30,
        ),
        Container(
          child: Text(name,style: TextStyle(fontSize: 20),),

        ),
      ],
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

  backgroundImage(Color color, String assetImage, Widget child) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(assetImage),
          colorFilter: ColorFilter.mode(
            color.withOpacity(.1),
            BlendMode.modulate,
          ),
        ),
      ),
      child: child,
    );
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
            Expanded(child: sortAssists(_list, 'Min')),
            Expanded(child: sortAssists(_list, 'Pos')),
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
        Expanded(child: sortAssists(homeList1, 'Min')),
        Expanded(child: sortAssists(homeList1, 'Pos')),
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

  tableBuilder(List<PlayerInfo> _list, Color color1) {
    int listSize = _list.length;
    return Container(
      width: screenSize(context).width * .8,
      height: screenSize(context).height * (1*.3),
      child: ListView.builder(
          padding: EdgeInsets.only(top: 0),
          itemCount: listSize,
          itemBuilder: (BuildContext context, int index) {
            if (listSize != null) {
              bool test = index.isOdd;
              return Container(
                height: 30,
                color: test == true ? Colors.grey[50] : color1.withOpacity(.4),
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 2, child: Text("${_list[index].playerId}")),
                    Expanded(
                        child: Center(child: Text("${_list[index].points}"))),
                    Expanded(
                        child: Center(child: Text("${_list[index].assists}"))),
                    Expanded(
                        child: Center(child: Text("${_list[index].totReb}"))),
                    Expanded(
                        child:
                            Center(child: Text("${_list[index].plusMinus}"))),
                    Expanded(child: Center(child: Text("${_list[index].min}"))),
                    Expanded(child: Center(child: Text("${_list[index].pos}"))),
                  ],
                ),
              );
            } else
              return Container(
                height: 30,
                color: Colors.orange,
              );
          }),
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

class CustomScrollSimulation extends Simulation {
  final double initPosition;
  final double velocity;

  @override
  double x(double time) {
    var max = math.max(
        math.min(initPosition, 0.0), initPosition + velocity / 4 * time);
    return max;
  }

  @override
  bool isDone(double time) {
    return false;
  }

  @override
  double dx(double time) {
    return velocity;
  }

  CustomScrollSimulation(this.initPosition, this.velocity);
}

class CustomScrollPhysics2 extends ScrollPhysics {
  @override
  ScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomScrollPhysics2();
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    return CustomScrollSimulation(position.pixels, velocity);
  }
}
