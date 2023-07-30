import 'package:flutter/material.dart';
import 'package:gusto_coffee_coworking_space/Helper/colors.dart';
import 'package:gusto_coffee_coworking_space/widget/navbar.dart';

import '../../Helper/images.dart';
import '../../widget/appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final navbars = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      key: navbars,
      endDrawer: Navbar(),
      appBar: AppBars(navbars),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Home"),
            ],
          )
        ],
      ),
    );
  }
}
