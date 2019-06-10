import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './Event.dart';

import 'Detail.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _handleDelete(context, docID) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(title: Text('Really Delete?'), actions: <Widget>[
              FlatButton(
                  child: Text('Delete'),
                  onPressed: () {
                    Firestore.instance
                        .collection('events')
                        .document(docID)
                        .delete();
                    Navigator.pop(context);
                  })
            ]);
          });
    }

    _handleEdit(context, event) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text("Edit"),
                content: Column(children: <Widget>[
                  TextField(
                      decoration: InputDecoration(helperText: 'Edit Title',hintText: event['title']))
                ]));
          });
    }

    return StreamBuilder(
        stream: Firestore.instance.collection("events").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          else
            return ListView.builder(
                // var events = snapshot.data.documents;
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  final event = snapshot.data.documents[index];
                  return ListTile(
                      // onTap: ()=> showSnackBar(context, "This feature is coming soon!"),
                      title: Text(event['title']),
                      leading: IconButton(
                        icon: Icon(Icons.edit_attributes),
                        onPressed: () => _handleEdit(context, event),
                      ),
                      subtitle: Text(event['location']),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Detail(event as Event))),
                      trailing: IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => _handleDelete(context, event.documentID)));
                });
        });
  }
}
