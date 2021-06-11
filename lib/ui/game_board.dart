import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_board_body.dart';
import '../direction_enum.dart';
import '../snake_provider.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late SnakeProvider prov;
  @override
  void initState() {
    prov = Provider.of<SnakeProvider>(context, listen: false);
    prov.setDefaults();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails dets) {
        final double d = dets.delta.dx;

        if (d >= 0) {
          prov.addDirection(Direction.right);
        } else {
          prov.addDirection(Direction.left);
        }
      },
      onVerticalDragUpdate: (DragUpdateDetails dets) {
        final double d = dets.delta.dy;

        if (d >= 0) {
          prov.addDirection(Direction.up);
        } else {
          prov.addDirection(Direction.down);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: GameBoardBody(),
        ),
      ),
    );
  }
}
