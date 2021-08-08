import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../direction_enum.dart';
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
        return RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: (event) {
            // this method gets called on key up and down,
            // but we only want to work it on key down.
            // https://stackoverflow.com/a/50986257/12555423
            if (event.runtimeType == RawKeyDownEvent) {
              // i have no idea why, but `arrowUp` and `arrowDown`
              // each represent its exact reverse
              if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
                prov.addDirection(Direction.down);
              } else if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
                prov.addDirection(Direction.up);
              } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
                prov.addDirection(Direction.right);
              } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
                prov.addDirection(Direction.left);
              }
            }
          },
          autofocus: true,
          child: Stack(
            children: [
              child!,
              ...snake(val.cubes),
            ],
          ),
        );
      },
      child: bg(),
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
          left: model.x * size,
          top: model.y * size,
          child: model.cube(color: clr),
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
