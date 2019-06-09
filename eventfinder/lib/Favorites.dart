import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Favorites extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    _handleDelete(context, docID){
      return showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Really Delete?'),
            actions: <Widget>[
              FlatButton(child: Text('Delete'),
              onPressed: () {
                Firestore.instance.collection('events').document(docID).delete();
                Navigator.pop(context);
              })
            ]);
        }
        );
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
                    title: Text(event['title']),
                    subtitle: Text(event['location']),
                    leading: Icon(Icons.event),
                    trailing: IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: ()=> _handleDelete(context, event.documentID)
                    ),
                  );
                });
        });
  }
}
