import 'package:eventfinder/Detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './Event.dart';
import 'dart:convert';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import './Detail.dart';

class Explore extends StatelessWidget {
  Future<List<Event>> _getEvents() async {
    var data = await http
        .get('http://www.json-generator.com/api/json/get/bVmHUHnanC?indent=2');
    var jsonData = json.decode(data.body);
    List<Event> jsonEvents = [];
    for (var i in jsonData) {
      Event event = Event(i["title"], i["location"], i["date"]);
      jsonEvents.add(event);
    }
    return jsonEvents;
  }

  void _handleAdd(context, Event toAdd) {
    Firestore.instance.collection('events').add({
      'title': toAdd.title,
      'location': toAdd.location,
      'date': toAdd.date,
    });

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              elevation: 10,
              title: Text('Added to Favorites'),
              content: Text(toAdd.title + ' added to favorites'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Back'),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: _getEvents(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
              color: Colors.black87,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1),
                itemCount: snapshot.data.length,
                itemBuilder: (ctx, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onLongPress: ()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>Detail(snapshot.data[index]))),
                        child: Image.asset(
                            'lib/images/dance.jpg'),
                      ),
                      ListTile(
                          title: Text(snapshot.data[index].title, style:TextStyle(color: Colors.white)),
                          subtitle: Text(snapshot.data[index].date, style:TextStyle(color: Colors.white)),
                          onTap: ()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>Detail(snapshot.data[index] as Event))),
                          trailing: IconButton(
                            icon: Icon(Icons.add,color: Colors.redAccent,),
                            onPressed: () =>
                                _handleAdd(context, snapshot.data[index] as Event),
                          ))
                    ],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
