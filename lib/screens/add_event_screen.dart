
import 'package:flutter/material.dart';

class AddEventsScreen extends StatefulWidget {
  const AddEventsScreen({Key? key}) : super(key: key);

  @override
  State<AddEventsScreen> createState() => _AddEventsScreenState();
}

class _AddEventsScreenState extends State<AddEventsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(decoration: InputDecoration(hintText: 'Event')),

          ],
        ),
      ),
    );
  }
}
