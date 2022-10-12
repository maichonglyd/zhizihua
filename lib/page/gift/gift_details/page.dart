import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/gift/my_gift_item/component.dart'
    as my_gift;
import 'package:flutter_huoshu_app/model/gift/game_gifts_bean.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GiftDetailsPage extends Page<GiftDetailsState, Gift> {
  static final String pageName = "GiftDetailsPage";

  GiftDetailsPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          viewMiddleware: <ViewMiddleware<GiftDetailsState>>[
            safetyView<GiftDetailsState>(),
          ],
          dependencies: Dependencies<GiftDetailsState>(
              adapter: null, slots: <String, Dependent<GiftDetailsState>>{}),
          middleware: <Middleware<GiftDetailsState>>[],
        );
}
