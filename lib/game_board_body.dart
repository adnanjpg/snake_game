import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'direction_enum.dart';
import 'snake_provider.dart';
import 'consts.dart';
import 'cube_model.dart';

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
    Future.microtask(() {
      Timer.periodic(
        Duration(seconds: 2),
        (_) {
          SnakeProvider.direction = Direction
              .values[Random.secure().nextInt(Direction.values.length)];
          w.forward();
        },
      );
    });

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
    return cubes
        .map(
          (e) => Positioned(
            left: e.x * size,
            top: e.y * size,
            child: e.cube(),
          ),
        )
        .toList();
  }

  Widget bg() {
    return Column(
      children: List.generate(
        boardSize,
        (y) => Row(
          children: List.generate(
            boardSize,
            (x) => CubeModel(x, y, bgCubeColor).cube(),
          ),
        ),
      ),
    );
  }
}
