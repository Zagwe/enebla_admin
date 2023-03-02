import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enebla_admin/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
        leading: const Align(
          alignment: Alignment.topLeft,
          child: BackButton(
            color: Colors.blue,
          ),
        ),
        title: Center(
          child: Text(
            "unsubscription requests".toUpperCase(),
            style: const TextStyle(
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
                final complient =
                    snapshot.data!.docs[index].data()['complinet'];
                final user = snapshot.data!.docs[index].data()['userId'];
                final resturant =
                    snapshot.data!.docs[index].data()['resturantId'];

                // print(resturant);

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
                                    // print(userInfo);
                                    // print(resturantInfo);
                                    return GestureDetector(
                                      onTap: () {
                                        showBarModalBottomSheet(
                                            expand: false,
                                            context: context,
                                            bounce: true,
                                            backgroundColor: Colors.white,
                                            builder: (context) {
                                              return Container(
                                                margin:
                                                    const EdgeInsets.all(50),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                        'complient'
                                                            .toUpperCase(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 30)),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10.0),
                                                      child: Divider(
                                                        thickness: 3,
                                                      ),
                                                    ),
                                                    Text(complient),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      width: 150,
                                                      child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(12),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  side: const BorderSide(
                                                                      width: 2,
                                                                      color: Colors
                                                                          .blue)),
                                                              backgroundColor:
                                                                  Colors.blue),
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            HomePage()));
                                                          },
                                                          child: const Text(
                                                            'aprove',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }

                                            ///this page will show
                                            ///
                                            ///the user name
                                            ///
                                            ///subscription amount
                                            ///
                                            ///balance
                                            ///
                                            ///subscription date
                                            ///
                                            ///order history

                                            );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(12),
                                        padding: const EdgeInsets.all(8),
                                        // height: 100,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 2)),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 60,
                                                  backgroundImage: NetworkImage(
                                                      userInfo!['photoUrl']),
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      //username
                                                      Row(
                                                        children: [
                                                          const Text(
                                                              'username'),
                                                          Text(
                                                              "${userInfo['firstname']} ${userInfo['lastname']}")
                                                        ],
                                                      ),
                                                      //phone number
                                                      Row(
                                                        children: [
                                                          const Text(
                                                              'user phonenumber '),
                                                          Text(
                                                              '${userInfo['phonenumber']}')
                                                        ],
                                                      )
                                                      //user email
                                                      ,
                                                      Row(
                                                        children: [
                                                          const Text(
                                                              'user email '),
                                                          Text(
                                                              '${userInfo['email']}')
                                                        ],
                                                      )

                                                      //resturantname
                                                      ,
                                                      Row(
                                                        children: [
                                                          const Text(
                                                              'resturant name'),
                                                          Text(
                                                              "${resturantInfo!['name']}")
                                                        ],
                                                      ),
                                                    ]),
                                              ],
                                            ),
                                          ],
                                        ),
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
