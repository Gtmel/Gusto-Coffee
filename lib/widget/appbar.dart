import 'package:flutter/material.dart';
import 'package:gusto_coffee_coworking_space/Helper/colors.dart';

import '../Helper/images.dart';

AppBars(GlobalKey<ScaffoldState> navbars) => AppBar(
      backgroundColor: navbar,
      elevation: 0,
      toolbarHeight: 70,
      leading: Image.asset(
        logo,
        fit: BoxFit.cover,
      ),
      leadingWidth: 110,
      actions: [
        IconButton(
          onPressed: () => navbars.currentState!.openEndDrawer(),
          icon: Icon(Icons.menu),
          color: buttons,
        ),
      ],
    );
