import 'package:flutter/material.dart';

class ScorePage extends StatefulWidget {
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),

    );
  }
  buildBody(){
    return Column(
      children: <Widget>[
        Container(height: 100,),
        listTileContainer(),


      ],
    );
  }
  listTileContainer(){
    return Center(
      child: Container(
        width: screenSize(context).width*.9,
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
        )

      ),
    );
  }
  Size screenSize(BuildContext context){
    return MediaQuery.of(context).size;
  }
  scoreContainer(){

    double textHeight = 45;
    double scoreSpacing = 15;

    return Center(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('127',style: TextStyle(fontFamily: 'Alatsi',fontSize: textHeight),),
            Container(width: scoreSpacing,),
            Text('-',style: TextStyle(fontFamily: 'Alatsi',fontSize: textHeight),),
            Container(width: scoreSpacing,),
            Text('136',style: TextStyle(fontFamily: 'Alatsi',fontSize: textHeight),),
          ],
        ),
      ),
    );
  }
  gameTimeContainer(){

    double textHeight = 20;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Q4',style: TextStyle(fontFamily: 'Alatsi',fontSize: textHeight),),
          Container(width: 20,),
          Text('03:49',style: TextStyle(fontFamily: 'Alatsi',fontSize: textHeight),),
        ],

      ),
    );
  }
}
