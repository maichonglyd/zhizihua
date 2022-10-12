import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action hide Action, Page;

class GalleryState implements Cloneable<GalleryState> {
  List<String> urls;
  PageController pageController;
  @override
  GalleryState clone() {
    return GalleryState()
      ..urls = urls
      ..pageController = pageController;
  }
}

GalleryState initState(Map<String, dynamic> args) {
  return GalleryState()
    ..urls = args['urls']
    ..pageController = PageController(initialPage: args['initIndex']);
}
