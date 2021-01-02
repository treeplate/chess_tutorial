import 'package:flutter/material.dart';

import 'grid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pageId = 0;
  late List<ChessPage> pages = [
    BasicChessPage(
      newPage: () => pageId++,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[pageId],
      ),
    );
  }
}

abstract class ChessPage extends StatefulWidget {
  final void Function() newPage;
  List<GridCell> get cells;
  int get width;
  String get debugInfo => "$cells; $width";

  ChessPage({Key? key, required this.newPage}) : super(key: key);
  @override
  _ChessPageState createState() => _ChessPageState();
}

class _ChessPageState extends State<ChessPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: GridDrawer(widget.cells, widget.width));
  }
}

class BasicChessPage extends ChessPage {
  BasicChessPage({
    Key? key,
    required void Function() newPage,
  }) : super(
          key: key,
          newPage: newPage,
        );
  @override
  List<GridCell> get cells => List.generate(64, (int index) => EmptyGridCell());
  int get width => 8;
}
