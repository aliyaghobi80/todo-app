import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:todo/services/auth_services.dart';

class HomeScreen extends StatefulWidget {
  static String id = '/HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authServices=Get.put<AuthServices>(AuthServices());
  String showSelectedDatetime='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
    centerTitle: true,
actions: [
  IconButton(onPressed: (){
    authServices.firebaseAuth.signOut();
  }, icon: Icon(Icons.logout))
],
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                DatePicker.showDateTimePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2020, 3, 5),
                    maxTime: DateTime(2030, 6, 7), onChanged: (date) {
                  setState(() {
                    showSelectedDatetime=date.toString();
                  });
                  print('change $date');
                }, onConfirm: (date) {
                  print('confirm $date');
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: Text(
                'Select time',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            Text(showSelectedDatetime),
            Text(authServices.firebaseAuth.currentUser!.email.toString()),
          ],
        ),
      ),
    );
  }
}
