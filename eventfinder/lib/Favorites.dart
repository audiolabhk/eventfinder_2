import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Favorites extends StatelessWidget {
  final titleController = TextEditingController();
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
                elevation: 20,
                title: Text("Edit"),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  FlatButton(
                      child: Text('Save'),
                      onPressed: () {
                        Firestore.instance
                            .collection('events')
                            .document(event.documentID)
                            .updateData({'title': titleController.text});
                        Navigator.pop(context);
                      })
                ],
                content: Column(children: <Widget>[
                  TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                          helperText: 'Edit Title', hintText: event['title']))
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
                        icon: Icon(Icons.edit),
                        onPressed: () => _handleEdit(context, event),
                      ),
                      subtitle: Text(event['location']),
                      trailing: IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () =>
                              _handleDelete(context, event.documentID)));
                });
        });
  }
}
