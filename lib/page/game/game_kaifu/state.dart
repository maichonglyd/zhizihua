import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/index_kf_fragment/state.dart'
    as kf_fragment;
import 'package:flutter_huoshu_app/component/index/index_kf_fragment/state.dart';

class KaifuGameState implements Cloneable<KaifuGameState> {
  KfFragmentState kfFragmentState;
  @override
  KaifuGameState clone() {
    return KaifuGameState()..kfFragmentState = kfFragmentState;
  }
}

KaifuGameState initState(Map<String, dynamic> args) {
  return KaifuGameState();
}

class KfFragmentConnector
    extends ConnOp<KaifuGameState, kf_fragment.KfFragmentState> {
  @override
  void set(KaifuGameState state, kf_fragment.KfFragmentState subState) {
    state.kfFragmentState = subState;
  }

  @override
  kf_fragment.KfFragmentState get(KaifuGameState state) {
    return state.kfFragmentState;
  }
}
