import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection("events").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return CircularProgressIndicator();
          else
            return ListView.builder(
                // var events = snapshot.data.documents;
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  final event = snapshot.data.documents[index];
                  return ListTile(
                      title: Text(event['title']),
                      subtitle: Text(event['location']),
                      leading: Icon(Icons.event));
                });
        });
  }
}
