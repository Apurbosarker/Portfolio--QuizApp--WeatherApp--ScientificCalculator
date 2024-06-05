import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/Calculator/calculator_screen.dart';
import 'package:portfolio/Portfolio/MainPage.dart';
import 'package:portfolio/QuizApp/quiz_app.dart';
import 'package:portfolio/Weather%20app/screens/weather_home_screen.dart';
import 'package:portfolio/login_page.dart';

class MainScreen extends StatelessWidget {
  final VoidCallback toggleTheme;
  final ThemeMode themeMode;

  const MainScreen(
      {super.key, required this.toggleTheme, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apurbo_All_Project'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(themeMode == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: toggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const PortfolioMainPage()))
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildNavigationButton(
                context,
                label: "Portfolio",
                destination: const LoginPage(),
              ),
              const SizedBox(height: 20),
              _buildNavigationButton(
                context,
                label: "Quiz App",
                destination: const QuizApp(),
              ),
              const SizedBox(height: 20),
              _buildNavigationButton(
                context,
                label: "Calculator",
                destination: const CalculatorScreen(),
              ),
              const SizedBox(height: 20),
              _buildNavigationButton(
                context,
                label: "Weather App",
                destination: const WeatherHomeScreen(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _buildNavigationButton(BuildContext context,
      {required String label, required Widget destination}) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => destination),
        )
      },
      child: Container(
        height: 50,
        width: 120,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.red, Colors.orange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
