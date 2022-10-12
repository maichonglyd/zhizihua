import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';

abstract class GlobalBaseState<T extends Cloneable<T>> implements Cloneable<T> {
  Locale locale;


  void copyGlobalFrom(GlobalBaseState from) {
    locale = from.locale;
  }
}

class GlobalState with GlobalBaseState<GlobalState> {
  @override
  GlobalState clone() {
    return GlobalState()..copyGlobalFrom(this);
  }
}
