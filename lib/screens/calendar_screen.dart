import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../services/event.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  late Map<DateTime, List<Event>> selectedEvents;

  final TextEditingController _eventController = TextEditingController();
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  CalendarFormat format = CalendarFormat.month;

   @override
   void initState() {
     selectedEvents={};
     super.initState();

   }

   List<Event> _getEventsFromDay(DateTime date){
     return selectedEvents[date]??[];
   }

   @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AvatarGlow(
          endRadius: 40,
          showTwoGlows: true,
          glowColor: Colors.blue,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Added Event'),
                  content: TextFormField(
                    controller: _eventController,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Ok'),
                    ),
                  ],
                ),
              );
            },
            child: Icon(Icons.add),
            tooltip: 'add work',
          )),
      body: Container(
        child: Column(
          children: [
            TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: kFirstDay,
                lastDay: kLastDay,
            eventLoader: _getEventsFromDay,
            ),
            // CalendarDatePicker(
            //     initialDate:DateTime.now() ,
            //     firstDate: kFirstDay,
            //     lastDate: kLastDay,
            //     onDateChanged: (date){
            //       setState(() {
            //      _selectedDateTime=date;
            //       });
            //     }),
            Center(child: Text(convertDate(_selectedDateTime)),),
          ],
        ),
      ),
    );
  }
   String convertDate(DateTime dateTime) {
     return DateFormat('dd/MM/yyyy').format(dateTime);
   }
}
