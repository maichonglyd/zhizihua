import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<IndexFragmentState> buildReducer() {
  return asReducer(<Object, Reducer<IndexFragmentState>>{
    Lifecycle.dispose: _dispose,
  });
}

IndexFragmentState _dispose(IndexFragmentState state, Action action) {
  state.scrollController.dispose();
  return null;
}
