import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        // backgroundColor: Colors.blue,
        backgroundColor: Colors.grey.shade300,
        toolbarHeight: 150,
        elevation: 0,
        leading: Align(
          alignment: Alignment.topLeft,
          child: BackButton(
            color: Colors.blue,
          ),
        ),
        title: Center(
          child: Text(
            "unsubscription requests".toUpperCase(),
            style: TextStyle(
                // fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('unsubscribecomplient')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            print('has data');
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final user = snapshot.data!.docs[index].data()['userId'];
                final resturant =
                    snapshot.data!.docs[index].data()['resturantId'];

                print(resturant);

                ///fetch user info
                return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(user)
                        .get(),
                    builder: (context,
                        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                            userSnapshot) {
                      if (userSnapshot.hasData) {
                        if (userSnapshot.data!.data() != null) {
                          ///fetch resturant info
                          return FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection('resturant')
                                  .doc(resturant)
                                  .get(),
                              builder: (context,
                                  AsyncSnapshot<
                                          DocumentSnapshot<
                                              Map<String, dynamic>>>
                                      resturantSnapshot) {
                                if (resturantSnapshot.hasData) {
                                  if (resturantSnapshot.data!.data() != null) {
                                    final resturantInfo =
                                        resturantSnapshot.data!.data();
                                    final userInfo = userSnapshot.data!.data();
                                    print(userInfo);
                                    print(resturantInfo);
                                    return Container(
                                      margin: EdgeInsets.all(12),
                                      padding: EdgeInsets.all(8),
                                      height: 100,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2)),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 60,
                                            backgroundImage: NetworkImage(
                                                userInfo!['photoUrl']),
                                          ),
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                //username
                                                Row(
                                                  children: [
                                                    Text('username'),
                                                    Text(
                                                        "${userInfo!['firstname']} ${userInfo['lastname']}")
                                                  ],
                                                ),
                                                //phone number
                                                Row(
                                                  children: [
                                                    Text('user phonenumber '),
                                                    Text(
                                                        '${userInfo['phonenumber']}')
                                                  ],
                                                )
                                                //user email
                                                ,
                                                Row(
                                                  children: [
                                                    Text('user email '),
                                                    Text('${userInfo['email']}')
                                                  ],
                                                )

                                                //resturantname
                                                ,
                                                Row(
                                                  children: [
                                                    Text('resturant name'),
                                                    Text(
                                                        "${resturantInfo!['name']}")
                                                  ],
                                                )
                                              ]),
                                        ],
                                      ),
                                    );
                                  }
                                }
                                return Container();
                              });
                        }
                      }

                      return Container();
                    });
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
