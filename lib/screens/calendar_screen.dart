import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/constant.dart';
import '../services/event.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  var db = FirebaseFirestore.instance;
  late Map<DateTime, List<Event>> selectedEvents;

  final TextEditingController _eventController = TextEditingController();
  final TextEditingController _timePicker = TextEditingController();
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  CalendarFormat format = CalendarFormat.month;
  DateTime time = DateTime.now();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsFromDay(DateTime date) {
    return selectedEvents[date] ?? [];
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
                  content: SizedBox(
                    height: 110,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _eventController,
                          decoration: InputDecoration(
                            hintText: 'Event',
                            icon: Icon(
                              Icons.event_available,
                              size: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: decorationTextFromField.copyWith(
                            hintText: 'Enter Time',
                            icon: Icon(
                              Icons.timer,
                              size: 30,
                            ),
                          ),
                          controller: _timePicker,
                          onTap: () {
                            DatePicker.showTimePicker(context,
                                theme: DatePickerTheme(
                                    backgroundColor: Colors.grey.shade900,
                                    cancelStyle: TextStyle(color: Colors.red),
                                    headerColor: Colors.grey.shade800,
                                    itemStyle: TextStyle(color: Colors.yellow)),
                                showSecondsColumn: false, onConfirm: (val) {
                              setState(() {
                                time = val;
                                _timePicker.text = val
                                    .toIso8601String()
                                    .toString()
                                    .substring(11, 16);
                              });
                            });
                          },
                          readOnly: true,
                        ),
                      ],
                    ),
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
