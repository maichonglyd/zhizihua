import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/redux_connector/global_connector.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fun_list/component.dart'
    as mine_fun_list;
import 'package:flutter_huoshu_app/component/mine/mine_top_tab/component.dart'
    as mine_top_tab;
import 'package:flutter_huoshu_app/component/mine/mine_top_tab/state.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MineFragment extends Component<MineFragmentState> {
  static final String pageName = "MineFragment";
  MineFragment()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<MineFragmentState>(
                adapter: null,
                slots: <String, Dependent<MineFragmentState>>{
                  mine_top_tab.MineTopTabComponent.componentName:
                      MineTopTabConnector() +
                          mine_top_tab.MineTopTabComponent(),
                  mine_fun_list.MineFunListComponent.componentName:
                      MineFunListConnector() +
                          mine_fun_list.MineFunListComponent(),
                }),
            wrapper: keepAliveWrapper);
}
