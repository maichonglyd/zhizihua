import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/global_store/state.dart';

class GlobalConnOp<T extends GlobalBaseState<T>, P extends GlobalBaseState<P>>
    extends MutableConn<T, P> with ConnOpMixin<T, P> {
  final P Function(T) _getter;
  final void Function(T, P) _setter;

  const GlobalConnOp({
    P Function(T) getSub,
    void Function(T, P) set,
  })  : _getter = getSub,
        _setter = set;

  @override
  P get(T state) => _getter(state)..copyGlobalFrom(state);

  @override
  void set(T state, P subState) => _setter(state, subState);
}
