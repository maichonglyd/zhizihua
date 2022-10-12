import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/download_game_item/component.dart';
import 'package:flutter_huoshu_app/component/game/download_game_item/state.dart'
    as download_game_item_status;

import '../state.dart';
import 'reducer.dart';

class DownloadGameListAdapter
    extends DynamicFlowAdapter<DownLoadGameListState> {
  DownloadGameListAdapter()
      : super(
          pool: <String, Component<Object>>{
            DownloadGameItemComponent.componentName: DownloadGameItemComponent(),
          },
          connector: _DownloadGameListConnector(),
          reducer: buildReducer(),
        );
}

class _DownloadGameListConnector
    extends ConnOp<DownLoadGameListState, List<ItemBean>> {
  @override
  List<ItemBean> get(DownLoadGameListState state) {
    return state.games
        .map((game) => ItemBean(
            DownloadGameItemComponent.componentName,
            download_game_item_status.initState(game,
                isDown: true,
                isReserved: state.status == 2 ? true : false,
                isFromDownloadManagerPage: true)))
        .toList();
  }

  @override
  void set(DownLoadGameListState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
