import 'package:flutter/material.dart';

class newpage extends StatefulWidget {
  const newpage({Key? key}) : super(key: key);

  @override
  State<newpage> createState() => _newpageState();
}

class _newpageState extends State<newpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("welcome"),
      ),
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          color: Colors.black,
        ),
      ),
    );
  }
}
