import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/screens/person_info.dart';
import 'package:todo/services/auth_services.dart';

class HomeScreen extends StatefulWidget {
  static String id = '/HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final authServices=Get.find<AuthServices>();
  String showSelectedDatetime='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
    centerTitle: true,
actions: [
  IconButton(onPressed: (){
    Get.toNamed(PersonInfo.id);
  }, icon: Icon(Icons.person))
],
      ),
      body: SafeArea(
        child: Column(
          children: [
        TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
      ),
          ],
        ),
      ),
    );
  }
}
