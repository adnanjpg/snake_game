import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_board_body.dart';
import 'restart_button.dart';
import '../snake_provider.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  void initState() {
    Provider.of<SnakeProvider>(context, listen: false).setDefaults();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // TODO: center this
            GameBoardBody(),
            RestartButton(),
          ],
        ),
      ),
    );
  }
}
