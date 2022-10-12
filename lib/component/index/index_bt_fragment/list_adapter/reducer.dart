import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/index_bt_fragment/state.dart';

//这个类都要不然联系不上adapter
Reducer<IndexBtFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<IndexBtFragmentState>>{},
  );
}
