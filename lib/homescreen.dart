import 'package:enebla_admin/request.dart';
import 'package:enebla_admin/user_list.dart';
import 'package:flutter/material.dart';

import 'customer_list.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  List<String> homeCardTag = [
    'Customer',
    'User',
    'Request',
  ];
  List<String> homeCardImage = [
    'assets/home.jpg',
    "assets/home.jpg",
    "assets/home.jpg",
    "assets/home.jpg"
  ];
  List<String> homeCardLinks = [
    'MenuList()',
    "assets/home.jpg",
    "assets/home.jpg",
    "assets/home.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Enebla admin',
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 8),
        //     child: IconButton(
        //       icon: const Icon(
        //         Icons.info,
        //         color: Colors.black,
        //       ),
        //       onPressed: () {
        //         Services.addMenu("pro", "pink", "pp")
        //             .then((result) {
        //           if ('success' == result) {
        //             Text("brooooo");
        //           }
        //         });

        //         // Navigator.push(context,
        //         //     MaterialPageRoute(builder: (context) => OnBording()));

        //       },
        //     ),
        //   )
        // ]
      ),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: homeCardTag.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Customer()));
                      } else if (index == 1) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => User()));
                      } else if (index == 2) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Request()));
                      }
                    },
                    child: Container(
                      height: 185,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0),
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: AssetImage(homeCardImage[index]),
                            fit: BoxFit.cover),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(homeCardTag[index],
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  wordSpacing: 6,
                                ))),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
      ////experimentaing on home page scroll bar
      ///still have alots of work to do on the scroll bar
    );
  }
}
