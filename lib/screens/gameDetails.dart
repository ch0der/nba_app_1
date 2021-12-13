import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nba_app/PlayerInfo.dart';
import 'package:nba_app/blocs/gameDetailsBloc.dart';

import 'package:nba_app/models/index.dart';
import 'package:nba_app/teamColors.dart';
import 'dart:math' as math;
import 'package:nba_app/blocs/colorBloc.dart';

class GameDetailScreen extends StatefulWidget {
  GameDetailScreen(
      {required this.gameId, required this.homeId, required this.awayId, required this.playerDetailsList,required this.homeLogo,required this.awayLogo,required this.awayFullName,required this.homeFullName,required this.awayNickname, required this.homeNickname, required this.homeShort, required this.awayShort});

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
  late List testList;
  bool ascending = true;
  bool assistBool = true;
  late List<PlayerInfo> homeList1;
  late List<PlayerInfo> awayList1;
  bool pointsSort = true;
  bool assistsSort = true;
  bool rebSort = true;
  bool plusMinSort = true;
  double sortWidth = 50;
  late ScrollController _controllerScroll;
  late ScrollPhysics _physics;
  final Color colorBar = Color.fromRGBO(150, 200, 10, 1);
  final colorBloc = ColorsBloc();
  late TeamColors _teamColors;
  final Color textColor = Colors.black;
  final TextStyle _style = TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white,shadows: [Shadow(color: Colors.black,offset: Offset(2, 2),blurRadius: 5)],fontFamily: 'Alata');

  @override
  void initState() {
    super.initState();
    List<PlayerInfo>? players = widget.playerDetailsList.cast<PlayerInfo>();
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
    String home = widget.homeShort;
    String away = widget.awayShort;
    String two = '2';

    return colorBloc.fetchColors(home,home+two,away,away+two);
  }

  body() {
    String asset = 'assets/collages/details/';

    return Center(
      child: Column(
        children: <Widget>[
          Container(
            height: 25,
            color: _teamColors.awayColor,),
          teamHeader(widget.awayLogo,widget.awayFullName,_teamColors.awayColor),
          _columnHeaders(awayList1,_teamColors.awayColor2),
          Expanded(child: backgroundImage(Colors.red, '${asset}LALdet.jpg',
              tableBuilder(awayList1, _teamColors.awayColor,screenSize(context).height * (1*.35))),),
          teamHeader(widget.homeLogo,widget.homeFullName,_teamColors.homeColor),
          _columnHeaders(homeList1,_teamColors.homeColor2),
         Expanded(child:  backgroundImage(Colors.green, '${asset}NOPdet.jpg',
             tableBuilder(homeList1, _teamColors.homeColor,screenSize(context).height * (1*.35))),),
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
    return Column(
      children: <Widget>[],
    );
  }
  Widget teamHeader(String logo,String name,color){
    return Container(
      width: screenSize(context).width,

      decoration: BoxDecoration(
        color: color
      ),
      child: Align(
        alignment: Alignment.topCenter,
          child: Text(name,style: TextStyle(fontSize: 28,fontFamily: 'Alata',color: Colors.white,shadows: [Shadow(color: Colors.black,offset: Offset(2, 2),blurRadius: 5)]),)),
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
            dataList = snapshot.data!.game;
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

  _columnHeaders(List<PlayerInfo> _list,Color _color) {

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: _color,
        ),
        width: screenSize(context).width,
        height: 30,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: sortName(_list, 'Player',_style),
            ),
            Expanded(
              flex: 1,
              child: sortPoints(_list, 'Pts',_style),
            ),
            Expanded(child: sortAssists(_list, 'Ast',_style)),
            Expanded(child: sortRebounds(_list, 'Reb',_style)),
            Expanded(child: sortPlusMin(_list, '+/-',_style)),
            Expanded(child: sortAssists(_list, 'Min',_style)),
            Expanded(child: sortAssists(_list, 'Pos',_style)),
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
          child: sortPoints(homeList1, 'Player',_style),
        ),
        Expanded(
          flex: 1,
          child: sortPoints(homeList1, 'Pts',_style),
        ),
        Expanded(child: sortAssists(homeList1, 'Ast',_style)),
        Expanded(child: sortRebounds(homeList1, 'Reb',_style)),
        Expanded(child: sortPlusMin(homeList1, '+/-',_style)),
        Expanded(child: sortAssists(homeList1, 'Min',_style)),
        Expanded(child: sortAssists(homeList1, 'Pos',_style)),
      ],
    );
  }

  sortName(List<PlayerInfo> _list, String str,TextStyle _style) {
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
        child: Text(str,style: _style,),
      ),
    );
  }

  sortPoints(List<PlayerInfo> _list, String str,TextStyle _style) {
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
        child: Center(child: Text(str,style: _style,)),
      ),
    );
  }

  sortAssists(List<PlayerInfo> _list, String str,TextStyle _style) {
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
        child: Center(child: Text(str,style: _style,)),
      ),
    );
  }

  sortRebounds(List<PlayerInfo> _list, String str,TextStyle _style) {
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
        child: Center(child: Text(str,style: _style,)),
      ),
    );
  }

  sortPlusMin(List<PlayerInfo> _list, String str,TextStyle _style) {
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
        child: Center(child: Text(str,style: _style,)),
      ),
    );
  }
  Text tableText(String str){
    TextStyle _style = TextStyle(color: textColor,fontSize: 17);
    return Text(str,style:_style,);
  }

  tableBuilder(List<PlayerInfo> ?_list, Color color1,double height) {
    TextStyle _style = TextStyle(color: textColor,fontSize: 17);


    int? listSize = _list!.length;
    return Container(
      width: screenSize(context).width,
      child: ListView.builder(
          padding: EdgeInsets.only(top: 0),
          itemCount: listSize,
          itemBuilder: (BuildContext context, int index) {
            if (listSize != 0) {
              bool test = index.isOdd;
              return Container(
                height: 30,
                color: test == true ? Colors.grey[50] : color1.withOpacity(.5),
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 2, child: tableText("${_list[index].playerId}",)),
                    Expanded(
                        child: Center(child: Text("${_list[index].points}",style:  _style))),
                    Expanded(
                        child: Center(child: Text("${_list[index].assists}",style:  _style))),
                    Expanded(
                        child: Center(child: Text("${_list[index].totReb}",style:  _style))),
                    Expanded(
                        child:
                            Center(child: Text("${_list[index].plusMinus}",style: _style))),
                    Expanded(child: Center(child: Text("${_list[index].min}",style:  _style))),
                    Expanded(child: Center(child: Text("${_list[index].pos}",style:  _style))),
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
      {required this.child,
      required this.maxHeight,
      required this.minHeight});

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
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    return CustomScrollSimulation(position.pixels, velocity);
  }
}
