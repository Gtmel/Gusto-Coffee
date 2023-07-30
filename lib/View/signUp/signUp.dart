import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:gusto_coffee_coworking_space/Model/user_model.dart';
import '../../Helper/colors.dart';
import '../../widget/footer.dart';
import '../home/offres/cafe.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final firstName = TextEditingController();
  final secondName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool visible = true;
  bool isVisible = true;
  bool loading = false;

  Loading() async {
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: navbar,
        elevation: 0,
        toolbarHeight: 70,
        leading: IconButton(
          onPressed: () {},
          icon: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: buttons,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Inscription",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Votre prénom",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: firstName,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Merci d'entrer votre prénom"),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Entrer votre prénom";
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Votre nom",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: secondName,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Merci d'entrer votre nom"),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Entrer votre nom";
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Votre email",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Merci d'entrer votre email"),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Entrer votre adresse email";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Veillez entre un email valide");
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Mot de passe",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: password,
                          obscureText: visible,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    visible = !visible;
                                  });
                                },
                                icon: visible
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                              ),
                              hintText: "Merci d'entrer votre un mot de passe"),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Entrer votre mot de passe";
                            } else {
                              if (value.trim().length < 6) {
                                return "Minimun 6 caracteres";
                              }
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Confirmation mot de passe",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: passwordConfirm,
                          obscureText: isVisible,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: isVisible
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                              ),
                              hintText:
                                  "Merci de confirmer votre mot de passe "),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Confirmer le mot passe";
                            } else if (passwordConfirm.text.length > 0 &&
                                password.text != value) {
                              return "Le mot de passe ne correspond pas";
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    loading
                        ? CircularProgressIndicator(
                            color: Colors.blue,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  signup(email.text, password.text);
                                  Loading();
                                },
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "S'inscrire",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  signup(String email, String password) async {
    if (formkey.currentState!.validate()) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {userData()})
          // ignore: body_might_complete_normally_catch_error
          .catchError((e) {
        Get.snackbar(
          "Error",
          e.msg,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
        );
      });
    }
  }

  final firestore = FirebaseFirestore.instance;
  final data = UserModel();

  userData() async {
    User? user = FirebaseAuth.instance.currentUser;
    data.uid = user!.uid;
    data.firstName = firstName.text;
    data.secondName = secondName.text;
    data.email = user.email;
    await firestore.collection("Client").doc(user.uid).set(data.toMap());
    Get.snackbar(
      "Compte creé",
      "avec succes",
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
    );
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Cafe()), (route) => false);
  }
}
