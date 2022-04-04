import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:async';

// Future<Prediction> fetchPrediction()async{

  // final response = await http.get(Uri.parse())
// }


class Prediction extends StatelessWidget {
  const Prediction({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        //drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Prediction'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  0: IntrinsicColumnWidth(),
                  1: FlexColumnWidth(),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: <TableRow>[
                  TableRow(
                    children:  <Widget>[
                      TableCell(
                          child: RichText(
                              text: const TextSpan(
                                  text: "Data Type",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)))),
                      Container(
                        height: 64,
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableCell(
                        child: Container(
                          height: 64,
                        ),
                      ),
                      Container(
                        height: 64,
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableCell(
                        child: Container(
                          height: 64,
                        ),
                      ),
                      Container(
                        height: 64,
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableCell(
                        child: Container(
                          height: 64,
                        ),
                      ),
                      Container(
                        height: 64,
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableCell(
                        child: Container(
                          height: 64,
                        ),
                      ),
                      Container(
                        height: 64,
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableCell(
                        child: Container(
                          height: 64,
                        ),
                      ),
                      Container(
                        height: 64,
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableCell(
                        child: Container(
                          height: 64,
                        ),
                      ),
                      Container(
                        height: 64,
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableCell(
                        child: Container(
                          height: 64,
                        ),
                      ),
                      Container(
                        height: 64,
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableCell(
                        child: Container(
                          height: 64,
                        ),
                      ),
                      Container(
                        height: 64,
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableCell(
                        child: Container(
                          height: 64,
                        ),
                      ),
                      Container(
                        height: 64,
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableCell(
                        child: Container(
                          height: 64,
                        ),
                      ),
                      Container(
                        height: 64,
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      );
}
