import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gusto_coffee_coworking_space/Helper/colors.dart';
import 'package:gusto_coffee_coworking_space/Model/user_model.dart';
import 'package:gusto_coffee_coworking_space/widget/appbar.dart';

import '../../widget/footer.dart';
import '../../widget/navbar.dart';
import '../reservation/reservation.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final navbars = GlobalKey<ScaffoldState>();
  UserModel use = UserModel();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("Client")
        .doc(user!.uid)
        .get()
        .then((value) {
      use = UserModel.toMap(value.data());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      key: navbars,
      endDrawer: Navbar(),
      appBar: AppBars(navbars),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Mon Compte',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Bienvenue ${use.firstName} dans votre compte.",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
          Text(
            "C'est dans cet espace que vous allez pouvoir gérer toutes vos informations personnelles et vos réservations.",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "-",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Modifier mot de passe",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                          ),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "-",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Ajouter mes adresse",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                          ),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "-",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Reservstion()));
                        },
                        child: Text(
                          "Gérer mes commandes/reservations",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                          ),
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
