import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  final firestore = FirebaseFirestore.instance.collection("students");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Student"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Name"),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "email"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Mobile Number"),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String id = DateTime.now().microsecondsSinceEpoch.toString();
              firestore
                  .doc(id)
                  .set({
                'id':id,
                'name' : nameController.text.toString(),
                'email' : emailController.text.toString(),
                'number' : numberController.text.toString(),

              })
                  .then((value) => {
                    print("succesful register")
              })
                  .onError((error, stackTrace) => {});
              Navigator.pop(context);
            },
            child: Text("Register"),
          ),
        ],
      ),
    );
  }
}
