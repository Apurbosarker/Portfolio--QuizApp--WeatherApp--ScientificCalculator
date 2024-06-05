import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key, required bool isDarkMode});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Account',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            subtitle: const Text('Manage your account settings'),
            onTap: () {
              // Handle the tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Privacy'),
            subtitle: const Text('Manage your privacy settings'),
            onTap: () {
              // Handle the tap
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Preferences',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            subtitle: const Text('Receive notifications from the app'),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.brightness_6),
            title: const Text('Dark Mode'),
            subtitle: const Text('Use dark mode for the app'),
            value: _darkModeEnabled,
            onChanged: (bool value) {
              setState(() {
                _darkModeEnabled = value;
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: const Text('Choose your preferred language'),
            onTap: () {
              // Handle the tap
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'About',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            subtitle: const Text('Learn more about this app'),
            onTap: () {
              // Handle the tap
            },
          ),
        ],
      ),
    );
  }
}
