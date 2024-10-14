import 'package:flutter/material.dart';

class ReadingNow extends StatefulWidget {
  const ReadingNow({super.key});

  @override
  State<ReadingNow> createState() => _ReadingNowState();
}

class _ReadingNowState extends State<ReadingNow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text("Reading Now",style:TextStyle(color: Colors.white)),
        ),
    );
  }
}
