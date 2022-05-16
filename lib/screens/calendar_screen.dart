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
                      child: Text("Ok"),
                      onPressed: () {
                        if (_eventController.text.isEmpty) {
                        } else {
                          if (selectedEvents[selectedDay] != null) {
                            selectedEvents[selectedDay]!.add(
                              // addEvent(task: _eventController.text,date:selectedDay ,time:time ,),
                              Event(
                                  title: _eventController.text,
                                  time: time,
                                  date: selectedDay),
                            );
                          } else {
                            selectedEvents[selectedDay] = [
                              // addEvent(task: _eventController.text,date:selectedDay ,time:time ,),
                              Event(
                                  title: _eventController.text,
                                  time: time,
                                  date: selectedDay)
                            ];
                          }
                        }
                        Get.back();
                        _eventController.clear();
                        setState(() {});
                        return;
                      },
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
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: TableCalendar(
                  focusedDay: selectedDay,
                  firstDay: DateTime(1990),
                  lastDay: DateTime(2050),
                  calendarFormat: format,
                  calendarStyle: CalendarStyle(
                      markerDecoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(50),
                  )),
                  daysOfWeekStyle: DaysOfWeekStyle(
                      weekendStyle: TextStyle(color: Colors.red)),
                  onFormatChanged: (CalendarFormat _format) {
                    setState(() {
                      format = _format;
                    });
                  },
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  daysOfWeekVisible: true,
                  onDaySelected: (DateTime selectDay, DateTime focusDay) {
                    setState(() {
                      selectedDay = selectDay;
                      focusedDay = focusDay;
                    });
                    focusedDay = focusDay;
                  },
                  selectedDayPredicate: (DateTime date) {
                    return isSameDay(selectedDay, date);
                  },
                  eventLoader: _getEventsFromDay,
                ),
              ),
            ),
            Divider(
              color: Colors.blue,
            ),
            SizedBox(
              height: 1,
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ..._getEventsFromDay(selectedDay).map(
                      (Event event) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.purpleAccent.withOpacity(0.09),
                              borderRadius: BorderRadius.circular(11)),
                          child: ListTile(
                            style: ListTileStyle.list,
                            leading: Container(
                              height: 50,
                              width: 5,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            title: Text(
                              event.title,
                            ),
                            subtitle: Text(
                                'Date:${event.date.toString().substring(0, 10)} Time:${event.time.toString().substring(11, 19)}'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Center(
            //   child: Text(convertDate(_selectedDateTime)),
            // ),
          ],
        ),
      ),
    );
  }

  String convertDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  addEvent(
      {required String task,
      required DateTime date,
      required DateTime time}) async {
    // Create a new user with a first and last name
    final event = <String, dynamic>{
      "task": task,
      "date": date,
      "time": time,
    };

// Add a new document with a generated ID
    await db
        .collection("events")
        .add(event)
        .then((DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'))
        .then((value) => Get.back());
  }
}
