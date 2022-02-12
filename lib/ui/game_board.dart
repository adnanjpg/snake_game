import 'package:flutter/material.dart';

import '../utils/game_state.dart';
import 'controls/controls_widgets.dart';
import 'game_board_body.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  void initState() {
    GameState.setDefaults();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: const [
            GameBoardBody(),
            ControlsWidgets(),
          ],
        ),
      ),
    );
  }
}
