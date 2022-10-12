import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action, Page;
import 'package:flutter_huoshu_app/component/game/game_details_fragment/component.dart'
    as game_details;
import 'package:flutter_huoshu_app/component/game/game_details_rebate/component.dart'
    as game_rebate;
import 'package:flutter_huoshu_app/component/deal/account_deal/game_details_deal_fragment/component.dart'
    as game_deal;
import 'package:flutter_huoshu_app/component/gift/game_details_gift/component.dart'
    as game_gift;
import 'package:flutter_huoshu_app/widget/loading_refresh.dart';

import '../../component/game/game_community/component.dart';
import '../../component/game/game_detail_coupon/component.dart';
import 'action.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SingleTickerProviderStfState<GameDetailsState>
    extends ComponentState<GameDetailsState> with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<GameDetailsState>
    on Component<GameDetailsState> {
  @override
  SingleTickerProviderStfState<GameDetailsState> createState() =>
      SingleTickerProviderStfState<GameDetailsState>();
}

class GameDetailsPage extends Page<GameDetailsState, Map<String, dynamic>>
    with SingleTickerProviderMixin {
  static final String pageName = "GameDetailsPage";
  GameDetailsPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameDetailsState>(
              adapter: null,
              slots: <String, Dependent<GameDetailsState>>{
                game_details.GameDetailsComponent.componentName:
                    GameDetailsComponentConnector() +
                        game_details.GameDetailsComponent(),
                game_rebate.GameDetailsRebateComponent.componentName:
                    GameRebateComponentConnector() +
                        game_rebate.GameDetailsRebateComponent(),
                game_deal.GameDetailsDealFragment.componentName:
                    GameDealComponentConnector() +
                        game_deal.GameDetailsDealFragment(),
                game_gift.GameDetailsGiftFragment.componentName:
                    GameGiftComponentConnector() +
                        game_gift.GameDetailsGiftFragment(),
                GameDetailCouponComponent.componentName:
                    GameCouponComponentConnector() +
                        GameDetailCouponComponent(),
                GameCommunityComponent.componentName:
                GameCommunityComponentConnector() +
                    GameCommunityComponent(),
              }),
          middleware: <Middleware<GameDetailsState>>[],
          viewMiddleware: <ViewMiddleware<GameDetailsState>>[
            loadingRefreshViewMiddleware<GameDetailsState>(
                GameDetailsActionCreator.init()),
          ],
        );
}
