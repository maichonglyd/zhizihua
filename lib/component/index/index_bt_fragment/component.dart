import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/index/bt_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/gm_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/h5_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/hand_tour_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/index_bt_fragment/list_adapter/adapter.dart';
import 'package:flutter_huoshu_app/component/index/jp_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/zk_fragment/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';

class SingleTickerProviderStfState<IndexFragmentState>
    extends ComponentState<IndexFragmentState> with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<IndexBtFragmentState>
    on Component<IndexBtFragmentState> {
  @override
  SingleTickerProviderStfState<IndexBtFragmentState> createState() =>
      SingleTickerProviderStfState<IndexBtFragmentState>();
}

class IndexBtFragment extends Component<IndexBtFragmentState>
    with SingleTickerProviderMixin {
  IndexBtFragment()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<IndexBtFragmentState>(
//                adapter: null,
//                slots: <String, Dependent<IndexBtFragmentState>>{
//                  "bt_fragment":BtFragmentConnector()+ BtFragmentComponent(),
//                  "ht_fragment":HtFragmentConnector()+ HtFragmentComponent(),
//                  "zk_fragment":ZKFragmentConnector()+ ZKFragmentComponent(),
//                  "jp_fragment":JpFragmentConnector()+ JpFragmentComponent(),
//                  "gm_fragment": GmFragmentConnector() + GmFragmentComponent(),
//                  "h5_fragment":H5FragmentConnector()+ H5FragmentComponent(),
//                  "gl_fragment":GLFragmentConnector()+ GlFragmentComponent(),
//
//                }
            adapter:
                NoneConn<IndexBtFragmentState>() + IndexBtFragmentAdapter(),
          ),
          wrapper: keepAliveWrapper,
        );
}
