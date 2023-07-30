import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gusto_coffee_coworking_space/Helper/colors.dart';
import 'package:gusto_coffee_coworking_space/widget/appbar.dart';

import '../../../widget/footer.dart';
import '../../../widget/navbar.dart';
import '../../../widget/paymants.dart';

class Coworking extends StatefulWidget {
  const Coworking({Key? key});

  @override
  State<Coworking> createState() => _CoworkingState();
}

class _CoworkingState extends State<Coworking> {
  final navbars = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: navbars,
      backgroundColor: background,
      endDrawer: Navbar(),
      appBar: AppBars(navbars),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Nos Espaces de coworking",
                  style: TextStyle(color: Colors.black54, fontSize: 30),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("space_coworking")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> data = snapshot.data!.docs;
                    return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Wrap(
                        children: data.map((doc) {
                          return Container(
                            margin: EdgeInsets.all(2),
                            alignment: Alignment.center,
                            height: 320,
                            width: 225,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black45,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: 225,
                                  child: Image.network(
                                    doc['img'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            doc['coworking_type'],
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          doc['description'],
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${doc['prix']} €",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Paymants().Pay(
                                                context,
                                                doc['prix'],
                                                doc['coworking_type'],
                                                doc['description'],
                                              );
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                color: navbar,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Découvrir",
                                                    style: TextStyle(
                                                      color: buttons,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Container();
                  }
                  return CircularProgressIndicator();
                }),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
