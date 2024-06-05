import 'dart:io';
import 'dart:js_util';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Widgets/loading_page.dart';
// import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class PortfolioHomePage extends StatefulWidget {
  bool? isDarkMode = false;
  PortfolioHomePage({super.key, this.isDarkMode});

  @override
  _PortfolioHomePageState createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  // color: (widget.isDarkMode == true )? Colors.white : Colors.black ,
                  borderRadius: BorderRadius.zero,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey
                          .withOpacity(0.5), // Shadow color with opacity
                      spreadRadius: 5, // Spread radius
                      blurRadius: 7, // Blur radius
                      offset: const Offset(0, 3), // Offset of the shadow
                    ),
                  ], // Adjust the radius as needed
                  image: const DecorationImage(
                      image: AssetImage('assets/weather/My_Image.png'),
                      fit: BoxFit.contain),
                ),
              ),

              // CircleAvatar(
              //   radius: 80,
              //   backgroundImage: AssetImage('Image/My_Image.png'),
              // ),
              const SizedBox(height: 20),
              const Text(
                'Apurbo Sarker',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Flutter Developer',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                child: const Text('View Portfolio'),
              ),
              const SizedBox(height: 20),
              // Social Media Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      final url = Uri.parse(
                          "https://www.facebook.com/apurbo.sarker.9066/");
                      const LoadingPage(); // Assuming LoadingPage is a function that shows a loading indicator.
                      if (await launchUrl(
                        url,
                        mode: LaunchMode.inAppWebView,
                      )) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: const Icon(
                      FontAwesomeIcons.facebook,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () async {
                      final url = Uri.parse(
                          "https://www.instagram.com/apurbo_sarker31/");
                      const LoadingPage(); // Assuming LoadingPage is a function that shows a loading indicator.
                      if (await launchUrl(
                        url,
                        mode: LaunchMode.inAppWebView,
                      )) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: const Icon(
                      FontAwesomeIcons.instagram,
                      size: 30,
                      color: Colors.pink,
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () async {
                      final url = Uri.parse("https://github.com/Apurbosarker");
                      const LoadingPage(); // Assuming LoadingPage is a function that shows a loading indicator.
                      if (await launchUrl(
                        url,
                        mode: LaunchMode.inAppWebView,
                      )) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: Icon(
                      FontAwesomeIcons.github,
                      size: 30,
                      color: (widget.isDarkMode == true)
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () async {
                      final url = Uri.parse(
                          "https://mail.google.com/mail/u/0/#inbox?compose=new");
                      const LoadingPage(); // Assuming LoadingPage is a function that shows a loading indicator.
                      if (await launchUrl(
                        url,
                        mode: LaunchMode.inAppWebView,
                      )) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: const Icon(
                      FontAwesomeIcons.envelope,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () async {
                      final url = Uri.parse(
                          "https://www.youtube.com/watch?v=yGfA3N2-Aco");
                      const LoadingPage(); // Assuming LoadingPage is a function that shows a loading indicator.
                      if (await launchUrl(
                        url,
                        mode: LaunchMode.inAppWebView,
                      )) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: Icon(
                      FontAwesomeIcons.youtube,
                      size: 30,
                      color: (widget.isDarkMode == true)
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(25.0),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(
                      'I am Apurbo Sarker, and my hometown is Manikganj, Dhaka. I completed my SSC at Monsur Uddin M/L High School and my HSC at Govt. Debendra College in Manikganj.\n\n'
                      'Currently, I am studying at Daffodil International University in the Department of Computer Science and Engineering. Daffodil International University is a renowned educational institution in Bangladesh known for its quality education and focus on technological advancements.\n\n'
                      'My choice of studying computer science and engineering indicates a strong interest in technology and its applications. This field offers various opportunities to explore programming, software development, data analysis, and other related disciplines.\n\n'
                      'I love my parents very much, and I always try to keep them happy. Being with my parents in all situations of life is my greatest hobby.',
                      softWrap: true,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
