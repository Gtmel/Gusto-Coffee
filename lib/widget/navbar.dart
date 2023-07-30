import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gusto_coffee_coworking_space/Helper/colors.dart';
import 'package:gusto_coffee_coworking_space/View/home/offres/coworking.dart';
import 'package:gusto_coffee_coworking_space/View/welcome.dart';

import '../View/home/offres/cafe.dart';
import '../View/home/profil.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: navbar,
      child: ListView(
        children: [
          ListTile(
            leading: Text(
              "Mon compte",
              style: TextStyle(
                color: buttons,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profil()));
            },
          ),
          ExpansionTile(
            title: Text(
              "Nos offres",
              style: TextStyle(
                color: buttons,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Coworking()));
                    },
                    child: Text(
                      " Nos Espace de Coworking",
                      style: TextStyle(color: buttons, fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 9,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Cafe()));
                    },
                    child: Text(
                      " Nos Forfait Café & Viennoiseries",
                      style: TextStyle(color: buttons, fontSize: 18),
                    ),
                  ),
                ],
              )
            ],
          ),
          ListTile(
            leading: Text(
              "A Propos",
              style: TextStyle(
                color: buttons,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Text(
              "Contact",
              style: TextStyle(
                color: buttons,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 410,
          ),
          ListTile(
            leading: Icon(
              Icons.logout_outlined,
              color: buttons,
              size: 40,
            ),
            title: Text(
              "Déconnexion",
              style: TextStyle(
                color: buttons,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              logout();
            },
          ),
        ],
      ),
    );
  }

  final _auth = FirebaseAuth.instance;
  logout() {
    _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
        (route) => false);
  }
}
