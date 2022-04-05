import 'package:flutter/material.dart';
import 'package:log_allergy/login/login.dart';
import 'package:log_allergy/services/auth.dart';
import 'package:log_allergy/allergyLog/allergyLog.dart';
import 'package:log_allergy/shared/shared.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return const Center(
            child: ErrorMessage(),
          );
        } else if (snapshot.hasData) {
          return const AllergyLogScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
