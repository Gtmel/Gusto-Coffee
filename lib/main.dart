import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:gusto_coffee_coworking_space/Helper/colors.dart';
import 'package:gusto_coffee_coworking_space/View/welcome.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      "pk_test_51L5CzEKV4kfNcsDvOAb4VYYiuOB5qnanWnUJwTbIVjLhrEz667GWiASEk5B4LtgyHujEb1o3DjbjwlamFefDw1vc00AIxIDqk5";
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(880, name: MOBILE),
          ResponsiveBreakpoint.autoScale(3000, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
      ),
      title: 'Gusto Coffee Coworking space',
      color: navbar,
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
