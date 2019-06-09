import 'package:flutter/material.dart';
import 'Event.dart';

class Detail extends StatelessWidget {
  final Event selectedEvent;
  Detail(this.selectedEvent);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
          tag: TextStyle(fontSize: 20),
          child: Text(
        selectedEvent.title,
        style: TextStyle(fontSize: 40),
      )),
    );
  }
}
