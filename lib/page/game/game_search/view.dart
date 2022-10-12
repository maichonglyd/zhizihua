import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameSearchState state, Dispatch dispatch, ViewService viewService) {
  ListAdapter listAdapter = viewService.buildAdapter();
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      titleSpacing: 0,
      elevation: 0,
      leading: new IconButton(
        icon: Image.asset(
          "images/icon_toolbar_return_icon_dark.png",
          width: 40,
          height: 44,
        ),
        onPressed: () {
          Navigator.pop(viewService.context);
        },
      ),
      title: Container(
        width: 243,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xFFF0F2F5),
          borderRadius: BorderRadius.all(Radius.circular(17)),
        ),
        child: TextField(
          controller: state.contentController,
          decoration: InputDecoration(
            hintText: getText(name: 'textSearchGame'),
            hintStyle:
                TextStyle(color: AppTheme.colors.hintTextColor, fontSize: 14),
            contentPadding: EdgeInsets.only(left: 15, bottom: 14),
            counterText: "",
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.transparent,
          ),
          textInputAction: TextInputAction.search,
          style: TextStyle(color: AppTheme.colors.textColor, fontSize: 14),
          onSubmitted: (text) {
            dispatch(GameSearchActionCreator.select());
          },
        ),
      ),
      actions: <Widget>[
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 14),
            child: MaterialButton(
              minWidth: 40,
              onPressed: () {
                dispatch(GameSearchActionCreator.select());
              },
              child: Text(getText(name: 'textSearch')),
              padding: EdgeInsets.all(0),
            ))
      ],
    ),
    body: IndexedStack(
      index: state.games.length > 0 ? 1 : 0,
      children: <Widget>[
        Container(
            margin: EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //2020/4/15新增热门搜索
                Container(
                  margin: EdgeInsets.all(7),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(getText(name: 'textLatestHotWord'),
                            style: TextStyle(
                                color: AppTheme.colors.textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
                Container(
                  //Wrap属性用法是,当子类的内容超过一行时,自动换行
                  margin: EdgeInsets.all(14),
                  child: Wrap(
                      children: state.hotGames
                          .asMap()
                          .keys
                          .map((index) => (state.hotGames[index].game != null
                              ? GestureDetector(
                                  onTap: () {
                                    state.contentController.text =
                                        state.hotGames[index].game.gameName;
                                    dispatch(GameSearchActionCreator.select());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffF8F8F8),
                                      border: new Border.all(
                                        width: 1,
                                        color: Color(0xFFFFD32F),
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    margin: EdgeInsets.only(right: 5, top: 4),
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 6, bottom: 6),
                                    child: Text(
                                        state.hotGames[index].game.gameName,
                                        style: TextStyle(
                                          color: AppTheme.colors.textSubColor,
                                          fontSize: 12,
                                        )),
                                  ),
                                )
                              : Container()))
                          .toList()),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      getText(name: 'textSearchHistory'),
                      style: TextStyle(
                          color: AppTheme.colors.textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )),
                    Icon(
                      Icons.delete_outline,
                      size: 12,
                    ),
                    GestureDetector(
                        onTap: () {
                          dispatch(GameSearchActionCreator.clear());
                        },
                        child: Text(
                          getText(name: 'textClearHistory'),
                          style: TextStyle(
                              color: AppTheme.colors.textSubColor2,
                              fontSize: 10),
                        )),
                  ],
                ),
                Wrap(
                    children: state.gameHistoryList
                        .asMap()
                        .keys
                        .map((index) => GestureDetector(
                              onTap: () {
                                state.contentController.text =
                                    state.gameHistoryList[index].key;
                                dispatch(GameSearchActionCreator.select());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: new Border.all(
                                        width: 1, color: Color(0xFFF5F5F5)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                margin: EdgeInsets.only(right: 5, top: 4),
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 6, bottom: 6),
                                child: Text(state.gameHistoryList[index].key,
                                    style: TextStyle(
                                      color: AppTheme.colors.textSubColor,
                                      fontSize: 12,
                                    )),
                              ),
                            ))
                        .toList())
              ],
            )),
        Container(
          child: ListView.builder(
            itemBuilder: listAdapter.itemBuilder,
            itemCount: listAdapter.itemCount,
          ),
        )
      ],
    ),
  );
}
