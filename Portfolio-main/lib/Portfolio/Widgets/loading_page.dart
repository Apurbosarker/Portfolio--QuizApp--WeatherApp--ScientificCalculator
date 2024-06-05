import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              color: Color(0xff03438C),
            ),
            SizedBox(height: 16.0),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
