import 'package:flutter/widgets.dart';
import 'package:educacao_idoso/core/state/app_state.dart';

class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({required AppState state, required super.child, super.key}) : super(notifier: state);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    return scope?.notifier ?? appState;
  }
}
