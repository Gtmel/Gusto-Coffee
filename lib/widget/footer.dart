import 'package:flutter/material.dart';
import 'package:gusto_coffee_coworking_space/Helper/colors.dart';

Footer() => Container(
      height: 60,
      color: navbar,
      child: Column(
        children: [
          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "© 2023 Gusto Coffee Coworking space",
                style: TextStyle(color: Colors.black54, fontSize: 13),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Faites du travail un moment de qualité ",
                style: TextStyle(color: Colors.black54, fontSize: 12),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Privacy - Terms",
                  style: TextStyle(color: Colors.blue, fontSize: 12),
                ),
              )
            ],
          )
        ],
      ),
    );
