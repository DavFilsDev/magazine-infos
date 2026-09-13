import 'package:flutter/material.dart';

class RedacteurInterface extends StatefulWidget {
  const RedacteurInterface({super.key});

  @override
  State<RedacteurInterface> createState() => _RedacteurInterfaceState();
}

class _RedacteurInterfaceState extends State<RedacteurInterface> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Redacteurs')));
  }
}
