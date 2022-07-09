import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../models/board_dimensions_model.dart';
import '../providers/board_size_provider.dart';
import '../utils/game_state.dart';
import 'dart:async';

import '../models/cube_model.dart';
import '../providers/snake_provider.dart';
import '../utils/consts.dart';
import 'game_board_background.dart';
import 'game_over_dialog.dart';
import 'points_body.dart';

class GameBoardBody extends StatelessWidget {
  const GameBoardBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        SchedulerBinding.instance.addPostFrameCallback(
          (_) {
            Provider.of<BoardDimensionsProvider>(context, listen: false).size =
                BoardDimensionsModel.fromConstraints(constraints);
          },
        );
        return const _Body();
      },
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
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

  final node = FocusNode();
  final fnode = FocusScopeNode();

  @override
  Widget build(BuildContext context) {
    return Consumer<SnakeProvider>(
      builder: (context, val, child) {
        return FocusScope(
          node: fnode,
          child: RawKeyboardListener(
            focusNode: node,
            onKey: prov.setDirectionByEvent,
            autofocus: true,
            child: Stack(
              children: [
                child!,
                ...snake(val.cubes),
              ],
            ),
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
