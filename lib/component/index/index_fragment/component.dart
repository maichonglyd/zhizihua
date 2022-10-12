import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/component/index/index_fragment/list_adapter/adapter.dart';
import 'package:flutter_huoshu_app/component/index/index_fragment/reducer.dart';
import 'package:flutter_huoshu_app/component/index/search_bar/component.dart'
    as search_bar;
import 'effect.dart';
import 'state.dart';
import 'view.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';

class SingleTickerProviderStfState<IndexFragmentState>
    extends ComponentState<IndexFragmentState> with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<IndexFragmentState>
    on Component<IndexFragmentState> {
  @override
  SingleTickerProviderStfState<IndexFragmentState> createState() =>
      SingleTickerProviderStfState<IndexFragmentState>();
}

class IndexFragment extends Component<IndexFragmentState>
    with SingleTickerProviderMixin {
  IndexFragment()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<IndexFragmentState>(
                adapter:
                    NoneConn<IndexFragmentState>() + IndexFragmentAdapter(),
                slots: <String, Dependent<IndexFragmentState>>{
                  'search_bar':
                      SearchBarConnector() + search_bar.SearchBarComponent(),
                }),
            wrapper: keepAliveWrapper);
}
