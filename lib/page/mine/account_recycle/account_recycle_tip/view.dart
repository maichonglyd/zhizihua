import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AccountRecycleTipState state, Dispatch dispatch, ViewService viewService) {
  return AnimatedPadding(
      padding: MediaQuery.of(viewService.context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: viewService.context,
        child: Center(
          child: SizedBox(
            width: 179,
            height: 350,
            child: Column(
              children: <Widget>[
                Image.asset(
                  "images/picture_wenan.png",
                  height: 250,
                  width: 179,
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(viewService.context);
                    },
                    child: Image.asset(
                      "images/button_wozhidaole.png",
                      height: 50,
                      width: 136,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ));
}
