import 'package:flutter/material.dart';
import 'package:user_authentication/login_page.dart';
import 'package:user_authentication/login_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final LoginService loginService = LoginService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
        backgroundColor:
            Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
        shadowColor: Theme.of(context).colorScheme.shadow,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
      body: Center(
        child: Text(
          'Welcome to the Home Page!',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontSize: 20,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
