import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Customer extends StatefulWidget {
  const Customer({super.key});

  @override
  State<Customer> createState() => _Customer();
}

class _Customer extends State<Customer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      )),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('customers').snapshots(),
        // ignore: avoid_types_as_parameter_names
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            // print(snapshot.data!.docs[0].data());

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> customer =
                    snapshot.data!.docs[index].data();
                return Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(12),
                  height: 100,
                  decoration: BoxDecoration(border: Border.all(width: 2)),
                  // color: Colors.red,
                  child: Column(
                    children: [
                      //user name
                      Row(
                        children: [
                          Text('username:  '),
                          Text("${customer['firstname']} "),
                          Text(customer['lastname']),
                        ],
                      ),
                      //email
                      Row(
                        children: [Text('email: '), Text(customer['email'])],
                      )
                      //phone number
                      ,
                      Row(
                        children: [
                          Text('phone number'),
                          Text(customer['phonenumber'])
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
