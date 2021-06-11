import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'snake_provider.dart';
import 'ui/game_board.dart';

void main() {
  runApp(SnakeGame());
}

final GlobalKey<NavigatorState> navKey = GlobalKey();

class SnakeGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SnakeProvider(),
      child: MaterialApp(
        navigatorKey: navKey,
        home: GameBoard(),
      ),
    );
  }
}
