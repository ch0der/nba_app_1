import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nba_app/models/posts.dart';






class PlayerSearch extends StatefulWidget {
  PlayerSearch({Key key}) : super(key: key);

  @override
  _PlayerSearchState createState() => _PlayerSearchState();
}

class _PlayerSearchState extends State<PlayerSearch> {

  String lastName = 'Paul';


  Future<Posts> fetchPost2(String lastName) async {

    String myPath = '/players/lastName/$lastName';
    Map<String, String> parms1 = {"lastname": "Paul"};

    final response = await http
        .get(Uri.https("api-nba-v1.p.rapidapi.com", myPath, parms1), headers: {
      "x-rapidapi-host": "api-nba-v1.p.rapidapi.com",
      "x-rapidapi-key": "6e137c5c98mshcfe3870862cc847p12a327jsn818c1cb513dd"
    });

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.

      var info = json.decode(response.body);




      return Posts.fromJson(info['api']);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }


  Future<Posts> post2;

  @override
  void initState() {
    super.initState();
    post2 = fetchPost2(lastName);
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            post2 = fetchPost2(lastName);
          },
        ),
        body: Center(
          child: FutureBuilder<Posts>(
            future: post2,
            builder: (context, snapshot) {
              if (snapshot.hasData) {

                List<dynamic> plzWork = snapshot.data.players;

                return ListView.builder(
                  itemCount: plzWork == null ? 0 : plzWork.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Text(plzWork[index]['lastName']),
                      title: Text(plzWork[index]['firstName']),
                      trailing: Text(plzWork[index]['yearsPro']),

                    );
                  },
                );
              } else if (snapshot.hasError) {

                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}


