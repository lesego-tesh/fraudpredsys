import 'package:flutter/material.dart';

class resultsScreen extends StatefulWidget {
  final List<String> jsondata;

  const resultsScreen({Key? key, required this.jsondata}) : super(key: key);
  @override
  _resultsScreenState createState() => _resultsScreenState();
}

class _resultsScreenState extends State<resultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Prediction")),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Text(widget.jsondata[0]);
          },
        ));
  }
}
