import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:gusto_coffee_coworking_space/Helper/colors.dart';
import 'package:gusto_coffee_coworking_space/Model/user_reserve.dart';
import 'package:gusto_coffee_coworking_space/widget/navbar.dart';

import '../Controller/paymentController.dart';
import '../View/home/paymants/paypal_payments.dart';

class Paymants {
  final stripePaymants = Get.put(PaymentController());
  Pay(BuildContext context, int price, String itemName, String description) =>
      showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Color.fromARGB(29, 43, 43, 43),
        elevation: 0,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            child: Wrap(children: [
              Container(
                decoration: BoxDecoration(
                  color: navbar,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0)),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        PaypalPayment(
                                                  onFinish: (number) async {
                                                    // payment done
                                                    print(
                                                        'order id: ' + number);
                                                  },
                                                  itemName: itemName,
                                                  price: "${price}",
                                                ),
                                              ),
                                            );
                                            userReservation(
                                                price, itemName, description);
                                          },
                                          child: Icon(
                                            Icons.paypal,
                                            size: 60,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Paypal",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            cartePaymant(
                                                price, itemName, description);
                                            print(price);
                                            Navigator.pop(context);
                                          },
                                          child: Icon(
                                            Icons.payment,
                                            size: 60,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Visa/Master card",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          );
        },
      );

  cartePaymant(int price, String itemName, String description) async {
    if (stripePaymants != null) {
      await stripePaymants.makePayment(
          amount: "${price.round()}", currency: "EUR");
      displayPaymentSheet(price, itemName, description);
    }
  }

  displayPaymentSheet(int price, String itemName, String description) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      Get.snackbar('Payment', 'Payment Successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));
      userReservation(price, itemName, description);
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  userReservation(int price, String itemName, String description) {
    User? user = FirebaseAuth.instance.currentUser;
    UserReserve userR = UserReserve();
    userR.prix = price;
    userR.itemName = itemName;
    userR.description = description;

    FirebaseFirestore.instance
        .collection("UserReserve/${user!.uid}/Reservation")
        .doc()
        .set(userR.toMap());
  }
}
