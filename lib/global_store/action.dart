import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';

enum GlobalAction { changeThemeColor, changeLocale }

class GlobalActionCreator {
  static Action onchangeThemeColor() {
    return Action(GlobalAction.changeThemeColor);
  }

  static Action changeLocale(Locale locale) {
    return Action(GlobalAction.changeLocale, payload: locale);
  }
}
