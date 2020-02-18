import 'package:flutter/material.dart';

class Stats extends StatefulWidget {
  Stats({this.list,this.bool2});

  final List list;
  final bool bool2;

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DataTable(
              sortAscending: widget.bool2,
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
                      onSortColumn(widget.bool2);


                    },
                    label: Text('PTS')),
                DataColumn(label: Text('AST')),
                DataColumn(label: Text('REB')),
                DataColumn(label: Align(child: Text('+/-'))),
              ],
              rows: widget.list.map((player) => DataRow(

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
    );
  }

  onSortColumn(bool ascending1){
    if(ascending1 == true){
      widget.list.sort((a,b)=> a.pts.compareTo(b.pts));
      setState(() {
        ascending1 = false;
      });
    } else if(ascending1 == false){
      widget.list.sort((a,b)=> b.pts.compareTo(a.pts));
      setState(() {
        ascending1 = true;
      });
    }
  }
}
