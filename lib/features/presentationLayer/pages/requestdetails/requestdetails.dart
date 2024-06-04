import 'package:flutter/material.dart';

class RequestDetails extends StatelessWidget {
  String name;
   RequestDetails({super.key,required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(name),
        centerTitle: true,
      ),
    );
  }
}
