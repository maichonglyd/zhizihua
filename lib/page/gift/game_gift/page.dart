import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/gift/gift_list/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameGiftPage extends Page<GameGiftState, Map<String, dynamic>> {
  static final String pageName = "GameGiftPage";
  GameGiftPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GameGiftState>(
                adapter: null,
                slots: <String, Dependent<GameGiftState>>{
                  GiftListFragment.componentName:
                  GiftListConnector() + GiftListFragment(),
                }),
            middleware: <Middleware<GameGiftState>>[
            ],);

}
