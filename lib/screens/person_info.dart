import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/constant.dart';

class PersonInfo extends StatefulWidget {
  static String id = '/PersonInfo';

  PersonInfo({Key? key}) : super(key: key);

  @override
  State<PersonInfo> createState() => _PersonInfoState();
}

class _PersonInfoState extends State<PersonInfo> {
  // final authServices = Get.find<AuthServices>();

  FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  TextEditingController usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isChangeUsername = false;

  @override
  void initState() {
    super.initState();
    users
        .where('userid', isEqualTo: auth.currentUser!.uid)
        .limit(1)
        .get()
        .catchError((error) {
      print(error);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          image:DecorationImage(image: AssetImage('assets/images/background2.jpg'),fit: BoxFit.cover),),
        child: StreamBuilder(
          stream:
              users.where('userid', isEqualTo: auth.currentUser!.uid).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children:const [
                  CircularProgressIndicator(),
                  Center(child: Text("Loading")),
                ],
              );
            }

            return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;
                  usernameController.text = data['username'];
                  return Form(
            key: _formKey,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black12,
                  radius: 50,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.black38,
                    child: Center(
                      child: Text(
                        data['username'].toString().substring(0, 1),
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 25),
                        textScaleFactor: 3,
                      ),
                    ),
                  ),
                ),
                baseContainer( (isChangeUsername)
                    ? TextFormField(
                  controller: usernameController,
                  validator: validateUsername,
                  decoration: InputDecoration(
                      label: Text('username'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      suffixIcon: IconButton(onPressed: () {
                        setState(() {
                          if(usernameController.text.length>3){
                            updateUsername(document, usernameController.text);
                            isChangeUsername=!isChangeUsername;
                          }
                          else{
                            return;
                          }
                        });
                      }, icon:Icon(CupertinoIcons.check_mark,color: Colors.white,),)
                  ),
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                  ),
                )
                    : Column(
                  children: [
                    Text(
                      'Username: ${data['username']}',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.white
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.black12),
                      onPressed: () {
                        setState(() {
                          isChangeUsername=!isChangeUsername;
                        });
                      },
                      child: Text('changeUsername'),
                    ),
                  ],
                ),),
                baseContainer( Text(
                  'Email: ${data['email']}',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                      color: Colors.white
                  ),
                ),),
                baseContainer(Text(
                  'BirthDay: ${data['birthday']}',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                    color: Colors.white
                  ),
                ),),
                Row(
                  children: [
                    TextButton.icon(onPressed: (){
                    }, icon: Icon(Icons.logout,size: 30,color: Colors.red,), label: Text('Logout',style: TextStyle(fontSize: 25,color:Colors.red),),),
                  ],
                )

              ],
            ),
                  );
                }).toList(),
              );
          },
        ),
      ),
    );
  }
  void updateUsername(DocumentSnapshot documentSnapshot,String username){
    users.doc(documentSnapshot.id).update({
      'username':username,
    });
  }
  Widget baseContainer(Widget child){
   return Container(
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
    border: Border.all(color: Colors.tealAccent,width:1),
    borderRadius: BorderRadius.circular(20),
    gradient: LinearGradient(colors: [Colors.white24,Colors.blue.shade600,] ,begin: Alignment.topLeft,end: Alignment.bottomRight)
    ),
    child: child);
  }
}
