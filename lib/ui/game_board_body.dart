import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cube_model.dart';
import '../providers/snake_provider.dart';
import '../utils/consts.dart';
import '../utils/game_state.dart';
import 'game_board_background.dart';
import 'game_over_dialog.dart';
import 'points_body.dart';

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
            builder: (context) {
              return const GameOverDialog();
            },
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
          onKey: prov.setDirectionByEvent,
          autofocus: true,
          child: Stack(
            children: [
              child!,
              ...snake(val.cubes),
            ],
          ),
        );
      },
      child: Stack(
        children: [
          Container(color: dangerAreaColor),
          const GameBoardBackground(),
          const PointsBody(),
        ],
      ),
    );
  }

  List<Widget> snake(List<CubeModel> cubes) {
    return cubes.map(
      (model) {
        // if it's the last element,
        // which means the sanke's head
        if (cubes.last == model) {
          model = model.copyWith(color: snakeHeadColor);
        }

        return Positioned(
          left: model.x * cubeSize,
          top: model.y * cubeSize,
          child: model.cube(),
        );
      },
    ).toList();
  }
}
