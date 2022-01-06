import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'game_over_dialog.dart';
import 'game_board_background.dart';
import '../enums/direction_enum.dart';
import '../game_state.dart';
import '../snake_provider.dart';
import '../consts.dart';
import '../cube_model.dart';

class GameBoardBody extends StatefulWidget {
  const GameBoardBody({Key? key}) : super(key: key);

  @override
  _GameBoardBodyState createState() => _GameBoardBodyState();
}

class _GameBoardBodyState extends State<GameBoardBody> {
  late SnakeProvider prov;
  @override
  void initState() {
    prov = Provider.of<SnakeProvider>(context, listen: false);
    task(_) {
      if (!GameState.paused) {
        prov.forward();
        if (prov.gameOver) {
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
          Duration(microseconds: 450000 - (10000 * speed)),
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
        return RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: (event) {
            // this method gets called on key up and down,
            // but we only want to work it on key down.
            // https://stackoverflow.com/a/50986257/12555423
            if (event.runtimeType == RawKeyDownEvent) {
              // i have no idea why, but `arrowUp` and `arrowDown`
              // each represent its exact reverse
              if (event.isKeyPressed(LogicalKeyboardKey.arrowUp))
                prov.setDirection(Direction.down);
              else if (event.isKeyPressed(LogicalKeyboardKey.arrowDown))
                prov.setDirection(Direction.up);
              else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight))
                prov.setDirection(Direction.right);
              else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft))
                prov.setDirection(Direction.left);
            }
          },
          autofocus: true,
          child: Stack(
            children: [
              Container(color: dangerAreaColor),
              child!,
              ...snake(val.cubes),
            ],
          ),
        );
      },
      child: GameBoardBackground(),
    );
  }

  List<Widget> snake(List<CubeModel> cubes) {
    return cubes.map(
      (model) {
        Color? clr;
        // if it's the last element,
        // which means the sanke's head
        if (cubes.last == model) {
          clr = snakeHeadColor;
        }
        return Positioned(
          left: model.x * cubeSize,
          top: model.y * cubeSize,
          child: model.cube(color: clr),
        );
      },
    ).toList();
  }
}
