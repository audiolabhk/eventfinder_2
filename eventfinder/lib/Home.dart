import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onLongPress: () => _navigate(context, Explore()),
      // onHorizontalDragStart: {_navigate(context,Explore()},
      child: Center(
        child: Image.network(
            'https://scontent.fhkg3-1.fna.fbcdn.net/v/t1.0-9/40838671_293579784570903_5502731126340321280_n.png?_nc_cat=105&_nc_ht=scontent.fhkg3-1.fna&oh=a5e8e4de8b6d11ea0babe97dc951944a&oe=5D821F7C'),
      ),
    );
  }
}

// void _navigate(context, Widget target) {
//   Navigator.push(context, MaterialPageRoute(builder: (context) => target));
// }
