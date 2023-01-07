import 'package:crudapp/screens/student_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection("students").snapshots();

CollectionReference ref  = FirebaseFirestore.instance.collection("students");



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crud APP"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text("ADD",style: TextStyle(
              fontSize: 20
            ),),
          ),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentPage()));


          }, icon:Icon(Icons.add_box_outlined,size: 25,))
        ],
      ),
      body: Column(


        children: [
          SizedBox(height: 10,),

          StreamBuilder<QuerySnapshot>(
            stream: firestore,
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();
              
              if(snapshot.hasError)
                return Text("some errror");

              return Expanded(child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                return Container(
                  child: Card(
                    elevation: 0,
                    color: Colors.indigo,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Name",style: TextStyle(color: Colors.white),),
                                Text("Email",style: TextStyle(color: Colors.white),),
                                Text("Mobile",style: TextStyle(color: Colors.white),),
                                Text("Edit",style: TextStyle(color: Colors.white),),

                                Text("Delete",style: TextStyle(color: Colors.white),),

                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(snapshot.data!.docs[index]['name'].toString(),style: TextStyle(color: Colors.white,fontSize: 12),),
                                  Text(snapshot.data!.docs[index]['email'].toString(),style: TextStyle(color: Colors.white,fontSize: 12),),
                                  Text(snapshot.data!.docs[index]['number'].toString(),style: TextStyle(color: Colors.white,fontSize: 12),),
                                  IconButton(onPressed: (){



                                    _dialogBuilder(context,snapshot.data!.docs[index].id.toString());


                                  }, icon: Icon(Icons.edit,color: Colors.white,)),

                                  IconButton(onPressed: (){

                                    ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                                  }, icon: Icon(Icons.delete,color: Colors.redAccent,))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                      
                    ),
                  ),
                );
              }
              )
              );



              }


          )


        ],
      ),

    );
  }
  Future<void> _dialogBuilder(BuildContext context,id) {


    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("EDIT INFO"),
          content:Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: nameController,

                  decoration: InputDecoration(
                      hintText: "Name"
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "Email"
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: numberController,
                  decoration: InputDecoration(
                      hintText: "Mobile"
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('UPDATE'),
              onPressed: () {

                ref.doc(id).update({
                  'name' : nameController.text.toString(),
                  'email' : emailController.text.toString(),
                  'number' : nameController.text.toString(),

                }
                );

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
