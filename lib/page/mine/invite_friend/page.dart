import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/mine/friends_reward/component.dart';

import 'package:flutter_huoshu_app/component/mine/mine_reward/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class InvitePage extends Page<InviteState, Map<String, dynamic>> {
  static final String pageName = "InvitePage";
  InvitePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<InviteState>(
              adapter: null,
              slots: <String, Dependent<InviteState>>{
                MineRewardComponent.componentName:
                    MineRewardConnector() + MineRewardComponent(),
                FriendRewardComponent.componentName:
                    FriendRewardConnector() + FriendRewardComponent(),
              }),
          middleware: <Middleware<InviteState>>[],
        );
}
