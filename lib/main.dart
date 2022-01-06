import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'utils/game_state.dart';
import 'providers/snake_provider.dart';
import 'ui/game_board.dart';

void main() {
  runApp(SnakeGame());
}

class SnakeGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SnakeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: GameState.navKey,
        home: GameBoard(),
      ),
    );
  }
}
