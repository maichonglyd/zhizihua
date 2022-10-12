import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'package:flutter_huoshu_app/component/index/index_banner/state.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/global_store/state.dart';
import 'package:flutter_huoshu_app/model/image_vo.dart';
import 'package:flutter_huoshu_app/component/index/search_bar/component.dart'
    as search_bar;

class IndexFragmentState with GlobalBaseState<IndexFragmentState> {
  String searchBarHint;
  int tabIndex = 0;
  ScrollController scrollController;
  IndexBannerState indexBannerState;
  List<ImageVO> imageVOs;

  @override
  IndexFragmentState clone() {
    return IndexFragmentState()
      ..copyGlobalFrom(this)
      ..searchBarHint = searchBarHint
      ..tabIndex = tabIndex
      ..scrollController = scrollController
      ..imageVOs = imageVOs
      ..indexBannerState = indexBannerState;
  }
}

IndexFragmentState initState(Map<String, dynamic> args) {
  //just demo, do nothing here...
  return IndexFragmentState()
    ..scrollController = new ScrollController()
    ..imageVOs = [
      ImageVO(
          "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=4115938130,1681348589&fm=26&gp=0.jpg",
          "http://baidu.com",
          1,
          null),
      ImageVO(
          "http://hbimg.b0.upaiyun.com/a8ab35c38fba6bb1de75019b07cc142e80658c625e152-YKn7zA_fw658",
          "http://baidu.com",
          1,
          null),
      ImageVO(
          "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3584512889,2864203041&fm=15&gp=0.jpg",
          "http://baidu.com",
          1,
          null),
    ];
}

class SearchBarConnector
    extends ConnOp<IndexFragmentState, search_bar.SearchBarState> {
  @override
  void set(IndexFragmentState state, search_bar.SearchBarState subState) {
    super.set(state, subState);
  }

  @override
  search_bar.SearchBarState get(IndexFragmentState state) {
    return search_bar.initState(getText(name: 'textSearchGame'), false);
  }
}
