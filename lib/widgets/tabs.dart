import 'package:flutter/material.dart';
import 'package:nba_app/library.dart';
import 'package:nba_app/blocs/live_scores_bloc.dart';


class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs>
    with SingleTickerProviderStateMixin {

  final bloc = LiveScoreBloc();
  final List<Tab> appTabs = <Tab>[
    Tab(
      text: 'One',
    ),
    Tab(
      text: 'Two',

    ),
  ];

  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: appTabs.length, vsync: this);
    bloc.fetchPost2();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: TabBar(
          tabs: appTabs,
          controller: _tabController,
        ),
      ),
      body: StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return TabBarView(
            children: [
              ScorePage(),
              Container(),
            ],
            controller: _tabController,
          );
        }
      ),
    );
  }
  homeDrawer() {
    return Container(
      width: 200,
      child: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100,
              child: DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}