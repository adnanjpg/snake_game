import 'package:flutter/material.dart';

import '../models/board_dimensions_model.dart';

class BoardDimensionsProvider extends ChangeNotifier {
  final BuildContext context;

  BoardDimensionsProvider(this.context);

  BoardDimensionsModel _size = const BoardDimensionsModel(12, 12);

  set size(BoardDimensionsModel size) {
    _size = size;
    notifyListeners();
  }

  BoardDimensionsModel get size => _size;

  int get x => _size.x;
  int get y => _size.y;

  void setXY(int x, int y) {
    size = BoardDimensionsModel(x, y);
    notifyListeners();
  }

  void setX(int x) {
    size = BoardDimensionsModel(x, _size.y);
    notifyListeners();
  }

  void setY(int y) {
    size = BoardDimensionsModel(_size.x, y);
    notifyListeners();
  }
}
