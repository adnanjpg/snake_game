import 'package:flutter/material.dart';

import '../utils/game_state.dart';
import '../utils/translations.dart';

class GameOverDialog extends StatelessWidget {
  const GameOverDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(getStr('game_over')),
      actions: [
        ElevatedButton(
          onPressed: () {
            // for some reason [Navigator.of(context).pop()]
            // did not wanna pop??
            Navigator.of(context, rootNavigator: true)
                .popUntil((route) => route.isFirst);

            GameState.restart();
          },
          child: Text(getStr('restart')),
        ),
      ],
    );
  }
}
