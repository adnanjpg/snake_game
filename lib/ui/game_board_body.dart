import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../game_state.dart';
import '../snake_provider.dart';
import '../consts.dart';
import '../cube_model.dart';
import 'game_over_dialog.dart';

class GameBoardBody extends StatefulWidget {
  const GameBoardBody({Key? key}) : super(key: key);

  @override
  _GameBoardBodyState createState() => _GameBoardBodyState();
}

class _GameBoardBodyState extends State<GameBoardBody> {
  late SnakeProvider w;
  @override
  void initState() {
    w = Provider.of<SnakeProvider>(context, listen: false);
    task(Timer _) {
      if (!GameState.paused) {
        w.forward();
        if (w.gameOver) {
          GameState.paused = true;
          showDialog(
            context: context,
            builder: (context) => GameOverDialog(),
          );
        }
      }
    }

    Future.microtask(
      () {
        Timer.periodic(
          Duration(milliseconds: 1000),
          task,
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SnakeProvider>(
      builder: (context, val, child) {
        return Stack(
          children: [
            child!,
            ...snk(val.cubes),
          ],
        );
      },
      child: bg(),
    );
  }

  List<Widget> snk(List<CubeModel> cubes) {
    return cubes.map(
      (e) {
        Color? clr;
        // if it's the last element,
        // which means the sanke's head
        if (cubes.last == e) {
          clr = snakeHeadColor;
        }
        return Positioned(
          left: e.x * size,
          top: e.y * size,
          child: e.cube(color: clr),
        );
      },
    ).toList();
  }

  Widget bg() {
    return Column(
      children: List.generate(
        boardSizeY,
        (y) => Row(
          children: List.generate(
            boardSizeX,
            (x) => CubeModel.bgCube(x, y).cube(),
          ),
        ),
      ),
    );
  }
}
