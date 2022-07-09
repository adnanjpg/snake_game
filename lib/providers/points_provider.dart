import 'dart:math';

import 'package:flutter/material.dart';

import '../models/board_dimensions_model.dart';
import '../models/cube_model.dart';
import '../utils/consts.dart';

class PointsProvider extends ChangeNotifier {
  final BuildContext context;

  BoardDimensionsModel dimension;

  PointsProvider({
    required this.context,
    required this.dimension,
  });

  void setDimension(BoardDimensionsModel dimension) {
    this.dimension = dimension;
  }

  final List<CubeModel> _list = [];

  void setDefaults() {
    clear();

    fillRandom();

    Future.microtask(() {
      notifyListeners();
    });
  }

  List<CubeModel> get list => _list;

  void _add(CubeModel cubeModel) {
    _list.add(cubeModel);
  }

  void fillRandom() {
    while (_list.length < pointCount) {
      addRandom();
    }
  }

  void addRandom() {
    final random = Random.secure();

    var ranX = random.nextInt(dimension.x), ranY = random.nextInt(dimension.y);

    if (_list.any((element) => element.x == ranX && element.y == ranY)) {
      // keep recursing until we find a valid position
      addRandom();
    } else {
      final model = CubeModel.point(ranX, ranY);

      _add(model);
    }
  }

  void removeAt(int x, int y) {
    final idx = _list.indexWhere((cube) => cube.x == x && cube.y == y);

    remove(idx);
  }

  void remove(int idx) {
    if (idx >= 0 && idx < _list.length) _list.removeAt(idx);
  }

  bool matches(CubeModel cubeModel) {
    final idx = _list.indexWhere((c) => c == cubeModel);

    final match = idx != -1;

    if (match) {
      remove(idx);
      fillRandom();
      notifyListeners();
    }

    return match;
  }

  void clear() {
    _list.clear();
  }
}
