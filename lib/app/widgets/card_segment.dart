
import 'package:flutter/material.dart';

class CardSegment extends StatelessWidget {
  const CardSegment({Key? key, required this.icon, required this.title, required this.columnItems}) : super(key: key);

  final IconData icon;
  final String title;
  final List<Widget> columnItems;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // title
            ListTile(
              leading: Icon(icon),
              title: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ),

            ...columnItems,
          ],
        ),
      ),
    );
  }
}
