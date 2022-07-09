import 'package:flutter/material.dart';
import '../utils/game_state.dart';
import '../utils/settings_manager.dart';
import '../utils/translations.dart';

import '../utils/consts.dart';

enum _Controls {
  restart,
  settings;

  IconData get icon {
    switch (this) {
      case restart:
        return Icons.restart_alt;
      case settings:
        return Icons.settings;
    }
  }

  String get label {
    switch (this) {
      case restart:
        return getStr('restart');
      case settings:
        return getStr('settings');
    }
  }

  void onPressed() {
    switch (this) {
      case restart:
        return GameState.restart();
      case settings:
        return SettingsManager.showSettingsDialog();
    }
  }
}

class ControlsWidgets extends StatefulWidget {
  const ControlsWidgets({Key? key}) : super(key: key);

  @override
  State<ControlsWidgets> createState() => _ControlsWidgetsState();
}

class _ControlsWidgetsState extends State<ControlsWidgets> {
  bool entered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        entered = true;
        setState(() {});
      },
      onExit: (_) {
        entered = false;
        setState(() {});
      },
      child: Builder(
        builder: (context) {
          final iconThm = Theme.of(context).iconTheme;

          // return Column(
          //   children: _Controls.values
          //       .map(
          //         (control) => IconButton(
          //           onPressed: control.onPressed,
          //           icon: Icon(control.icon),
          //           color: entered
          //               ? iconThm.color
          //               : iconThm.color?.withOpacity(.4),
          //         ),
          //       )
          //       .toList(),
          // );

          return NavigationRail(
            selectedIndex: null,
            minWidth: 50,
            backgroundColor: gameBgColor,
            unselectedIconTheme: IconThemeData(
              color: entered ? iconThm.color : iconThm.color?.withOpacity(.4),
            ),
            onDestinationSelected: (index) {
              _Controls.values[index].onPressed();
            },
            destinations: _Controls.values
                .map(
                  (control) => NavigationRailDestination(
                    label: Text(control.label),
                    icon: Icon(control.icon),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
