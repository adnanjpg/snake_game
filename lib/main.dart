import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_board_body.dart';
import 'snake_provider.dart';

void main() {
  runApp(SnakeGame());
}

class SnakeGame extends StatelessWidget {
  const SnakeGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SnakeProvider(),
      child: MaterialApp(
        home: GameBoard(),
      ),
    );
  }
}

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GameBoardBody(),
      ),
    );
  }
}
