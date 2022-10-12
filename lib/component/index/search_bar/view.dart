import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'state.dart';

Widget buildView(
    SearchBarState state, Dispatch dispatch, ViewService viewService) {
  return AppBar(
    elevation: 0,
    //不自动添加返回键
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            child: Container(
                margin: EdgeInsets.only(left: 17),
                padding: EdgeInsets.only(left: 8),
                alignment: Alignment.center,
                height: 32,
                decoration: BoxDecoration(
                    color: Color(0xfff0f2f5),
                    borderRadius: BorderRadius.all(Radius.circular(17))),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      "images/ng_home_searchbar_icon.png",
                      width: 20,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: state.hint,
                            contentPadding: EdgeInsets.only(left: 10),
                            counterText: "",
                            enabled: state.enableEdit),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                      ),
                    )
                  ],
                )),
            onTap: () {
              if (!state.enableEdit) {
                println("跳转");
              }
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Image.asset("images/n_navbar_download_icon_dark.png"),
        ),
        Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.only(right: 8),
          child: Stack(
            children: <Widget>[
              new Align(
                  child: Container(
                child: Image.asset("images/n_navbar_messagebox_icon.png"),
                alignment: Alignment.center,
              )),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                    width: 16,
                    height: 16,
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Stack(
                      children: <Widget>[
                        Text(
                          state.msgCount,
                          style: TextStyle(
                              fontSize: 10,
                              textBaseline: TextBaseline.ideographic,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      alignment: Alignment.center,
                    )),
              )
            ],
          ),
        )
      ],
    ),
    leading: null,
    titleSpacing: 0,
  );
}

//}
