import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back))],

        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 24),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black.withOpacity(0.4),
            systemNavigationBarColor:
                Color.lerp(Colors.white, Colors.black, 0.4)),
      ),
      body: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
