import 'package:flutter/material.dart';

import '../models/cube_model.dart';
import '../utils/consts.dart';

class _SpaceUnit extends StatelessWidget {
  final Decoration decoration;
  final CubeModel model;

  const _SpaceUnit({
    required this.model,
    required this.decoration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cubeSize,
      height: cubeSize,
      decoration: decoration,
    );
  }
}

class Cube extends StatelessWidget {
  final CubeModel model;

  const Cube(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SpaceUnit(
      model: model,
      decoration: BoxDecoration(
        border: Border.all(
          width: borderWidth,
        ),
        color: model.color,
      ),
    );
  }
}

class ScorePoint extends StatelessWidget {
  final CubeModel model;

  const ScorePoint(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SpaceUnit(
      model: model,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: model.color,
      ),
    );
  }
}
