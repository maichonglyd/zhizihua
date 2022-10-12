import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GalleryState state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    child: Container(
        child: PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(state.urls[index]),
          initialScale: PhotoViewComputedScale.contained,
          heroTag: state.urls[index],
        );
      },
      itemCount: state.urls.length,
//      loadingChild: widget.loadingChild,
//      backgroundDecoration: widget.backgroundDecoration,
      pageController: state.pageController,
//      onPageChanged: onPageChanged,
    )),
    onTap: () {
      dispatch(GalleryActionCreator.back());
    },
  );
}
