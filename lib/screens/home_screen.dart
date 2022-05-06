import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/screens/add_event_screen.dart';
import 'package:todo/screens/calendar_screen.dart';
import 'package:todo/screens/person_info.dart';
import 'package:todo/services/auth_services.dart';

class HomeScreen extends StatefulWidget {
  static String id = '/HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authServices = Get.find<AuthServices>();

  final user = FirebaseAuth.instance.currentUser;





  String showSelectedDatetime = '';

  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo'),
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.playlist_add_check), label: 'AddEvent'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
    );
  }

  final List<Widget> _pages = [
    CalendarScreen(),
    AddEventsScreen(),
    //if user login return PersonInfo Screen else Show a message , It no displays errors
    StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return PersonInfo();
        } else {
          return Center(
            child: Text('You are not logged in. Please log in and try again'),
          );
        }
      },
    ),
    Center(
      child: Text('SettingPage'),
    ),
  ];

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget buildDateTimePicker(String data) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.green, width: 1.5),
      ),
      title: Text(data),
      trailing: const Icon(
        Icons.calendar_today,
        color: Colors.purple,
      ),
    );
  }
}
