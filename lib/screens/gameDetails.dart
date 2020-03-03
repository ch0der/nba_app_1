import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nba_app/PlayerInfo.dart';
import 'package:nba_app/blocs/gameDetailsBloc.dart';

import 'package:nba_app/models/index.dart';
import 'package:nba_app/teamColors.dart';
import 'dart:math' as math;
import 'package:parallax_image/parallax_image.dart';
import 'package:nba_app/blocs/colorBloc.dart';

class GameDetailScreen extends StatefulWidget {
  GameDetailScreen(
      {this.gameId, this.homeId, this.awayId, this.playerDetailsList,this.homeLogo,this.awayLogo,this.awayFullName,this.homeFullName,this.awayNickname,this.homeNickname,this.awayShort,this.homeShort});

  final String gameId;
  final String homeId;
  final String awayId;
  final List playerDetailsList;
  final String homeLogo;
  final String awayLogo;
  final String homeFullName;
  final String awayFullName;
  final String homeNickname;
  final String awayNickname;
  final String homeShort;
  final String awayShort;

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
  ScrollController _controllerScroll;
  ScrollPhysics _physics;
  final Color colorBar = Color.fromRGBO(150, 200, 10, 1);
  final colorBloc = ColorsBloc();
  TeamColors _teamColors;
  final Color textColor = Colors.black;

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
    _teamColors = getColors();
  }

  void dispose() {
    super.dispose();
    bloc2.dispose();
    bloc3.dispose();
    colorBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: body());
  }

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  getColors<PlayerInfo>(){
    return colorBloc.fetchColors(widget.awayShort, widget.homeShort);
  }

  body() {
    PlayerInfo player;
    String asset = 'assets/collages/details/';

    return Center(
      child: Column(
        children: <Widget>[
          Container(height: 50,),
          teamHeader(widget.awayLogo,widget.awayFullName,_teamColors.awayColor),
          _columnHeaders(awayList1),
          backgroundImage(Colors.red, '${asset}LALdet.jpg',
              tableBuilder(awayList1, _teamColors.awayColor)),
          teamHeader(widget.homeLogo,widget.homeFullName,_teamColors.homeColor),
          _columnHeaders(homeList1),
          Container(
            width: screenSize(context).width,
            height: screenSize(context).height * (1*.3),
            child: PageView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: backgroundImage(Colors.green, '${asset}NOPdet.jpg',
                          tableBuilder(homeList1, _teamColors.homeColor)),
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
  teamHeader(String logo,String name,color){
    return Container(
      width: screenSize(context).width,

      decoration: BoxDecoration(
        color: color
      ),
      child: Container(
        child: Center(child: Text(name,style: TextStyle(fontSize: 30,fontFamily: 'Caladea',color: Colors.white),)),

      ),
    );
  }
  teamHeader2(String name){
    return    Container(
      child: Text(name,style: TextStyle(fontSize: 30,fontFamily: 'Caladea',color: Colors.white),),

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
        width: screenSize(context).width,
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
  Text tableText(String str){
    return Text(str,style: TextStyle(color: textColor),);
  }

  tableBuilder(List<PlayerInfo> _list, Color color1) {
    int listSize = _list.length;
    return Container(
      width: screenSize(context).width,
      height: screenSize(context).height * (1*.3),
      child: ListView.builder(
          padding: EdgeInsets.only(top: 0),
          itemCount: listSize,
          itemBuilder: (BuildContext context, int index) {
            if (listSize != null) {
              bool test = index.isOdd;
              return Container(
                height: 30,
                color: test == true ? Colors.grey[50] : color1.withOpacity(.5),
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 2, child: tableText("${_list[index].playerId}")),
                    Expanded(
                        child: Center(child: Text("${_list[index].points}",style: TextStyle(color: textColor)))),
                    Expanded(
                        child: Center(child: Text("${_list[index].assists}",style: TextStyle(color: textColor)))),
                    Expanded(
                        child: Center(child: Text("${_list[index].totReb}",style: TextStyle(color: textColor)))),
                    Expanded(
                        child:
                            Center(child: Text("${_list[index].plusMinus}",style: TextStyle(color: textColor)))),
                    Expanded(child: Center(child: Text("${_list[index].min}",style: TextStyle(color:textColor)))),
                    Expanded(child: Center(child: Text("${_list[index].pos}",style: TextStyle(color: textColor)))),
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

List teamColorList = [Color];

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
