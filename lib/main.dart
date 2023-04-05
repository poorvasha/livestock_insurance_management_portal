import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lsi_management_portal/configs/Resources.dart';
import 'package:lsi_management_portal/screens/HomeScreen.dart';
import 'package:lsi_management_portal/screens/LoginScreen.dart';
import 'package:provider/provider.dart';

import 'configs/Routes.dart';
import 'providers/AppModel.dart';
import 'widgets/TextFieldWidget.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppModel()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insurance App Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Routes.RouteController,
      home: displayHome(context),
    );
  }

  Widget displayHome(BuildContext context) {
    var currentroute = context.watch<AppModel>().getInitialRoute;
    switch (currentroute) {
      case 'LoginScreen':
        return const LoginScreen();
      case 'HomeScreen':
        return const HomeScreen();
      case 'FlashScreen':
        return const FlashScreen();
      default:
        return const LoginScreen();
    }
  }
}

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0), () {
      // TODO : Check if user is login or not and navigate according it
      context.read<AppModel>().setInitialRoute = "LoginScreen";
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: Resources.primaryColor,
      body: const Center(
        child: CircularProgressIndicator(
          color: Resources.white,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
