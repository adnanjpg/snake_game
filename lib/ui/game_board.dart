import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_board_body.dart';
import 'restart_button.dart';
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

  double dx = 0, dy = 0;

  toPositive(double e) {
    if (e < 0) {
      e = e * -1;
    }
    return e;
  }

  horizontalMove(double d) {
    if (d >= 0) {
      prov.addDirection(Direction.right);
    } else {
      prov.addDirection(Direction.left);
    }
  }

  verticalMove(double d) {
    if (d >= 0) {
      prov.addDirection(Direction.up);
    } else {
      prov.addDirection(Direction.down);
    }
  }

  onUpdate(DragUpdateDetails dets) {
    final double newDx = dets.delta.dx, newDy = dets.delta.dy;
    bool hor = false;
    // when a user swipes for example to the left,
    // they inintentionally swipe in a very small
    // percentage up or down.
    //
    // so we're calculating the bigger change, and
    // adding a movement accordingly.
    if (toPositive(newDx - dx) > toPositive(newDy - dy)) hor = true;
    dx = newDx;
    dy = newDy;
    if (hor) {
      horizontalMove(dx);
    } else {
      verticalMove(dy);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: onUpdate,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              GameBoardBody(),
              RestartButton(),
            ],
          ),
        ),
      ),
    );
  }
}
