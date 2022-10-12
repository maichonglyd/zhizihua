import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'state.dart';

Widget buildView(
    IndexFragmentState state, Dispatch dispatch, ViewService viewService) {
  println("buildView:" + state.hashCode.toString());
  final ListAdapter listAdapter = viewService.buildAdapter();
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: PreferredSize(
      child: viewService.buildComponent("search_bar"),
      preferredSize: Size.fromHeight(44),
    ),
    body: ListView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: listAdapter.itemBuilder,
      itemCount: listAdapter.itemCount,
    ),
  );
}
