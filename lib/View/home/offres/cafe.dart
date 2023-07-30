import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:gusto_coffee_coworking_space/Controller/paymentController.dart';

import '../../../Helper/colors.dart';
import '../../../widget/appbar.dart';
import '../../../widget/footer.dart';
import '../../../widget/navbar.dart';
import '../../../widget/paymants.dart';
import '../paymants/paypal_payments.dart';

class Cafe extends StatefulWidget {
  const Cafe({Key? key});

  @override
  State<Cafe> createState() => _CafeState();
}

class _CafeState extends State<Cafe> {
  final navbars = GlobalKey<ScaffoldState>();
  final stripePaymants = Get.put(PaymentController());
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
                  "forfait café & Viennoiseries",
                  style: TextStyle(color: Colors.black54, fontSize: 30),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("space_cafe&visio")
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
                                  height: 20,
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
                                            doc['forfait_type'],
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
                                                doc['forfait_type'],
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
