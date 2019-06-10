import 'package:flutter/material.dart';
import 'Event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Detail extends StatefulWidget {
  final Event selectedEvent;
  Detail(this.selectedEvent);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final titlecont = TextEditingController;
  Widget _titleWidget = Text('title');
  bool _edit = false;

  void _editing() {
    setState(() {
      _edit = !_edit;
      _titleWidget = !_edit
          ? Text('Edit Title')
          : TextField(
              decoration: InputDecoration(),
            );
    });
  }

  //TextField(decoration: InputDecoration(labelText: "Title", hintText: widget.selectedEvent.title)

  _handleAdd(Event toAdd) {
    Firestore.instance.collection('events').add({
      'title': toAdd.title,
      'date': toAdd.date,
      'location': toAdd.location,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 0.5,
      child: Card(
        margin: EdgeInsets.only(top: 100),
        child: Column(
          children: <Widget>[
            _titleWidget,
            Text(
              widget.selectedEvent.location,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    _handleAdd(widget.selectedEvent);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            FlatButton(
              child: Icon(Icons.edit),
              onPressed: () => _editing(),
            )
          ],
        ),
      ),
    );
  }
}
